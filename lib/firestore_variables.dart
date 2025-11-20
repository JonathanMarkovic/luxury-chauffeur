import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

/// This class contains all necessary information for the firestore database, and
/// any functions concerning parts of the database such as checking for valid
/// inputs.
class FirestoreVariables {
  // Firestore reference(instance)
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //Account Collection
  static CollectionReference accountCollection = _firestore.collection(
      'accounts');

  //Car Collection
  static CollectionReference carCollection = _firestore.collection('cars');

  //Reservation Collection
  static CollectionReference reservationCollection = _firestore.collection('reservations');

  //Regex for firestore data
  static final namePattern = RegExp(
      r'^(?=[a-zA-Z\s]{2,25}$)(?=[a-zA-Z\s])(?:([\w\s*?])\1?(?!\1))+$');
  static final emailPattern = RegExp(
      r'^([^\x00-\x20\x22\x28\x29\x2c\x2e\x3a-\x3c\x3e\x40\x5b-\x5d\x7f-\xff]+|\x22([^\x0d\x22\x5c\x80-\xff]|\x5c[\x00-\x7f])*\x22)(\x2e([^\x00-\x20\x22\x28\x29\x2c\x2e\x3a-\x3c\x3e\x40\x5b-\x5d\x7f-\xff]+|\x22([^\x0d\x22\x5c\x80-\xff]|\x5c[\x00-\x7f])*\x22))*\x40([^\x00-\x20\x22\x28\x29\x2c\x2e\x3a-\x3c\x3e\x40\x5b-\x5d\x7f-\xff]+|\x5b([^\x0d\x5b-\x5d\x80-\xff]|\x5c[\x00-\x7f])*\x5d)(\x2e([^\x00-\x20\x22\x28\x29\x2c\x2e\x3a-\x3c\x3e\x40\x5b-\x5d\x7f-\xff]+|\x5b([^\x0d\x5b-\x5d\x80-\xff]|\x5c[\x00-\x7f])*\x5d))*$');

  // Checks for most valid phone numbers
  static final phonePattern = RegExp(
      r'(?:([+]\d{1,4})[-.\s]?)?(?:[(](\d{1,3})[)][-.\s]?)?(\d{1,4})[-.\s]?(\d{1,4})[-.\s]?(\d{1,9})');

  // Checks for a password with min 6 characters 1 uppercase 1 lowercase 1 number
  static final passwordPattern =
  RegExp(r'^((?=\S*?[A-Z])(?=\S*?[a-z])(?=\S*?[0-9]).{6,})\S$');


  /// Checks if the given phone number is valid
  /// Number should be typed with no special characters and spaces in between sections
  /// ex: 514 123 1234
  static bool isValidPhone(String phone) {
    if (phone.isNotEmpty) {
      if (phonePattern.hasMatch(phone)) {
        return true;
      }
    }
    return false;
  }

  /// Checks if the given email is valid
  /// Cannot have repeating emails
  /// emails must be in the format: email@site.com
  static Future<bool> isValidEmail(String email) async {
    email = email.toLowerCase().trim();
    if (email.isNotEmpty) {
      if (emailPattern.hasMatch(email)) {
        try {
          // final QuerySnapshot querySnapshot = await FirestoreVariables
          //     .accountCollection
          //     .where('email', isEqualTo: email).limit(1).get();
          // print('////////////////////////////////////////////////////////');
          // print(querySnapshot);
          // print('////////////////////////////////////////////////////////');

          if (await exists(accountCollection, 'email', email)) {

            //if the email exists return false(not valid)
            return false;
          } else {
            //if the email exists return true(valid)
            return true;
          }
        } catch (e) {
          print("Error: $e");
          return false;
        }
      }
    }
    return false;
  }

  /// Checks for a valid password by comparing with the regex
  /// Also checks if the password matches the password confirmation
  static bool isValidPassword(String password, String confirmPassword) {
    if (password.isNotEmpty && confirmPassword.isNotEmpty) {
      if (!passwordPattern.hasMatch(password)) {
        return false;
      } else if (password.compareTo(confirmPassword) != 0) {
        return false;
      }
    } else {
      return false;
    }
    return true;
  }

  /// Checks if the given name is valid
  static bool isValidName(String name) {
    if (name.isNotEmpty) {
      if (!namePattern.hasMatch(name)) {
        return false;
      }
      return true;
    }
    return false;
  }

  /// Checks if the given role is valid
  static bool isValidRole(String role) {
    if (role.isNotEmpty) {
      if (role.toLowerCase() == 'customer' || role.toLowerCase() == 'admin') {
        return true;
      }
    }
    return false;
  }

  /// Checks if the field exists
  static Future<bool> exists(CollectionReference collection, String fieldName, fieldValue) async {
    QuerySnapshot snapshot = await collection
        .where(fieldName, isEqualTo: fieldValue)
        .limit(1).get();

    return snapshot.docs.isNotEmpty;
  }
}