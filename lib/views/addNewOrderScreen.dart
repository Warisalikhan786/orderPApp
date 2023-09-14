// ignore_for_file: file_names, prefer_const_constructors, avoid_unnecessary_containers, avoid_print, unused_local_variable

import 'package:animate_do/animate_do.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_oda/utils/contant.dart';
import 'package:flutter_oda/views/homeScreen.dart';
import 'package:get/get.dart';
import 'package:scroll_date_picker/scroll_date_picker.dart';
import '../widgets/customProgressBar.dart';

class AddNewOrderScreen extends StatefulWidget {
  const AddNewOrderScreen({super.key});

  @override
  State<AddNewOrderScreen> createState() => _AddNewOrderScreenState();
}

class _AddNewOrderScreenState extends State<AddNewOrderScreen> {
  TextEditingController productNameController = TextEditingController();
  TextEditingController customerNameController = TextEditingController();
  TextEditingController customerAddressController = TextEditingController();
  TextEditingController customerMobileController = TextEditingController();
  TextEditingController buyPriceController = TextEditingController();
  TextEditingController salePriiceController = TextEditingController();
  //TextEditingController salePriiceController = TextEditingController();
  DateTime _orderDate = DateTime.now();
  User? userId = FirebaseAuth.instance.currentUser;
  dynamic profit;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create Order"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: FadeInLeft(
          duration: Duration(milliseconds: AppContant.animationDuration),
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              children: [
                SizedBox(
                  height: 20.0,
                ),
                TextFormField(
                  keyboardType: TextInputType.name,
                  textInputAction: TextInputAction.next,
                  controller: productNameController,
                  decoration: InputDecoration(
                    hintText: "Product Name",
                    labelText: "Product Name",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
                SizedBox(
                  height: 15.0,
                ),
                TextFormField(
                  keyboardType: TextInputType.name,
                  textInputAction: TextInputAction.next,
                  controller: customerNameController,
                  decoration: InputDecoration(
                    hintText: "Customer Name",
                    labelText: "Customer Name",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
                SizedBox(
                  height: 15.0,
                ),
                TextFormField(
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                  controller: customerAddressController,
                  decoration: InputDecoration(
                    hintText: "Customer Address",
                    labelText: "Customer Address",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
                SizedBox(
                  height: 15.0,
                ),
                TextFormField(
                  keyboardType: TextInputType.phone,
                  textInputAction: TextInputAction.next,
                  controller: customerMobileController,
                  decoration: InputDecoration(
                    hintText: "Customer Mobile",
                    labelText: "Customer Mobile",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
                SizedBox(
                  height: 15.0,
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.next,
                  controller: buyPriceController,
                  decoration: InputDecoration(
                    hintText: "Buy Price",
                    labelText: "Buy Price",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
                SizedBox(
                  height: 15.0,
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.done,
                  controller: salePriiceController,
                  decoration: InputDecoration(
                    hintText: "Sale Price",
                    labelText: "Sale Price",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
                SizedBox(
                  height: 5.0,
                ),
                Container(
                  margin: EdgeInsets.only(left: 12.0),
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Order date",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  height: 5.0,
                ),
                SizedBox(
                  height: 80,
                  child: ScrollDatePicker(
                    selectedDate: _orderDate,
                    locale: Locale('en'),
                    onDateTimeChanged: (DateTime value) {
                      setState(() {
                        _orderDate = value;
                      });
                    },
                  ),
                ),
                SizedBox(
                  height: 15.0,
                ),
                FadeInUp(
                  duration:
                      Duration(milliseconds: AppContant.animationDuration),
                  child: ElevatedButton(
                    onPressed: () async {
                      if (productNameController.text != '' &&
                          customerNameController.text != '' &&
                          customerAddressController.text != '' &&
                          customerMobileController.text != '' &&
                          buyPriceController.text != '' &&
                          salePriiceController.text != '') {
                        var buyPrice =
                            double.parse(buyPriceController.text.trim());
                        var saleprice =
                            double.parse(salePriiceController.text.trim());

                        //Calculate Profit
                        profit = saleprice - buyPrice;
                        //Map into database
                        Map<String, dynamic> newOrderMap = {
                          'userId': userId!.uid,
                          'productImages': [],
                          'productName': productNameController.text.trim(),
                          'customerName': customerNameController.text.trim(),
                          'customerAddress':
                              customerAddressController.text.trim(),
                          'customerMobile':
                              customerMobileController.text.trim(),
                          'buyPrice': buyPriceController.text.trim(),
                          'salePrice': salePriiceController.text.trim(),
                          'orderDate': _orderDate,
                          'status': 'pending',
                          'profit': profit,
                          'createdAt': DateTime.now(),
                        };
                        showDialog(
                            barrierDismissible: false,
                            context: context,
                            builder: (BuildContext context) {
                              return CustomProgressBar(
                                message: "Please Wait..",
                              );
                            });
                        print("$profit");

                        //Add Data into Firebase
                        await FirebaseFirestore.instance
                            .collection('newOrders')
                            .doc()
                            .set(newOrderMap);
                        print("Order Submit Successfully");
                        Get.off(() => HomeScreen());
                      } else {
                        print("Please Fill All Details");
                        Get.back();
                      }
                    },
                    child: Text("Add"),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
