// ignore_for_file: file_names, must_be_immutable, avoid_unnecessary_containers, prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomProgressBar extends StatelessWidget {
  String? message;
  CustomProgressBar({super.key, this.message});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        margin: const EdgeInsets.all(15.0),
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(6.0),
        ),
        child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  message!,
                  style: const TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(
                  width: 26.0,
                ),
                CupertinoActivityIndicator(
                  animating: true,
                  color: Colors.black,
                  radius: 15.0,
                ),
              ],
            )),
      ),
    );
  }
}
