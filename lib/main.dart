import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

//Imports for our custom classes
import 'package:luxury_chauffeur/splash_page.dart';
import 'package:luxury_chauffeur/app_colors.dart';
import 'package:luxury_chauffeur/cars_screen.dart';
import 'package:luxury_chauffeur/firestore_variables.dart';
import 'package:luxury_chauffeur/login_screen.dart';
import 'package:luxury_chauffeur/navigation_bar.dart';
import 'package:luxury_chauffeur/notification_screen.dart';
import 'package:luxury_chauffeur/reservation_screen.dart';
import 'package:luxury_chauffeur/start_screen.dart';

import 'account_screen.dart';

void main() async {
  //This will check that everything is ready for the application to run
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: FirebaseOptions(
        apiKey: "AIzaSyADymL5C8e-mrRILQ4nBL1mLD-QWvRD6Kw",
        appId: "698535253878",
        messagingSenderId: "1:698535253878:android:0fdb02348086e33e61cc57",
        projectId: "lux-rides-6312b"
    )
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/splash',
      routes: {
        '/splash' : (context) => SplashPage(),
        '/start_screen' : (context) => StartScreen(),
        'reservation_screen' : (context) => ReservationScreen(),
        '/notification_screen' : (context) => NotificationScreen(),
        '/login_screen' : (context) => LoginScreen(),
        '/cars_screen' : (context) => CarsScreen(),
        '/account_screen' : (context) => AccountScreen(email: ''),
        '/nac_bar' : (context) => BottomNavigationBarExample(email: '')
      },
    );
  }
}
