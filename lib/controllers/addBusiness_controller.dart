import 'dart:io';

import 'package:businesslisting/controllers/dash_controller.dart';
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
  final DashboardController _dashboardController = Get.find();
  var image = File('hii.txt').obs;
  final picker = ImagePicker();
  String downloadUrl;

  //final fireStore = FirebaseFirestore.instance;
  Position position;
  Business business = Business();

  TextEditingController nameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController typeController = TextEditingController();

  FirebaseStorage storage = FirebaseStorage.instance;

  var timestamp = DateTime
      .now()
      .millisecondsSinceEpoch;
  var isActive = true.obs;

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();

    getCurrentPosition();
  }

  void createBusiness() async {
    business.name = nameController.text;
    business.address = addressController.text;
    business.type = typeController.text;
    business.isActive = true;
    business.email = _authController.user.email;
    business.imgurl = await uploadFile(image.value);
    business.coordinates = [position.latitude, position.longitude];

    _dashboardController.fireStore.collection('business').add(business.toMap());

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
    // image.close();
  }

  void updateBusiness(var docId) async {
    print(docId);

    business.name = nameController.text;
    business.address = addressController.text;
    business.type = typeController.text;
    business.isActive = isActive.value;
    business.email = _authController.user.email;
    // business.imgurl = await uploadFile(image.value);
    //business.coordinates = [position.latitude, position.longitude];

    _dashboardController.fireStore
        .collection("business")
        .doc(docId)
        .update(business.toMap()).then((_) {
      print("success!");
    });

    Get.snackbar(
      "Business Added",
      "",
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.white38,
      //duration: Duration(milliseconds: 900),
      overlayBlur: 1,
    );
  }



  void getCurrentPosition() async {
    position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    print(position.longitude.toString());
  }

  Future<String> uploadFile(File file) async {
    //File file = File(filePath);

    try {
      TaskSnapshot snapShot = await storage
          .ref('businessImages/file-to-upload' + '$timestamp' + '.png')
          .putFile(file);

      if (snapShot != null) {
        return downloadUrl = await snapShot.ref.getDownloadURL();
      }
    } on FirebaseException catch (e) {
      // e.g, e.code == 'canceled'
      print(e);
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
