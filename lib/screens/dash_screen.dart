import 'package:businesslisting/controllers/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DashScreen extends StatelessWidget {
  final AuthController _authController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard'),
      ),
      body: Container(
        child: Column(
          children: [

            Text('${_authController.user.email}'),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.toNamed('/addBusinessView');
        },
        child: Icon(Icons.person),
      ),
    );
  }
}
