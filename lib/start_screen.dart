import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:luxury_chauffeur/app_colors.dart';
import 'package:luxury_chauffeur/login_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: FirebaseOptions(
          apiKey: "AIzaSyADymL5C8e-mrRILQ4nBL1mLD-QWvRD6Kw",
          appId: "698535253878",
          messagingSenderId: "1:698535253878:android:0fdb02348086e33e61cc57",
          projectId: "lux-rides-6312b"
      )
  );
  runApp(StartScreen());
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
            Text('Already Have An Account?', style: TextStyle(color: AppColors.lightBackground, fontSize: 18),),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginScreen())
                );
              },
              child: Text('Login', style: TextStyle(fontSize: 18),),
              style: ButtonStyle(
                backgroundColor: WidgetStateProperty.all(AppColors.lightBackground),
                foregroundColor: WidgetStateProperty.all(AppColors.darkBackground),
                shape: WidgetStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
                fixedSize: WidgetStateProperty.all(Size(120, 30))
              ),
            ),
            SizedBox(height: 16,),
            Text("Don't Have An Account?", style: TextStyle(color: AppColors.lightBackground, fontSize: 18),),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RegisterScreen())
                );
              },
              child: Text('Register', style: TextStyle(fontSize: 18)),
              style: ButtonStyle(
                backgroundColor: WidgetStateProperty.all(AppColors.lightBackground),
                foregroundColor: WidgetStateProperty.all(AppColors.darkBackground),
                shape: WidgetStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
                fixedSize: WidgetStateProperty.all(Size(120, 30)),
              ),
            )
          ],
        ),
      ),
    );
  }
}
