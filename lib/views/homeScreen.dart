// ignore_for_file: file_names, prefer_const_constructors, avoid_unnecessary_containers, avoid_print, prefer_const_literals_to_create_immutables, duplicate_ignore, sized_box_for_whitespace, unnecessary_null_comparison, unused_local_variable, prefer_typing_uninitialized_variables, use_build_context_synchronously

import 'package:animate_do/animate_do.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_oda/utils/contant.dart';
import 'package:flutter_oda/views/addNewOrderScreen.dart';
import 'package:flutter_oda/views/loginScreen.dart';
import 'package:get/get.dart';
import '../widgets/customProgressBar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  User? userId = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppContant.appName),
        centerTitle: true,
        // ignore: prefer_const_literals_to_create_immutables
        actions: [
          Container(
            // color: Colors.amber,
            margin: EdgeInsets.only(right: 10.0),
            child: GestureDetector(
              onTap: () {
                Get.to(() => AddNewOrderScreen());
              },
              child: CircleAvatar(
                radius: 15.0,
                child: Icon(Icons.add_business),
              ),
            ),
          ),
        ],
      ),
      drawer: CustomDrawer(),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              FadeInUp(
                duration: Duration(milliseconds: AppContant.animationDuration),
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 10.0),
                  // height: MediaQuery.of(context).size.height,
                  child: StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection('newOrders')
                        .where('userId', isEqualTo: userId!.uid)
                        .orderBy('createdAt', descending: true)
                        .snapshots(),
                    builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.hasError) {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              margin: EdgeInsets.only(top: 200.0),
                              child: Text("No Data Found!"),
                            ),
                          ],
                        );
                      }
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Container(
                          child: Center(
                            child: CupertinoActivityIndicator(),
                          ),
                        );
                      }
                      if (snapshot.data!.docs.isEmpty) {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              margin: EdgeInsets.only(top: 200.0),
                              child: Text("No Data Found!"),
                            ),
                          ],
                        );
                      }
                      if (snapshot != null && snapshot.data != null) {
                        print(snapshot.data!.docs.length);
                        return ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, index) {
                            var orderStatus =
                                snapshot.data!.docs[index]['status'].toString();
                            var docId = snapshot.data!.docs[index].id;
                            return Card(
                              child: ListTile(
                                title: Text(snapshot
                                    .data!.docs[index]['productName']
                                    .toString()),
                                subtitle: orderStatus == 'pending'
                                    ? Text(
                                        snapshot.data!.docs[index]['status']
                                            .toString(),
                                        style: TextStyle(
                                          color: Colors.green,
                                        ),
                                      )
                                    : Text(
                                        snapshot.data!.docs[index]['status']
                                            .toString(),
                                        style: TextStyle(
                                          color: Colors.red,
                                        ),
                                      ),
                                leading: FadeInLeft(
                                  duration: Duration(
                                      milliseconds:
                                          AppContant.animationDuration),
                                  child: CircleAvatar(
                                    child: Text(
                                      index.toString(),
                                    ),
                                  ),
                                ),
                                trailing: FadeInRight(
                                  duration: Duration(
                                      milliseconds:
                                          AppContant.animationDuration),
                                  child: GestureDetector(
                                    onTap: () {
                                      Get.defaultDialog(
                                        title: "Mark as Sold?",
                                        content: Container(
                                          child: Text(
                                              "Do you want to mark it as sold?"),
                                        ),
                                        onCancel: () async {},
                                        onConfirm: () async {
                                          try {
                                            await FirebaseFirestore.instance
                                                .collection('newOrders')
                                                .doc(snapshot
                                                    .data!.docs[index].id)
                                                .update({
                                              'status': "sold",
                                            });
                                            Get.back();
                                            print("sold");
                                          } on FirebaseAuthException catch (e) {
                                            print("Error: $e");
                                          }
                                        },
                                      );
                                    },
                                    child: CircleAvatar(
                                      child: Icon(Icons.edit),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      }
                      return Container();
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        // ignore: prefer_const_literals_to_create_immutables
        children: [
          UserAccountsDrawerHeader(
            accountName: Text("waris Ali Khan"),
            accountEmail: Text("warisalikhan29@gmail.com"),
            currentAccountPicture: CircleAvatar(
              child: Text("WA"),
            ),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text("Home"),
            // subtitle: Text("click to open"),
            trailing: Icon(Icons.arrow_circle_right),
            onTap: () {
              print("Home pressed");
              Get.back();
              Get.off(() => HomeScreen());
            },
          ),
          ListTile(
            leading: Icon(Icons.add_comment),
            title: Text("Add New Order"),
            trailing: Icon(Icons.arrow_circle_right),
            onTap: () {
              Get.back();
              Get.to(() => AddNewOrderScreen());
            },
          ),
          Divider(
            height: 10.0,
          ),
          ListTile(
            leading: Icon(Icons.read_more),
            title: Text("Read_More"),
            trailing: Icon(Icons.arrow_circle_right),
            onTap: () {
              print("Read_More pressed");
            },
          ),
          Divider(
            height: 10.0,
          ),
          ListTile(
            leading: Icon(Icons.logout),
            title: Text("Logout"),
            trailing: Icon(Icons.arrow_circle_right),
            onTap: () async {
              showDialog(
                  barrierDismissible: false,
                  context: context,
                  builder: (BuildContext context) {
                    return CustomProgressBar(
                      message: "Please Wait..",
                    );
                  });
              await FirebaseAuth.instance.signOut();
              Get.offAll(() => LoginScreen());
            },
          ),
        ],
      ),
    );
  }
}
