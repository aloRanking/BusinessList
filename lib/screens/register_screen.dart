import 'package:animate_do/animate_do.dart';
import 'package:businesslisting/controllers/auth_controller.dart';
import 'package:businesslisting/utils/colors.dart';
import 'package:businesslisting/widgets/button_widget.dart';
import 'package:businesslisting/widgets/custom_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterScreen extends StatelessWidget {
  //final AuthController _authController = Get.put(AuthController());
  final AuthController _authController = Get.find();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [topText(), registerField(), bottomText()],
          ),
        ),
      ),
    );
  }

  topText() {
    return Container(
      child: Column(
        children: [
          Text(
            'Create Account',
            style: TextStyle(fontSize: 25, color: Colors.black),
          ),
          Container(
            margin: EdgeInsets.only(top: 5),
            height: 10,
            width: 100,
            color: kGreenColor,
          ),
        ],
      ),
    );
  }

  registerField() {
    return ZoomIn(
      delay: Duration(milliseconds: 200),
      child: Container(
        padding: EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              CustomTexfield(
                hintText: 'Email',
                prefixIconData: Icons.mail_outline,
                controller: _authController.regEmailController,
                keyBoardType: TextInputType.emailAddress,
                onValidate: (value) {
                  if (value.isEmpty) {
                    return 'Email field can\'t be blank';
                  }
                  return null;
                },
              ),
              Obx(() {
                return CustomTexfield(
                  hintText: 'Password',
                  prefixIconData: Icons.lock_outlined,
                  controller: _authController.regPasswordController,
                  keyBoardType: TextInputType.visiblePassword,
                  shudObscure:
                      _authController.isPasswordVisible.value ? false : true,
                  suffixIconData: _authController.isPasswordVisible.value
                      ? Icons.visibility
                      : Icons.visibility_off,
                  onTap: () {
                    _authController.isPasswordVisible.value =
                        !_authController.isPasswordVisible.value;
                  },
                  onValidate: (value) {
                    if (value.isEmpty) {
                      return 'password field can\'t be blank';
                    }
                    return null;
                  },
                );
              }),
              Hero(
                tag: 'sign',
                child: ButtonWidget(
                  title: 'CREATE',
                  hasBorder: false,
                  onTap: () {
                    if (_formKey.currentState.validate()) {
                      _formKey.currentState.save();

                      _authController.createUser();
                    }
                  },
                ),
              ),
              SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }

  bottomText() {
    return Container(
      margin: EdgeInsets.only(top: 15),
      child: Column(
        children: [
          Text('Have existing Account?',
              style: TextStyle(fontSize: 16, color: kGreenColor)),
          SizedBox(height: 10),
          GestureDetector(
              onTap: () {
                Get.back();
              },
              child: Text('LOGIN',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: kGreenColor))),
        ],
      ),
    );
  }
}
