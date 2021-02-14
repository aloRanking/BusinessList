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

    super.onInit();
  }

  Future<void> getActiveBusiness() async {
    var active = await fireStore
        .collection('business')
        .where("isActive", isEqualTo: true)
        .get();

    //List<QuerySnapshot> documents = active.data.docs;

    nActive.value = active.docs.length;

    print(nActive);
  }

  Future<void> getInActiveBusiness() async {
    var active = await fireStore
        .collection('business')
        .where("isActive", isEqualTo: false)
        .get();

    //List<QuerySnapshot> documents = active.data.docs;

    nInActive.value = active.docs.length;

    print(nInActive);
  }

  Future<void> getRegisteredBusiness() async {
    var active = await fireStore.collection('business').get();

    //List<QuerySnapshot> documents = active.data.docs;

    nRegistered.value = active.docs.length;

    print(nRegistered);
  }
}
