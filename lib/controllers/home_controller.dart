import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:io'; // For SocketException
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:intl/intl.dart';
import 'package:quandry/controllers/profile_controller.dart';

class Homecontroller extends GetxController {
  late Future<QuerySnapshot> future;


  RxList<String> filter_topics = <String>[].obs;
  var currentCity = "".obs;
  var currentCountry = "".obs;
  var date_time = DateTime.now().obs;
  var location = "".obs;
  var city = "".obs;
  var country = "".obs;
  var state = "".obs;
  var tapped_date = "".obs;
  RxInt selected_from_price = 0.obs;
  RxInt selected_to_price = 500.obs;
  RxBool increment_for_from = true.obs;
  RxBool increment_for_to = true.obs;
  RxBool date_selected = false.obs;
  RxBool filter = false.obs;

  void incrementFromPrice(){
    selected_from_price++;
    increment_for_from.value = true;
  }
  void decrementFromPrice(){
    selected_from_price--;
    increment_for_from.value = false;
  }
  void incrementToPrice(){
    selected_to_price++;
    increment_for_to.value = true;
  }
  void decrementToPrice(){
    selected_to_price--;
    increment_for_to.value = false;
  }

  Future<QuerySnapshot> fetchEvents() async {
    return FirebaseFirestore.instance.collection('events').get();
  }

  Stream<QuerySnapshot> eventStream() {

    final CollectionReference _collectionRef = FirebaseFirestore.instance.collection('events');

    return _collectionRef.snapshots();
  }



}