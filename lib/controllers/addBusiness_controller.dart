import 'dart:io';

import 'package:businesslisting/models/business_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import 'auth_controller.dart';

class AddBusinessController extends GetxController {
  final AuthController _authController = Get.find();
  var image = File('').obs;
  final picker = ImagePicker();
  final fireStore = FirebaseFirestore.instance;
  Position position;
  Business business = Business();

  TextEditingController nameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController typeController = TextEditingController();


  FirebaseStorage storage =
      FirebaseStorage.instance;

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();

    getCurrentPosition();
  }


  void createBusiness() {
    business.name = nameController.text;
    business.address = addressController.text;
    business.type = typeController.text;
    business.isActive = true;
    business.email = _authController.user.email;
    business.coordinates =
        position.longitude.toString() + ' ' + position.latitude.toString();


    fireStore.collection('business').add(
        business.toMap()

    );

    Get.snackbar(
      "Business Added",
      "",
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.white38,
      //duration: Duration(milliseconds: 900),
      overlayBlur: 1,
    );

    // await Future.delayed(Duration(seconds: 2));

    nameController.clear();
    addressController.clear();
    typeController.clear();
  }

  void getCurrentPosition() async {
    position =
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

    print(position.longitude.toString());
  }


  Future<void> uploadFile(String filePath) async {
    File file = File(filePath);

    try {
      await storage
          .ref('uploads/file-to-upload.png')
          .putFile(file);
    } on FirebaseException catch (e) {
      // e.g, e.code == 'canceled'
    }
  }


  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);

    if (pickedFile != null) {
      image.value = File(pickedFile.path);
      //print('No image selected.');
    } else {
      print('No image selected.');
    }
  }
}
