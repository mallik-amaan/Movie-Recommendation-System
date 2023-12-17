import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mrs/Screens/ForYou.dart';
import 'package:mrs/Screens/MovieDetails.dart';
import 'package:mrs/Screens/PlotSearch.dart';
import 'package:mrs/Screens/homescreen.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'Screens/Favourites.dart';
import 'Screens/Login.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'firebase_options.dart';
void main() async {
  // Initialize Hive
  await Hive.initFlutter();

  // Open the Hive box
  var box = await Hive.openBox("localDatabase");

  // Initialize Firebase
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  var Host = '127.0.0.1';
  var Port = 5000;

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Login(),
    );
  }
}