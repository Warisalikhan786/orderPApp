// ignore_for_file: file_names, prefer_const_constructors, sized_box_for_whitespace, avoid_unnecessary_containers, unused_local_variable, avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_oda/services/loginService.dart';
import 'package:flutter_oda/utils/contant.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import 'forgetPasswordScreen.dart';
import 'signUpScreen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController loginEmailController = TextEditingController();
  TextEditingController loginPasswordController = TextEditingController();
  GlobalKey<FormState> loginFormKey = GlobalKey();
  bool obsecureText = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        elevation: 0,
        centerTitle: true,
        title: Text(AppContant.appName),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          alignment: Alignment.center,
          child: Form(
            key: loginFormKey,
            child: Column(
              children: [
                Container(
                  alignment: Alignment.center,
                  height: 250,
                  width: 200,
                  child: Lottie.asset(
                    'assets/images/welcome.json',
                    fit: BoxFit.fill,
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20.0),
                  child: TextFormField(
                    controller: loginEmailController,
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
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20.0),
                  child: TextFormField(
                    controller: loginPasswordController,
                    obscureText: obsecureText,
                    obscuringCharacter: "*",
                    textInputAction: TextInputAction.done,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      hintText: 'Password',
                      labelText: 'Password',
                      prefixIcon: Icon(Icons.password),
                      suffixIcon: GestureDetector(
                        onTap: () {
                          setState(() {
                            obsecureText = !obsecureText;
                          });
                        },
                        child: obsecureText
                            ? Icon(Icons.visibility)
                            : Icon(Icons.visibility_off),
                      ),
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
                Container(
                  alignment: Alignment.topRight,
                  margin: EdgeInsets.symmetric(horizontal: 20.0),
                  child: GestureDetector(
                    onTap: () {
                      Get.to(
                        () => ForgetPasswordScreen(),
                      );
                    },
                    child: Text(
                      "Forget Password",
                      style: TextStyle(
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                ElevatedButton(
                  onPressed: () {
                    if (loginEmailController.text == '') {
                      print("Please Enter your email");
                    }
                    if (loginPasswordController.text == '') {
                      print("Please Enter your password");
                    } else {
                      print("Done");
                      String loginEmail = loginEmailController.text.trim();
                      String loginPassword =
                          loginPasswordController.text.trim();
                      LoginService.UserLogin(
                          loginEmail, loginPassword, context);
                    }
                  },
                  child: Text("LOGIN"),
                ),
                SizedBox(
                  height: 20.0,
                ),
                GestureDetector(
                  onTap: () {
                    Get.to(() => SignUpScreen());
                  },
                  child: Container(
                    child: Text.rich(
                      TextSpan(
                        text: "Don't have an account? ",
                        // ignore: prefer_const_literals_to_create_immutables
                        children: [
                          TextSpan(
                            text: 'Sign Up',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
