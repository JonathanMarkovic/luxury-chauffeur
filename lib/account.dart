import 'dart:ui';
import 'package:async/async.dart';
import 'package:luxury_chauffeur/login_screen.dart';
import 'package:rxdart/rxdart.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future<void> main() async {
  await Firebase.initializeApp(
    options: FirebaseOptions(
        apiKey: 'AIzaSyADymL5C8e-mrRILQ4nBL1mLD-QWvRD6Kw',
        appId: "698535253878",
        messagingSenderId: "1:698535253878:android:0fdb02348086e33e61cc57",
        projectId: "lux-rides-6312b"
    )
  );
  Account.createAccount('firstName', 'lastName', 'email@email.com', '123 111 4565', 'password123!', 'password123!', 'customer');
  Account.createAccount('Bob', 'Bobert', 'test@email.com', '321 222 3333', 'password123!', 'password123!', 'customer');

  List<Account> accounts = await Account.getAllUsers();

  print(accounts.toString());

  runApp(Testing());
}

class Account {
  late String id;
  late String firstName;
  late String lastName;
  late String email;
  late String phone;
  late String password;
  late String role; //Customer, admin, guest

  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static CollectionReference accountCollection = _firestore.collection(
      'accounts');

  static final namePattern = RegExp(
      r'/^(?=[a-zA-Z\s]{2,25}$)(?=[a-zA-Z\s])(?:([\w\s*?])\1?(?!\1))+$/');
  static final emailPattern = RegExp(
      r'/^([^\x00-\x20\x22\x28\x29\x2c\x2e\x3a-\x3c\x3e\x40\x5b-\x5d\x7f-\xff]+|\x22([^\x0d\x22\x5c\x80-\xff]|\x5c[\x00-\x7f])*\x22)(\x2e([^\x00-\x20\x22\x28\x29\x2c\x2e\x3a-\x3c\x3e\x40\x5b-\x5d\x7f-\xff]+|\x22([^\x0d\x22\x5c\x80-\xff]|\x5c[\x00-\x7f])*\x22))*\x40([^\x00-\x20\x22\x28\x29\x2c\x2e\x3a-\x3c\x3e\x40\x5b-\x5d\x7f-\xff]+|\x5b([^\x0d\x5b-\x5d\x80-\xff]|\x5c[\x00-\x7f])*\x5d)(\x2e([^\x00-\x20\x22\x28\x29\x2c\x2e\x3a-\x3c\x3e\x40\x5b-\x5d\x7f-\xff]+|\x5b([^\x0d\x5b-\x5d\x80-\xff]|\x5c[\x00-\x7f])*\x5d))*$/');

  // Checks for most valid phone numbers
  static final phonePattern = RegExp(
      r'/(?:([+]\d{1,4})[-.\s]?)?(?:[(](\d{1,3})[)][-.\s]?)?(\d{1,4})[-.\s]?(\d{1,4})[-.\s]?(\d{1,9})/');

  // Checks for a password with min 6 characters 1 uppercase 1 lowercase 1 number
  static final passwordPattern =
  RegExp(r'/^((?=\S*?[A-Z])(?=\S*?[a-z])(?=\S*?[0-9]).{6,})\S$/');

  Account(
      {required this.id, required this.firstName, required this.lastName, required this.email,
        required this.phone, required this.password, required this.role});

  static Future<bool> createAccount(String firstName, String lastName,
      String email,
      String phone, String password, String confirmPassword,
      String role) async {
    if (firstName.isNotEmpty && lastName.isNotEmpty) {
      if (!namePattern.hasMatch(firstName) || !namePattern.hasMatch(lastName)) {
        return false;
      }
    }

    if (email.isNotEmpty) {
      if (!emailPattern.hasMatch(email)) {
        return false;
      }
    }

    if (password.isNotEmpty && confirmPassword.isNotEmpty) {
      if (!passwordPattern.hasMatch(password)) {
        return false;
      } else if (password.compareTo(confirmPassword) != 0) {
        return false;
      }
    }
// Should hash the passwords here
    await accountCollection.add({
      'firstname': firstName,
      'lastName': lastName,
      'email': email,
      'phone': phone,
      'password': password,
      'role': role
    });

    return true;
  }

  /**
   * Fetches the list of all users and their information
   */
  static Future<List<Account>> getAllUsers() async {
    QuerySnapshot querySnapshot = await accountCollection.get();
    List<Account> accounts = [];
    for (var doc in querySnapshot.docs) {
      print(doc.data());
      accounts.add(Account(
          id: doc.id,
          firstName: doc['firstName'],
          lastName: doc['lastName'],
          email: doc['email'],
          phone: doc['phone'],
          password: doc['password'],
          role: doc['role'])
      );
    }

    return accounts;
  }
}
  // Future<bool> login(String email, String password) async {}

class Testing extends StatelessWidget {
  const Testing({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: TestDB(),
    );
  }
}

class TestDB extends StatefulWidget {
  const TestDB({super.key});

  @override
  State<TestDB> createState() => _TestDBState();
}

class _TestDBState extends State<TestDB> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('test'),),
      body: Center(
        child: Column(
          children: [
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: Account.accountCollection.snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) return Text("Loading");
                  return ListView(
                    children: snapshot.data!.docs.map((doc) {
                      return ListTile(
                        title: Text('${doc["firstName"]} + " " + ${doc["lastName"]}'),
                        subtitle: Text("email: ${doc["email"]}"),
                      );
                    }).toList(),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
