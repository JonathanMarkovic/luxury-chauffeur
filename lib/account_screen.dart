import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:luxury_chauffeur/app_colors.dart';
import 'package:luxury_chauffeur/firestore_variables.dart';
import 'package:luxury_chauffeur/login_screen.dart';

// Future<void> main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp(
//       options: FirebaseOptions(
//           apiKey: "AIzaSyADymL5C8e-mrRILQ4nBL1mLD-QWvRD6Kw",
//           appId: "698535253878",
//           messagingSenderId: "1:698535253878:android:0fdb02348086e33e61cc57",
//           projectId: "lux-rides-6312b"
//       )
//   );
//   runApp(MyApp());
// }

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: AccountScreen(email: ''),
    );
  }
}

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key, required this.email});

  final String email;

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {

  String firstName = '';
  String email = '';
  String lastName = '';
  String phone = '';
  String role = '';
  String id = '';

  /// Fetches the current user's information from the firestore database
  Future<void> fetchUser(String email) async {
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
        id = docSnapshot.id;
        final Map<String, dynamic>? data = docSnapshot.data() as Map<String, dynamic>?;

        if (data != null && data.containsKey('email')) {
          // print('////////////////////////////////////////////////////////');
          // print(data);
          // print('////////////////////////////////////////////////////////');
          setState(() {

          firstName = data['firstName'] ?? '';
          lastName = data['lastName'] ?? '';
          phone = data['phone'] ?? '';
          role = data['role'] ?? '';
          this.email = data['email'] ?? '';
          // print('////////////////////////////////////////////////////////');
          // print(email);
          // print('////////////////////////////////////////////////////////');
          });

        }
      }
    } catch (e) {
      print("Error: $e");
      return null;
    }
  }

  /// Handles the updating of an account
  Future<void> updateAccount(String id, String newFirstName, String newLastName,
      String newEmail, String newPhone, String newRole) async {
    if (FirestoreVariables.isValidName(firstName) && FirestoreVariables.isValidName(lastName)
    && await FirestoreVariables.isValidEmail(email) && FirestoreVariables.isValidPhone(phone)
    && FirestoreVariables.isValidRole(role)) {
      await FirestoreVariables.accountCollection.doc(id).update(
          {'firstName': newFirstName, 'lastName': newLastName, 'email': newEmail,
          'phone': newPhone, 'role': newRole});
    }
  }
  @override
  void initState() {
    super.initState();
    // fetchUser(widget.email);

    // Test Code
    fetchUser("bob.robert@gmail.com");
    // fetchUser("bob.test@gmail.com");
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: AppColors.darkBackground,
      appBar: AppBar(
        backgroundColor: AppColors.darkBackground,
        centerTitle: true,
        title: Text('Account', style: TextStyle(color: Colors.white, fontSize: 30),),
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Card(
                  color: Colors.white,
                  child: Column(
                    children: [
                      ListTile(
                        title: Text('Personal Information', style: TextStyle(fontSize: 22),),
                        trailing: TextButton(
                          onPressed: () {},
                          child: Text('Edit', style: TextStyle(fontSize: 18),),
                        ),
                      ),
                      ListTile(
                        title: Text('First Name'),
                        trailing: Text('${firstName}'),
                      ),
                      ListTile(
                        title: Text('Last Name'),
                        trailing: Text('${lastName}'),
                      ),
                      ListTile(
                        title: Text('Email'),
                        trailing: Text('${email}'),
                      ),
                      ListTile(
                        title: Text('Phone Number'),
                        trailing: Text('${phone}'),
                      )
                    ],
                  ),
                ),
                ElevatedButton(
                  onPressed: () {},
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Logout ', style: TextStyle(fontSize: 18, color: AppColors.darkBackground),),
                      Icon(Icons.logout, color: AppColors.darkBackground,)
                    ],
                  ),
                  style: ButtonStyle(
                    shape: WidgetStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
                    fixedSize: WidgetStateProperty.all(Size(120, 30)),
                    backgroundColor: WidgetStateProperty.all<Color>(Colors.white),
                  ),
                ),
              ],
            )
          ],
        ),
      )
    );
  }
}
