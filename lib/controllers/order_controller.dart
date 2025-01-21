// lib/controllers/order_controller.dart

import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/order_model.dart';
import 'package:get/get.dart';
class OrderController extends GetxController {
  var orders = <OrderModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchOrders();
  }

  void fetchOrders() {
    FirebaseFirestore.instance.collection('orders').snapshots().listen((snapshot) {
      var orderList = snapshot.docs.map((doc) => OrderModel.fromDocument(doc)).toList();
      orders.assignAll(orderList);
    });
  }
}
