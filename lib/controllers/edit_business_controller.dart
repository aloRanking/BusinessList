import 'package:businesslisting/controllers/auth_controller.dart';
import 'package:businesslisting/controllers/dash_controller.dart';
import 'package:businesslisting/models/business_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditBusinessController extends GetxController {
  final DashboardController _dashboardController = Get.find();
  final AuthController _authController = Get.find();
  Business business = Business();

  TextEditingController nameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController typeController = TextEditingController();

  void updateBusiness() {
    _dashboardController.fireStore
        .collection("business")
        .doc(_authController.user.uid)
        .update(business.toMap())
        .then((_) {
      print("success!");
    });
  }
}
