import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  FirebaseAuth _auth = FirebaseAuth.instance;

  Rx<User> _firebaseUser = Rx<User>();

  User get user => _firebaseUser.value;

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController regEmailController = TextEditingController();
  TextEditingController regPasswordController = TextEditingController();
  var isPasswordVisible = false.obs;

  /* @override
  void onInit() {
    _firebaseUser.bindStream(_auth.onAuthStateChanged);
  }*/

  void createUser() async {
    Get.dialog(Center(child: CircularProgressIndicator()),
        barrierDismissible: false);
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: regEmailController.text.trim(),
        password: regPasswordController.text,
      );
      if (userCredential != null) {
        Get.back();
        Get.snackbar(
          'Registration successful', '',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.white38,
          //duration: Duration(milliseconds: 900),
          overlayBlur: 1,
        );

        await Future.delayed(Duration(seconds: 2));
        Get.back();

        Get.back(result: [regEmailController.text, regPasswordController.text]);
      }
    } catch (e) {
      Get.back();
      Get.snackbar(
        "Error while Signing Up",
        e.message,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.white38,
        duration: Duration(milliseconds: 900),
        overlayBlur: 1,
      );
    }
  }

  void login() async {
    Get.dialog(Center(child: CircularProgressIndicator()),
        barrierDismissible: false);
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text,
      );

      if (userCredential != null) {
        _firebaseUser.value = userCredential.user;


        Get.toNamed('/dashView');
      }


    } catch (e) {
      Get.back();

      Get.snackbar(
        "Error while Signing In",
        e.message,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.white38,
        //duration: Duration(milliseconds: 900),
        overlayBlur: 1,
      );
    }
  }

  void signOut() async {
    try {
      await _auth.signOut();
    } catch (e) {
      Get.snackbar(
        "Error while signing out",
        e.message,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.white38,
        overlayBlur: 1,
      );
    }
  }
}
