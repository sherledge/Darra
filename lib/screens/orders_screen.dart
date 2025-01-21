// orders_screen.dart

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class OrdersScreen extends StatelessWidget {
const  OrdersScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final String userId = auth.currentUser!.uid;

    return Scaffold(
      appBar: AppBar(
        title:const Text('Orders'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('orders')
            .where('user_id', isEqualTo: userId) // Filter orders by user_id
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text('No orders found.'));
          }

          return ListView(
            padding:const EdgeInsets.all(8.0),
            children: snapshot.data!.docs.map((document) {
              final data = document.data() as Map<String, dynamic>;
              return Card(
                elevation: 5,
                margin:const EdgeInsets.symmetric(vertical: 8.0),
                child: ListTile(
                  contentPadding:const EdgeInsets.all(16.0),
                  title: Text(
                    'Order ID: ${document.id}',
                    style:const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'WhatsApp Number: ${data['whatsapp_number']}',
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                      Text(
                        'Total Amount: \$${data['total_amount'].toStringAsFixed(2)}',
                        style:const TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  trailing: _getStatusIcon(data['status']),
                ),
              );
            }).toList(),
          );
        },
      ),
    );
  }

  Widget _getStatusIcon(String status) {
    switch (status) {
      case 'processing':
        return const Icon(Icons.hourglass_empty, color: Colors.orange);
      case 'completed':
        return const Icon(Icons.check_circle, color: Colors.green);
      case 'cancelled':
        return const Icon(Icons.cancel, color: Colors.red);
      default:
        return const Icon(Icons.help, color: Colors.grey);
    }
  }
}
