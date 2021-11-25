import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class CardCountController extends GetxController {
  var cardCount = 0.obs;
  @override
  void onInit() {
    super.onInit();
    getCardCount();
  }

  void getCardCount() async {
    Query collectionReference =
        FirebaseFirestore.instance.collection('Add-To-Card');
    QuerySnapshot querySnapshot = await collectionReference.get();
    cardCount.value = querySnapshot.docs.length;
  }
}
