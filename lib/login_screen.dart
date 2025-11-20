import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:luxury_chauffeur/app_colors.dart';
import 'package:luxury_chauffeur/main.dart';

import 'firestore_variables.dart';
import 'navigation_bar.dart';

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
  runApp(App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LoginScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class LoginScreen extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  /// Validates the login
  Future<bool> isValidLogin(context) async {
    if (await FirestoreVariables.exists(FirestoreVariables.accountCollection,
        'email', _emailController.text.toLowerCase().trim())) {
      return fetchUser(_emailController.text);
    }
    return false;
  }

  /// Fetches the current user's information from the firestore database
  Future<bool> fetchUser(String email) async {
    email = email.toLowerCase();
    try {
      final QuerySnapshot querySnapshot = await FirestoreVariables.accountCollection
          .where('email', isEqualTo: email).limit(1).get();
      // print('////////////////////////////////////////////////////////');
      // print(querySnapshot);
      // print('////////////////////////////////////////////////////////');

      if (querySnapshot.docs.isNotEmpty) {
        final DocumentSnapshot docSnapshot = querySnapshot.docs.first;
        // print('////////////////////////////////////////////////////////');
        // print(docSnapshot.id);
        // print('////////////////////////////////////////////////////////');

        //This is the id of the object in the firestore collection
        final Map<String, dynamic>? data = docSnapshot.data() as Map<String, dynamic>?;

        if (data != null && data.containsKey('email')) {
          if (_passwordController.text.trim() == data['password']) {
            return true;
          }
          return false;
        }

      }
    } catch (e) {
      print("Error: $e");
      return false;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkBackground,
      body: Padding(
        padding: EdgeInsets.all(30),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Card(
                  child: Padding(
                    padding: EdgeInsets.all(50),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text('Login', style: TextStyle(fontSize: 24)),
                        SizedBox(height: 20,),
                        TextField(
                          controller: _emailController,
                          decoration: InputDecoration(labelText: 'Email'),
                        ),
                        TextField(
                          controller: _passwordController,
                          obscureText: true,
                          decoration: InputDecoration(labelText: 'Password'),
                        ),
                        SizedBox(height: 20,),
                        ElevatedButton(
                          onPressed: () async {
                            if (await isValidLogin(context)) {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => BottomNavigationBarExample(email: _emailController.text.trim()))
                              );
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text("Invalid Login"))
                              );
                            }
                          },
                          child: Text('Login', style: TextStyle(fontSize: 18),),
                          style: ButtonStyle(
                              backgroundColor: WidgetStateProperty.all(AppColors.darkBackground),
                              foregroundColor: WidgetStateProperty.all(AppColors.lightBackground),
                              shape: WidgetStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
                              fixedSize: WidgetStateProperty.all(Size(120, 30))
                          ),
                        ),
                        TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => RegisterScreen())
                              );
                            },
                            child: Text("Don't Have an Account?")
                        ),
                      ],
                    ),
                  )
              ),
            ],
          ),
        ),
      ),
    );
  }
}



class RegisterScreen extends StatelessWidget {
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController roleController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  ///Adds an account to the database
  Future<bool> addAccount() async {
    // Test Code
    // print('///////////////////////////////////////////////////////////');
    // print(FirestoreVariables.isValidName(firstNameController.text));
    // print(FirestoreVariables.isValidName(lastNameController.text));
    // print(await FirestoreVariables.isValidEmail(emailController.text));
    // print(FirestoreVariables.isValidPhone(phoneController.text));
    // // print(FirestoreVariables.isValidRole(roleController.text));
    // print(FirestoreVariables.isValidPassword(passwordController.text, confirmPasswordController.text));
    // print('///////////////////////////////////////////////////////////');

    if (FirestoreVariables.isValidName(firstNameController.text)
        && FirestoreVariables.isValidName(lastNameController.text)
        && await FirestoreVariables.isValidEmail(emailController.text)
        && FirestoreVariables.isValidPhone(phoneController.text)
        && FirestoreVariables.isValidPassword(passwordController.text, confirmPasswordController.text)
        /* && FirestoreVariables.isValidRole(roleController.text)*/) {
      Future.delayed(Duration(seconds: 5));
      await FirestoreVariables.accountCollection.add(
          {'firstName': firstNameController.text.trim(),
            'lastName': lastNameController.text.trim(),
            'email': emailController.text.toLowerCase().trim(),
            'phone': phoneController.text.trim(),
            'password': passwordController.text.trim(),
            /*'role': roleController.text.trim()*/});
      print("adding account");
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkBackground,
      body: Padding(
        padding: EdgeInsets.all(30),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Card(
                child: Padding(
                  padding: EdgeInsets.all(50),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text('Registration', style: TextStyle(fontSize: 24)),
                      SizedBox(height: 20,),
                      TextField(
                        controller: firstNameController,
                        decoration: InputDecoration(labelText: 'First Name'),
                      ),
                      TextField(
                        controller: lastNameController,
                        decoration: InputDecoration(labelText: 'Last Name'),
                      ),
                      TextField(
                        controller: emailController,
                        decoration: InputDecoration(labelText: 'Email'),
                      ),
                      TextField(
                        controller: phoneController,
                        decoration: InputDecoration(labelText: 'Phone Number'),
                      ),
                      TextField(
                        controller: passwordController,
                        decoration: InputDecoration(labelText: 'Password'),
                        obscureText: true,
                      ),
                      TextField(
                        controller: confirmPasswordController,
                        decoration: InputDecoration(labelText: 'Confirm Password'),
                        obscureText: true,
                      ),
                      SizedBox(height: 20,),
                      ElevatedButton(
                        onPressed: () async {
                          bool complete = await addAccount();
                          if (complete) {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LoginScreen())
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text("Invalid Input"))
                            );
                          }
                        },
                        child: Text('Register', style: TextStyle(fontSize: 18),),
                        style: ButtonStyle(
                          backgroundColor: WidgetStateProperty.all(AppColors.darkBackground),
                          foregroundColor: WidgetStateProperty.all(AppColors.lightBackground),
                          shape: WidgetStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
                          fixedSize: WidgetStateProperty.all(Size(120, 30))
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => LoginScreen())
                          );
                        },
                        child: Text("Already Have an Account?")
                      ),
                    ],
                  ),
                )
              ),
            ],
          ),
        ),
      ),
    );
  }
}

