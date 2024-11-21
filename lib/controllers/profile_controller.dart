import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:io'; // For SocketException
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:intl/intl.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class ProfileController extends GetxController {
  RxString profilePicture = ''.obs;
  RxString temporary_pic = ''.obs;
  RxString name = ''.obs;
  RxString bio = ''.obs;
  RxString phone_number = ''.obs;
  RxList<String> followers = <String>[].obs;
  RxList<String> following = <String>[].obs;
  RxString email = "".obs;
  RxString location = "".obs;
  RxString joined = ''.obs;
  RxString profileType = 'Public'.obs;
  RxBool verified = false.obs;
  RxList<String> favourites = <String>[].obs;
  RxList<Map<String, dynamic>> events = <Map<String, dynamic>>[].obs;
  RxBool loading = false.obs;
  RxBool userDataFetched = false.obs;
  RxString errorOccurred = "".obs;

  var firestore = FirebaseFirestore.instance;
  var auth = FirebaseAuth.instance.currentUser!;


  Future<void> getUserData() async {
    try {
      loading.value = true;

      var connectivityResult = await Connectivity().checkConnectivity();
      if (connectivityResult == ConnectivityResult.none) {
        errorOccurred.value = "No Internet!\nPLease make sure internet is available";
        throw SocketException('No internet connection');
      }


      var userDoc = await firestore.collection('users').doc(auth.uid).get();

      if (userDoc.exists) {
        var user = userDoc.data();

        profilePicture.value = user?['profile_pic'] ?? '';
        name.value = user?['name'] ?? 'Unknown User';
        bio.value = user?['bio'] ?? '';
        phone_number.value = user?['phone_number'] ?? 'Unknown User';
        followers.value = List<String>.from(user!['followers'] ?? []);
        following.value = List<String>.from(user['following'] ?? []);
        email.value = user['email'] ?? '';
        verified.value = user['verified'] ?? false;
        location.value = user['location'] ?? 'Unknown';
        joined.value = formatTimestampToDate(user['joined']!);
        profileType.value = user['profile_type'] ?? 'Public';
        favourites.value = List<String>.from(user['favourites'] ?? []);
        events.value = List<Map<String, dynamic>>.from(user['events'] ?? []);

        userDataFetched.value = true;
      } else {
        debugPrint('User not found in Firestore.');
        errorOccurred.value = "User not found in database.";
      }
    } on FirebaseException catch (e) {
      if (e.code == 'permission-denied') {
        errorOccurred.value = "Permission denied. Check Firestore rules.";
        Get.snackbar("Error", "Permission denied. Contact admin.", colorText: Colors.red);
      } else if (e.code == 'unavailable') {
        errorOccurred.value = "Firestore service is unavailable.";
        Get.snackbar("Error", "Firestore service is unavailable. Try again later.", colorText: Colors.red);
      } else {
        errorOccurred.value = e.message ?? "An unknown Firestore error occurred.";
        Get.snackbar("Error", e.message ?? "An unknown error occurred", colorText: Colors.red);
      }
    } catch (e) {
      errorOccurred.value = "An unexpected error occurred: $e";
      Get.snackbar("Error", "An unexpected error occurred", colorText: Colors.red);
      debugPrint('Unexpected error: $e');
    } finally {
      loading.value = false;
    }
  }

  Future<Map<String, String>> getCurrentLocation() async {
    try {
      // Check and request location permissions
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          throw Exception("Location permissions are denied");
        }
      }

      if (permission == LocationPermission.deniedForever) {
        throw Exception("Location permissions are permanently denied");
      }

      // Get the current position
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      // Perform reverse geocoding to get address details
      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );

      if (placemarks.isNotEmpty) {
        Placemark place = placemarks[0];
        location.value = "${place.locality}, ${place.country}";

        await firestore.collection("users").doc(auth.uid).update({
          'location': location.value,
        });

        return {
          "city": place.locality ?? "Unknown City",
          "country": place.country ?? "Unknown Country",
        };
      } else {
        throw Exception("No placemarks found for the current location");
      }
    } catch (e) {
      throw Exception("Error getting location: $e");
    }
  }

  String formatTimestampToDate(Timestamp timestamp) {
    // Convert the timestamp to a DateTime object
    DateTime dateTime = timestamp.toDate();

    // Format the DateTime into the desired string format
    String formattedDate = DateFormat('d MMM, y').format(dateTime);

    // Return the formatted string
    return formattedDate;
  }
}