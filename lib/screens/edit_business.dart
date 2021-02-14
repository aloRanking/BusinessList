import 'package:businesslisting/controllers/addBusiness_controller.dart';
import 'package:businesslisting/widgets/button_widget.dart';
import 'package:businesslisting/widgets/custom_field.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class EditBusinessScreen extends StatelessWidget {
  final _businessFormKey = GlobalKey<FormState>();
  final AddBusinessController _addBusinessController =
      Get.put(AddBusinessController());

  //var isActive = true.obs;
  @override
  Widget build(BuildContext context) {
    var data = Get.arguments;
    return Scaffold(
        appBar: AppBar(title: Text('Edit Business')),
        body: Column(
          children: [businessRegistrationBody(data)],
        ));
  }

  businessRegistrationBody(var data) {
    return Container(
      padding: EdgeInsets.all(20),
      child: Column(
        children: [
          Form(
            key: _businessFormKey,
            child: Column(
              children: [
                CustomTexfield(
                  labelText: 'Name',
                  intialValue: '${data['name']}',
                  //prefixIconData: Icons.mail_ou,
                  //controller: _addBusinessController.nameController,
                  keyBoardType: TextInputType.name,
                  onValidate: (value) {
                    if (value.isEmpty) {
                      return 'Name field can\'t be blank';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    _addBusinessController.nameController.text = value;
                  },
                  // onSave: (value)=> _addBusinessController.business.name = value.trim(),
                ),
                CustomTexfield(
                  labelText: 'Address',
                  intialValue: '${data['address']}',
                  //prefixIconData: Icons.mail_ou,
                  //controller: _addBusinessController.addressController,
                  keyBoardType: TextInputType.name,
                  onValidate: (value) {
                    if (value.isEmpty) {
                      return 'Address field can\'t be blank';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    _addBusinessController.addressController.text = value;
                  },
                  // onSave: (value)=> _addBusinessController.business.address = value.trim(),
                ),
                CustomTexfield(
                  labelText: 'Type of Business',
                  intialValue: '${data['type']}',
                  //prefixIconData: ,
                  //controller: _addBusinessController.typeController,
                  keyBoardType: TextInputType.name,
                  onValidate: (value) {
                    if (value.isEmpty) {
                      return 'Type of Business field can\'t be blank';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    _addBusinessController.typeController.text = value;
                  },
                  // onSave: (value)=> _addBusinessController.business.type = value.trim(),
                ),
              ],
            ),
          ),
          FlatButton(
              onPressed: () {
                _addBusinessController.getImage();
              },
              child: Row(
                children: [
                  FaIcon(FontAwesomeIcons.fileImage),
                  Text(
                    'Add Image',
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
          Obx(() {
            return SwitchListTile(
                title: Text('Is Business Active ?'),
                value: _addBusinessController.isActive.value,
                onChanged: (value) {
                  _addBusinessController.isActive.value = value;
                });
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

                _addBusinessController.updateBusiness(data);
              }
            },
          ),
        ],
      ),
    );
  }
}
