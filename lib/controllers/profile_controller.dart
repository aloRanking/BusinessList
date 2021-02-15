import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  var position = Position(latitude: 0, longitude: 0).obs;

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
    getCurrentPosition();
  }

  void getCurrentPosition() async {
    position.value = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }
}
