import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:darra5/models/investment.dart';

class InvestmentController extends GetxController {
  var investments = <Investment>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchInvestments();
  }

  void fetchInvestments() async {
  try {
    var snapshot = await FirebaseFirestore.instance.collection('investments').get();
    investments.value = snapshot.docs.map((doc) => Investment.fromMap(doc.data())).toList();
  } catch (e) {
    Get.snackbar('Error', e.toString());
    // Log detailed error
  }
}
}