import 'dart:io';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class AddBusinessController extends GetxController {
  var image = File('').obs;
  final picker = ImagePicker();

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
