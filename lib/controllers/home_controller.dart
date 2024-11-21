import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:io'; // For SocketException
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:intl/intl.dart';

class Homecontroller extends GetxController {

  // Stream to fetch documents from the collection
  Stream<QuerySnapshot> eventStream() {

    final CollectionReference _collectionRef = FirebaseFirestore.instance.collection('events');


    return _collectionRef.snapshots();
  }

}