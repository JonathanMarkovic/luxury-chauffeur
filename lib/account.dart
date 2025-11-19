import 'dart:ui';
import 'package:async/async.dart';
import 'package:rxdart/rxdart.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Account {
  late String _id;
  late String _firstName;
  late String _lastName;
  late String _email;
  late String _phone;
  late String _password;

  static final CollectionReference accounts =
      FirebaseFirestore.instance.collection('accounts');

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

  Account.name(this._id, this._firstName, this._lastName, this._email,
      this._phone, this._password);

  Future<bool> createAccount(String firstName, String lastName, String email,
      String phone, String password, String confirmPassword) async {
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
    await accounts.add({
      'firstname': firstName,
      'lastName': lastName,
      'email': email,
      'phone': phone,
      'password': password
    });

    return true;
  }

  // Future<bool> login(String email, String password) async {}

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Account &&
          runtimeType == other.runtimeType &&
          _firstName == other._firstName &&
          _lastName == other._lastName &&
          _email == other._email &&
          _phone == other._phone &&
          _password == other._password;

  @override
  int get hashCode =>
      _firstName.hashCode ^
      _lastName.hashCode ^
      _email.hashCode ^
      _phone.hashCode ^
      _password.hashCode;

  @override
  String toString() {
    return 'Account{_firstName: $_firstName, _lastName: $_lastName, _email: $_email, _phone: $_phone}';
  }

  String get phone => _phone;

  String get email => _email;

  String get lastName => _lastName;

  String get firstName => _firstName;

  String get password => _password;

  set password(String value) {
    _password = value;
  }

  set phone(String value) {
    _phone = value;
  }

  set email(String value) {
    _email = value;
  }

  set lastName(String value) {
    _lastName = value;
  }

  set firstName(String value) {
    _firstName = value;
  }
}
