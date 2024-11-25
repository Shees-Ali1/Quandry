import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:io'; // For SocketException
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:intl/intl.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:quandry/controllers/profile_controller.dart';

class OtherUserProfileController extends GetxController {
  final ProfileController profile = Get.put(ProfileController());


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
  RxString profileType = ''.obs;
  RxBool verified = false.obs;
  var favourites = [].obs;
  var events = [].obs;
  var incoming_requests = [].obs;
  var requested = [].obs;
  RxBool loading = false.obs;
  RxBool userDataFetched = false.obs;
  RxString errorOccurred = "".obs;

  var firestore = FirebaseFirestore.instance;
  var auth = FirebaseAuth.instance.currentUser!;

  Future<void> getUserData(String uid) async {
    try {
      loading.value = true;

      var connectivityResult = await Connectivity().checkConnectivity();
      if (connectivityResult == ConnectivityResult.none) {
        errorOccurred.value = "No Internet!\nPLease make sure internet is available";
        throw SocketException('No internet connection');
      }


      var userDoc = await firestore.collection('users').doc(uid).get();

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
        profileType.value = user?['profile_type'] ?? "";
        print("profile type: " + profileType.value);
        favourites.value = (user['favourites'] ?? []);
        events.value =  (user['events'] ?? []);
        requested.value = (user['requested'] ?? []);
        incoming_requests.value = (user['incoming_requests'] ?? []);

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

  Future<void> followToggle (String user_id) async {
    try{

      var userDoc = await FirebaseFirestore.instance.collection("users").doc(user_id).get();

      if(userDoc.exists){

        var user = userDoc.data();

        var followersList = List<String>.from(user!['followers'] ?? []);

        if(followersList.contains(FirebaseAuth.instance.currentUser!.uid)){

          followers.remove(FirebaseAuth.instance.currentUser!.uid);
          profile.following.remove(user_id);

          await FirebaseFirestore.instance.collection("users").doc(user_id).update({
            'followers': FieldValue.arrayRemove([FirebaseAuth.instance.currentUser!.uid]),
          });

          await FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser!.uid).update({
            'following': FieldValue.arrayRemove([user_id]),
          }).then((val) {
            debugPrint("un_followed");
          });

        } else {

          followers.add(FirebaseAuth.instance.currentUser!.uid);
          profile.following.add(user_id);

          await FirebaseFirestore.instance.collection("users").doc(user_id).update({
            'followers': FieldValue.arrayUnion([FirebaseAuth.instance.currentUser!.uid]),
          });

          await FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser!.uid).update({
            'following': FieldValue.arrayUnion([user_id]),
          }).then((val) {
            debugPrint("Followed");
          });

          final notificationsRef = FirebaseFirestore.instance
              .collection("notifications")
              .doc(user_id)
              .collection("notifications");

          final docRef = notificationsRef.doc();

          final notificationData = {
            "requester_id": FirebaseAuth.instance.currentUser!.uid,
            "notification_type": "Followed",
            "sent_at": DateTime.now(),
            "action_taken": "",
            "notification_id": docRef.id, // Include the generated document ID
          };

          await docRef.set(notificationData);


        }
      } else {
        debugPrint("THe user doc doesn't exist: ${user_id}");
      }

    }catch(e){
      debugPrint("Error in followToggle for user: ${e}");
    }
  }

  Future<void> followRequestToggle (String user_id) async {
    try{

      var userDoc = await FirebaseFirestore.instance.collection("users").doc(user_id).get();

      if(userDoc.exists){

        var user = userDoc.data();

        var requestedList = List<String>.from(user!['incoming_requests'] ?? []);

        if(requestedList.contains(FirebaseAuth.instance.currentUser!.uid)){

          profile.requested.remove(user_id);
          incoming_requests.remove(FirebaseAuth.instance.currentUser!.uid);

          await FirebaseFirestore.instance.collection("notifications").doc(user_id).set({
            "read_all": false,
          }, SetOptions(merge: true));

          await FirebaseFirestore.instance.collection("notifications").doc(user_id).collection("notifications").doc(FirebaseAuth.instance.currentUser!.uid).delete();

          await firestore.collection("users").doc(user_id).update({
            "incoming_requests": FieldValue.arrayRemove([FirebaseAuth.instance.currentUser!.uid]),
          });

          await FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser!.uid).update({
            'requested': FieldValue.arrayRemove([user_id]),
          }).then((val) {
            debugPrint("un_requested");
          });

        } else {
          if(!profile.requested.contains(user_id)){
            profile.requested.add(user_id);
            incoming_requests.add(FirebaseAuth.instance.currentUser!.uid);
          }

          await firestore.collection("users").doc(user_id).update({
            "incoming_requests": FieldValue.arrayUnion([FirebaseAuth.instance.currentUser!.uid]),
          });

          // Reference to the subcollection
          final notificationsRef = FirebaseFirestore.instance
              .collection("notifications")
              .doc(user_id)
              .collection("notifications");

// Create a new document with a random ID
          final docRef = notificationsRef.doc();

// Data to store in the document
          final notificationData = {
            "requester_id": FirebaseAuth.instance.currentUser!.uid,
            "notification_type": "Follow request",
            "sent_at": DateTime.now(),
            "action_taken": "",
            "notification_id": docRef.id, // Include the generated document ID
          };

// Save the document
          await docRef.set(notificationData);


          await FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser!.uid).update({
            'requested': FieldValue.arrayUnion([user_id]),
          }).then((val) {
            debugPrint("requested");
          });

        }
      } else {
        debugPrint("THe user doc doesn't exist: ${user_id}");
      }

    }catch(e){
      debugPrint("Error in followToggle for user: ${e}");
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