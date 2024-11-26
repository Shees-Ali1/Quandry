import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ChatController extends GetxController {

  Future<void> sendMessage(String message, DateTime time,TextEditingController controller) async {
    try{
      await FirebaseFirestore.instance.collection("online_support").doc(FirebaseAuth.instance.currentUser!.uid).collection("messages").add({
        "sent_at": time,
        "message": message,
        "user_uid": FirebaseAuth.instance.currentUser!.uid,
      }).then((val){
        controller.clear();
      });

      await FirebaseFirestore.instance.collection("online_support").doc(FirebaseAuth.instance.currentUser!.uid).set({
        "seen": false,
        "last_message_sent_at": time,
        "uid": FirebaseAuth.instance.currentUser!.uid,
      }, SetOptions(merge: true));

    } catch (e){
      debugPrint("Error while sending message: $e");
    }
  }

  Stream<QuerySnapshot> getMessages() {
    try {
      return FirebaseFirestore.instance
          .collection("online_support")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection("messages")
          .snapshots();
    } catch (e) {
      debugPrint("Error fetching messages: $e");
      return const Stream.empty();
    }
  }

}