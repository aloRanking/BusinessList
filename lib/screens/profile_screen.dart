import 'package:businesslisting/controllers/auth_controller.dart';
import 'package:businesslisting/controllers/profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class ProfileScreen extends StatelessWidget {
  final AuthController _authController = Get.find();
  final ProfileController _profileController = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            // crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 20,),
              FaIcon(FontAwesomeIcons.user, size: 30,),
              SizedBox(height: 20,),
              Text('${_authController.user.email}'),
              SizedBox(height: 20,),
              Obx(() => Text('${_profileController.position}')),
              RaisedButton(onPressed: () {
                _authController.signOut();
                Get.offNamed('/loginView');
              },
                child: Text('Logout'),)
            ],
          ),
        ),
      ),
    );
  }
}
