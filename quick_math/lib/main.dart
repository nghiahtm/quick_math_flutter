import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:quick_math/common/firestore_config.dart';
import 'package:quick_math/common/local_pref_config.dart';
import 'package:quick_math/presentation/my_app.dart';
import 'firebase_options.dart';

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await LocalPrefConfig.initPref();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FireStoreConfig.initFirebase();
  runApp(const MyApp());
}