// ignore_for_file: file_names, unused_local_variable, non_constant_identifier_names, prefer_const_constructors, avoid_print

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_oda/views/homeScreen.dart';
import 'package:get/get.dart';

import '../widgets/customProgressBar.dart';

class LoginService {
  static UserLogin(userEmail, userPassword, BuildContext context) async {
    try {
      showDialog(
          barrierDismissible: false,
          context: context,
          builder: (BuildContext context) {
            return CustomProgressBar(
              message: "Please Wait..",
            );
          });
      final User? firebaseUser = (await FirebaseAuth.instance
              .signInWithEmailAndPassword(
                  email: userEmail, password: userPassword))
          .user;

      if (firebaseUser != null) {
        Get.offAll(() => HomeScreen());
      } else {
        print("Invalid details");
      }
    } on FirebaseAuthException catch (e) {
      print("Error $e");
      Navigator.pop(context);
    }
  }
}
