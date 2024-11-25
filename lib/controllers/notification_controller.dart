import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:quandry/controllers/profile_controller.dart';

class NotificationController extends GetxController {
  final ProfileController controller = Get.put(ProfileController());


  RxString actionTaken = "".obs;
  RxString notification_type = "".obs;
  RxString requester_id = "".obs;
  RxString sent_at = "".obs;
  RxBool loading = false.obs;

  Future<void> acceptRequest(String requester_id, String notification_id) async {
    try{
      loading.value = true;

      controller.followers.add(requester_id);

      await FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser!.uid).update({
        "followers": FieldValue.arrayUnion([requester_id]),
        "incoming_requests": FieldValue.arrayRemove([requester_id]),
      });

      await FirebaseFirestore.instance.collection("users").doc(requester_id).update({
        "following": FieldValue.arrayUnion([FirebaseAuth.instance.currentUser!.uid]),
        "requested": FieldValue.arrayRemove([FirebaseAuth.instance.currentUser!.uid]),
      });

      await FirebaseFirestore.instance.collection("notifications").doc(FirebaseAuth.instance.currentUser!.uid).collection("notifications").doc(notification_id).update({
        "action_taken": "Accepted"
      });
      actionTaken.value = "Accepted";

      loading.value = false;
    } catch(e){
      loading.value = false;
      debugPrint("Error while accepting request: $e");
    }
  }

  Future<void> rejectRequest(String requester_id, String notification_id) async {
    try{
      loading.value = true;

      await FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser!.uid).update({
        "incoming_requests": FieldValue.arrayRemove([requester_id]),
      });

      await FirebaseFirestore.instance.collection("users").doc(requester_id).update({
        "requested": FieldValue.arrayRemove([FirebaseAuth.instance.currentUser!.uid]),
      });

      await FirebaseFirestore.instance.collection("notifications").doc(FirebaseAuth.instance.currentUser!.uid).collection("notifications").doc(notification_id).update({
        "action_taken": "Rejected"
      });

      actionTaken.value = "Rejected";

      loading.value = false;
    } catch(e){
      loading.value = false;
      debugPrint("Error while rejecting request: $e");
    }
  }

  Future<void> seenNotifications () async {
    try{
      await FirebaseFirestore.instance.collection("notifications").doc(FirebaseAuth.instance.currentUser!.uid).update({
        "read_all": true,
      });
    } catch(e){
      debugPrint("Error while doing read_all to true: $e");
    }
  }

}