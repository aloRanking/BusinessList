import 'package:businesslisting/controllers/addBusiness_controller.dart';
import 'package:businesslisting/widgets/button_widget.dart';
import 'package:businesslisting/widgets/custom_field.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class AddBusinessScreen extends StatelessWidget {
  final _businessFormKey = GlobalKey<FormState>();
  final AddBusinessController _addBusinessController =
  Get.put(AddBusinessController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Business'),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [businessRegistrationBody()],
          ),
        ),
      ),
    );
  }

  businessRegistrationBody() {
    return Container(
      padding: EdgeInsets.all(20),
      child: Form(
        key: _businessFormKey,
        child: Column(
          children: [
            CustomTexfield(
              labelText: 'Name',

              controller: _addBusinessController.nameController,
              keyBoardType: TextInputType.name,

              onValidate: (value) {
                if (value.isEmpty) {
                  return 'Name field can\'t be blank';
                }
                return null;
              },
              // onSave: (value)=> _addBusinessController.business.name = value.trim(),
            ),
            CustomTexfield(
              labelText: 'Address',

              controller: _addBusinessController.addressController,
              keyBoardType: TextInputType.name,
              onValidate: (value) {
                if (value.isEmpty) {
                  return 'Address field can\'t be blank';
                }
                return null;
              },
              // onSave: (value)=> _addBusinessController.business.address = value.trim(),
            ),
            CustomTexfield(
              labelText: 'Type of Business',

              controller: _addBusinessController.typeController,
              keyBoardType: TextInputType.name,
              onValidate: (value) {
                if (value.isEmpty) {
                  return 'Type of Business field can\'t be blank';
                }
                return null;
              },
              // onSave: (value)=> _addBusinessController.business.type = value.trim(),
            ),
            FlatButton(
                onPressed: () {
                  _addBusinessController.getImage();
                },
                child: Row(
                  children: [
                    FaIcon(FontAwesomeIcons.fileImage),
                    SizedBox(width: 10),
                    Text(
                      'Add an Image',
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                )),
            Obx(() {
              return Container(
                child: _addBusinessController.image == null
                    ? Text('No image selected.')
                    : Image.file(_addBusinessController.image.value),
              );
            }),
            SizedBox(
              height: 30,
            ),
            ButtonWidget(
              title: 'ADD',
              hasBorder: false,
              onTap: () {
                if (_businessFormKey.currentState.validate()) {
                  // _businessFormKey.currentState.save();

                  _addBusinessController.createBusiness();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
