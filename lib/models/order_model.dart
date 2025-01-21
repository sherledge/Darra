// lib/models/order_model.dart

import 'package:cloud_firestore/cloud_firestore.dart';

class OrderModel {
  final String id;
  final String status;

  OrderModel({required this.id, required this.status});

  factory OrderModel.fromDocument(DocumentSnapshot doc) {
    return OrderModel(
      id: doc.id,
      status: doc['status'] ?? 'Unknown',
    );
  }
}
