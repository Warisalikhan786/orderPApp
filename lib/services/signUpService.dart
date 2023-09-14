// ignore_for_file: file_names, non_constant_identifier_names, avoid_print, unused_local_variable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_oda/views/loginScreen.dart';
import 'package:get/get.dart';

class UserSignUpService {
  static UserSignUp(
      BuildContext context,
      TextEditingController userNameController,
      TextEditingController userEmailController,
      TextEditingController userPasswordController) async {
    User? currentUser = FirebaseAuth.instance.currentUser;

    Map<String, dynamic> userData = {
      'userId': currentUser?.uid,
      'userName': userNameController.text.trim(),
      'userEmail': userEmailController.text.trim(),
      'userImg': "",
      'userPhone': "",
      'createdAt': DateTime.now(),
    };
    try {
      await FirebaseFirestore.instance
          .collection("users")
          .doc(currentUser!.uid)
          .set(userData)
          .then((value) => {
                FirebaseAuth.instance.signOut(),
                Get.offAll(() => const LoginScreen()),
              });
    } on FirebaseAuthException catch (e) {
      print("Error: $e");
    }
  }
}
