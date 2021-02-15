import 'package:animate_do/animate_do.dart';
import 'package:businesslisting/controllers/auth_controller.dart';
import 'package:businesslisting/utils/colors.dart';
import 'package:businesslisting/widgets/button_widget.dart';
import 'package:businesslisting/widgets/custom_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginScreen extends StatelessWidget {
  // final AuthController _authController = Get.put(AuthController());
  final AuthController _authController = Get.find();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 5),
              logoText(),
              topText(),
              loginField(),
            ],
          ),
        ),
      ),
    );
  }

  logoText() {
    return ZoomIn(
      delay: Duration(milliseconds: 200),
      child: Container(
        margin: EdgeInsets.all(20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Business Listing',
              style: TextStyle(fontSize: 40),
            )
          ],
        ),
      ),
    );
  }

  topText() {
    return ZoomIn(
      delay: Duration(milliseconds: 300),
      child: Container(
        padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
        child: Column(
          children: [
            Text(
              'Login',
              style: TextStyle(fontSize: 25, color: Colors.black),
            ),
            Container(
              margin: EdgeInsets.only(top: 5),
              height: 10,
              width: 100,
              color: kBlueColor,
            ),
          ],
        ),
      ),
    );
  }

  loginField() {
    return ZoomIn(
      delay: Duration(milliseconds: 400),
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
                controller: _authController.emailController,
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
                  controller: _authController.passwordController,
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
                    if (value.length < 6) {
                      return 'password should be at least 6 characters';
                    }
                    return null;

                  },
                );
              }),
              GestureDetector(
                onTap: () {
                  //forgotPasswordButton(context);
                },
                child: Container(
                  margin: EdgeInsets.only(top: 10, bottom: 10),
                  child: Text('Forgot Password?',
                      style: TextStyle(fontSize: 16, color: kBlueColor)),
                ),
              ),
              ButtonWidget(
                title: 'LOGIN',
                hasBorder: false,
                onTap: () {
                  if (_formKey.currentState.validate()) {
                    _authController.login();
                  }
                },
              ),
              SizedBox(height: 10),
              Hero(
                tag: 'sign',
                child: ButtonWidget(
                  title: 'Sign UP',
                  hasBorder: true,
                  onTap: () async {
                    var result = await Get.toNamed('/registerView');

                    if (result == null) {
                      _authController.emailController.text = '';
                      _authController.passwordController.text = '';
                    } else {
                      _authController.emailController.text = result[0];
                      _authController.passwordController.text = result[1];
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
