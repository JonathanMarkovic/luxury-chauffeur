import 'package:flutter/material.dart';
import 'package:luxury_chauffeur/app_colors.dart';

void main() {
  runApp(MySplashPageApp());
}

class MySplashPageApp extends StatelessWidget {
  const MySplashPageApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SplashPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkBackground,
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image(image: AssetImage('assets/luxe-rides-logo.png')),
            CircularProgressIndicator(
              backgroundColor: AppColors.accentGold,
              valueColor: AlwaysStoppedAnimation(AppColors.accentGoldHover),
              strokeWidth: 3,
            )
          ],
        ),
      )
    );
  }
}
