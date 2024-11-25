import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:quandry/const/colors.dart';
import 'package:quandry/controllers/profile_controller.dart';

class EventController extends GetxController {

  final ProfileController profileVM = Get.put(ProfileController());

  RxList followers = [].obs;
  RxList planned = [].obs;
  RxList favourite = [].obs;
  RxList attended = [].obs;
  RxList reviews = [].obs;
  RxInt selectedStars = 0.obs;
  RxBool has_given_review = false.obs;




  Future<void> followToggle (String event_id) async {
    try{

      var eventDoc = await FirebaseFirestore.instance.collection("events").doc(event_id).get();

      if(eventDoc.exists){

        var event = eventDoc.data();

        var following = List<String>.from(event!['following'] ?? []);

        if(following.contains(FirebaseAuth.instance.currentUser!.uid)){

          followers.remove(FirebaseAuth.instance.currentUser!.uid);

          await FirebaseFirestore.instance.collection("events").doc(event_id).update({
            'following': FieldValue.arrayRemove([FirebaseAuth.instance.currentUser!.uid]),
          }).then((val) {
            debugPrint("un_followed");
          });


        } else {

          followers.add(FirebaseAuth.instance.currentUser!.uid);

          await FirebaseFirestore.instance.collection("events").doc(event_id).update({
            'following': FieldValue.arrayUnion([FirebaseAuth.instance.currentUser!.uid]),
          }).then((val) {
            debugPrint("Followed");
          });


        }
      } else {
        debugPrint("THe event doc doesn't exist: ${event_id}");
      }

    }catch(e){
      debugPrint("Error in followToggle: ${e}");
    }
  }

