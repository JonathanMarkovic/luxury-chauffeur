import 'package:flutter/material.dart';
import 'package:luxury_chauffeur/app_colors.dart';

void main() {
  runApp(MyStartScreenApp());
}

class MyStartScreenApp extends StatelessWidget {
  const MyStartScreenApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: StartScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class StartScreen extends StatefulWidget {
  const StartScreen({super.key});

  @override
  State<StartScreen> createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
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
            SizedBox(height: 50,),
            Text('Already Have An Account?', style: TextStyle(color: AppColors.lightBackground),),
            ElevatedButton(
              onPressed: () {

              },
              child: Text('Login'),
              style: ButtonStyle(
                backgroundColor: WidgetStateProperty.all(AppColors.lightBackground), // ✅ Correct
                foregroundColor: WidgetStateProperty.all(AppColors.darkBackground)
              ),
            ),
            SizedBox(height: 16,),
            Text("Don't Have An Account?", style: TextStyle(color: AppColors.lightBackground),),
            ElevatedButton(
              onPressed: () {

              },
              child: Text('Register'),
              style: ButtonStyle(
                backgroundColor: WidgetStateProperty.all(AppColors.lightBackground), // ✅ Correct
                foregroundColor: WidgetStateProperty.all(AppColors.darkBackground)
              ),
            )
          ],
        ),
      ),
    );
  }
}
