// ignore_for_file: file_names, prefer_const_constructors, sized_box_for_whitespace, avoid_unnecessary_containers, unused_local_variable, avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_oda/utils/contant.dart';
import 'package:lottie/lottie.dart';
import '../services/forgotPassword.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  TextEditingController forgotPasswordContorller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(AppContant.appName),
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.blueGrey),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                alignment: Alignment.center,
                height: 300,
                width: 300,
                child: Lottie.asset(
                  'assets/images/welcome.json',
                  fit: BoxFit.fill,
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20.0),
                child: TextFormField(
                  controller: forgotPasswordContorller,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    hintText: 'Email',
                    labelText: 'Email',
                    prefixIcon: Icon(Icons.email),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(
                        10.0,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              ElevatedButton(
                onPressed: () async {
                  if (forgotPasswordContorller.text != "") {
                    resetPassword(context, forgotPasswordContorller);
                    // try {
                    //   await FirebaseAuth.instance.sendPasswordResetEmail(
                    //       email: forgotPasswordContorller.text.trim());
                    //   print("Please check your email address");
                    //   Get.off(() => LoginService());
                    // } on FirebaseAuthException catch (e) {
                    //   print("Error: $e");
                    //   navigator!.pop(context);
                    // }
                  } else {
                    print("please enter your email");
                  }
                },
                child: Text("FORGET"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
