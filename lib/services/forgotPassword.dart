// ignore_for_file: file_names, unused_element, unused_import, avoid_print

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_oda/views/loginScreen.dart';
import 'package:get/get.dart';

import '../widgets/customProgressBar.dart';

final FirebaseAuth _firebaseAuthLogin = FirebaseAuth.instance;

resetPassword(
  BuildContext context,
  TextEditingController forgortEmailController,
) async {
  showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return CustomProgressBar(
          message: "Please Wait..",
        );
      });

  try {
    await FirebaseAuth.instance
        .sendPasswordResetEmail(email: forgortEmailController.text.trim())
        .then((value) {
      print("Please check your email address!");
      Get.to(() => const LoginScreen());
      forgortEmailController.clear();
    });
  } catch (e) {
    print("Please check your email address!");
    Navigator.pop(context);
  }
}
