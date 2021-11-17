// import 'package:book_store/model/books.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:get/get.dart';

class CardCountController extends GetxController {
  // var cardItems = List<Book>().obs;
  var cardCount = 0.obs;
  @override
  void onInit() {
    // TODO: implement onInit
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
