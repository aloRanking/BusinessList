import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class DashboardController extends GetxController {
  final fireStore = FirebaseFirestore.instance;

  var nActive = 0.obs;
  var nInActive = 0.obs;
  var nRegistered = 0.obs;


  @override
  void onInit() {
    getActiveBusiness();
    getInActiveBusiness();
    getRegisteredBusiness();

    print('oninit init');

    super.onInit();
  }


  Stream<dynamic> getActiveBusiness() {
    var active = fireStore
        .collection('business')
        .where("isActive", isEqualTo: true)
        .snapshots();

    return active;


  }

  Stream<dynamic> getInActiveBusiness() {
    var inActive = fireStore
        .collection('business')
        .where("isActive", isEqualTo: false)
        .snapshots();


    return inActive;
  }

  Stream<dynamic> getRegisteredBusiness() {
    var registered = fireStore.collection('business').snapshots();

    //List<QuerySnapshot> documents = active.data.docs;

    return registered;
  }
}
