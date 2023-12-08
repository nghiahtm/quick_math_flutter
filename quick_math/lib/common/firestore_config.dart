import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class FireStoreConfig {
  static FirebaseFirestore? fireStore;

  static void initFirebase(){
    fireStore = FirebaseFirestore.instance;
  }

}