  Future<void> favouriteToggle (String event_id, String event_name) async {
    try{

      var eventDoc = await FirebaseFirestore.instance.collection("events").doc(event_id).get();

      if(eventDoc.exists){

        var event = eventDoc.data();

        var favourited = List<String>.from(event!['favourited'] ?? []);

        if(favourited.contains(FirebaseAuth.instance.currentUser!.uid)){

          favourite.remove(FirebaseAuth.instance.currentUser!.uid);

          await FirebaseFirestore.instance.collection("events").doc(event_id).update({
            'favourited': FieldValue.arrayRemove([FirebaseAuth.instance.currentUser!.uid]),
          }).then((val) {
            debugPrint("un_favourite");

          });

          DocumentReference userDoc = FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser!.uid);


          DocumentSnapshot userSnapshot = await userDoc.get();

          List<dynamic> favouriteList = userSnapshot.get('favourites');

          // Filter the list to remove the map with the matching event_id
          favouriteList.removeWhere((favour) => favour['favourite_id'] == event_id);

          // Update the Firestore document with the modified list
          await userDoc.update({
            'favourites': favouriteList,
          });

          profileVM.favourites.value = favouriteList.toList();

        } else {

          favourite.add(FirebaseAuth.instance.currentUser!.uid);

          await FirebaseFirestore.instance.collection("events").doc(event_id).update({
            'favourited': FieldValue.arrayUnion([FirebaseAuth.instance.currentUser!.uid]),
          }).then((val){
            debugPrint("favourite");
          });

          var map = {
            "favourite_id": event_id,
            "favourite_name": event_name,
          };

          await FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser!.uid).update({
            'favourites': FieldValue.arrayUnion([map]),
          });

          profileVM.favourites.add(map);
        }
      } else {
        debugPrint("THe event doc doesn't exist: ${event_id}");
      }

    }catch(e){
      debugPrint("Error in favouriteToggle: ${e}");
    }
  }

  Future<void> suggestEdits (String event_id, String event_name, String corrections, String new_event, String complaints, String suggestion) async {
    try{
      var eventDoc = await FirebaseFirestore.instance.collection("events").doc(event_id).get();

      if(eventDoc.exists){

       await FirebaseFirestore.instance.collection('event_suggestions').doc(event_id).set({
         "event_id": event_id,
         "event_name": event_name,
         "new_event": new_event,
         "complaints": complaints,
         "corrections": corrections,
         "suggestion": suggestion,
       }, SetOptions(merge: true));

      } else {
        debugPrint("THe event doc for complaint doesn't exist: ${event_id}");
      }
    } catch(e){
      debugPrint("Error while suggesting edits for event: $e");
    }
  }

  Future<void> giveReview (String event_id, String stars) async {
    try{
      var eventDoc = await FirebaseFirestore.instance.collection("events").doc(event_id).get();

      if(eventDoc.exists){

        var review = {
          "user_id": FirebaseAuth.instance.currentUser!.uid,
          "stars": stars,
        };

        reviews.add(review);
        reviews.refresh();


        if(reviews.any((review)=> review["user_id"] == FirebaseAuth.instance.currentUser!.uid)){
          has_given_review.value = true;
        } else {
          has_given_review.value = false;
        }

        var average_rating = await calculateAverageStars(reviews);

        await FirebaseFirestore.instance.collection('events').doc(event_id).set({
         "reviews" : FieldValue.arrayUnion([review]),
         "average_rating": average_rating.toString(),
        }, SetOptions(merge: true)).then((val) {
          Get.snackbar("Review Sent", "Thank you for your time.", colorText: CupertinoColors.white, backgroundColor: AppColors.blueColor);
        });

      } else {
        debugPrint("THe event doc for reviews doesn't exist: ${event_id}");
      }
    } catch(e){
      debugPrint("Error while giving review for event: $e");
    }
  }

  Future<void> goingToggle (String event_id, String event_name, String event_date) async {
    try{
    var eventDoc = await FirebaseFirestore.instance.collection("events").doc(event_id).get();

    if(eventDoc.exists){

      var event = eventDoc.data();

      var attending = List<String>.from(event!['attending'] ?? []);

      if(attending.contains(FirebaseAuth.instance.currentUser!.uid)){

        planned.remove(FirebaseAuth.instance.currentUser!.uid);


        await FirebaseFirestore.instance.collection("events").doc(event_id).update({
          'attending': FieldValue.arrayRemove([FirebaseAuth.instance.currentUser!.uid]),
        }).then((val) {
          debugPrint("not_attending");

        });

        DocumentReference userDoc = FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser!.uid);


        DocumentSnapshot userSnapshot = await userDoc.get();

        List<dynamic> events = userSnapshot.get('events');

        // Filter the list to remove the map with the matching event_id
        events.removeWhere((event) => event['event_id'] == event_id);

        // Update the Firestore document with the modified list
        await userDoc.update({
          'events': events,
        });

        profileVM.events.value = events;

      } else {
        attended.remove(FirebaseAuth.instance.currentUser!.uid);

        if(!planned.contains(FirebaseAuth.instance.currentUser!.uid)){
          planned.add(FirebaseAuth.instance.currentUser!.uid);
        }

        await FirebaseFirestore.instance.collection("events").doc(event_id).update({
          'attending': FieldValue.arrayUnion([FirebaseAuth.instance.currentUser!.uid]),
          'attended': FieldValue.arrayRemove([FirebaseAuth.instance.currentUser!.uid]),
        }).then((val){
          debugPrint("attending");
        });

        var map = {
          "event_id": event_id,
          "event_name": event_name,
          "event_date": event_date,
        };

        await FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser!.uid).update({
          'events': FieldValue.arrayUnion([map]),
        });

        profileVM.events.add(map);


      }
    } else {
      debugPrint("THe event doc doesn't exist: ${event_id}");
    }

  } catch(e){
     debugPrint("Error in goingToggle: ${e}");
   }
  }

  Future<void> iWent (String event_id) async {
    try{
      var eventDoc = await FirebaseFirestore.instance.collection("events").doc(event_id).get();

      if(eventDoc.exists){

        planned.remove(FirebaseAuth.instance.currentUser!.uid);
        if(!attended.contains(FirebaseAuth.instance.currentUser!.uid)){
          attended.add(FirebaseAuth.instance.currentUser!.uid);
        }

        await FirebaseFirestore.instance.collection('events').doc(event_id).set({
         "attended": FieldValue.arrayUnion([FirebaseAuth.instance.currentUser!.uid]),
         "attending": FieldValue.arrayRemove([FirebaseAuth.instance.currentUser!.uid]),
        }, SetOptions(merge: true));

      } else {
        debugPrint("THe event doc for im going doesn't exist: ${event_id}");
      }
    } catch(e){
      debugPrint("Error while choosing im going for event: $e");
    }
  }

  double calculateAverageStars(List<dynamic> reviews) {
    if (reviews.isEmpty) return 0.0;

    // Extract the 'stars' field and calculate the average
    double totalStars = reviews.fold(0.0, (sum, review) => sum + (double.tryParse(review['stars']) ?? 0));
    double averageStars = totalStars / reviews.length;

    // Round to one decimal place
    return double.parse(averageStars.toStringAsFixed(1));
  }


}