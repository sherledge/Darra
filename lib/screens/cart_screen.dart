// cart_screen.dart

import 'package:darra5/screens/orders_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:darra5/controllers/cart_controller.dart';
import 'package:darra5/models/investment.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CartScreen extends StatelessWidget {
  CartScreen({super.key});
  final CartController cartController = Get.find<CartController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:const Color(0xFFF2F2F2),
      appBar: AppBar(
        title: const Text('Cart'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: Column(
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.swipe_left),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Text('Swipe on an item to delete', style: TextStyle(fontSize: 16, color: Colors.black)),
          ),]
          ),
          Expanded(
            child: Obx(() {
              if (cartController.cartItems.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                     const Icon(Icons.shopping_cart, size: 100, color: Colors.grey),
                     const SizedBox(height: 16),
                      const Text(
                        'Your cart is empty',
                        style: TextStyle(fontSize: 24, color: Colors.grey),
                      ),
                    const  SizedBox(height: 16),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: (Colors.white),
                        ),
                        onPressed: () {
                          Get.back();
                        },
                        child:const Text('Start Shopping',style: TextStyle(color: Colors.black),),
                      ),
                    ],
                  ),
                );
              } else {
                return ListView.builder(
                  itemCount: cartController.cartItems.length,
                  itemBuilder: (context, index) {
                    Investment investment = cartController.cartItems.keys.toList()[index];
                    int quantity = cartController.cartItems[investment]!;
                    double totalAmount = investment.amount * quantity;
                    return Dismissible(
                      key: Key(investment.id),
                      direction: DismissDirection.endToStart,
                      onDismissed: (direction) {
                        cartController.removeItem(investment);
                      },
                      background: Container(
                        height: 100,
                        width: 300,
                        color: Colors.red,
                        alignment: Alignment.centerRight,
                        padding:const EdgeInsets.symmetric(horizontal: 20),
                        child:const Icon(Icons.delete, color: Colors.white),
                      ),
                      child: Card(
                        color: Colors.white,
                        elevation: 5,
                        margin:const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                        child: ListTile(
                          
                          leading: SizedBox(
                            width: 70,
                            height: 70,
                            child: Image.asset(_getImagePath(investment.image), fit: BoxFit.cover),
                          ),
                          title: Text(
                            
                            investment.name,
                            style:const TextStyle(fontSize: 18, fontWeight: FontWeight.bold,),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Quantity: $quantity'),
                              Text('Total Amount: ₹${totalAmount.toStringAsFixed(2)}'),
                            ],
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon:const Icon(Icons.remove),
                                onPressed: () {
                                  cartController.removeFromCart(investment);
                                },
                              ),
                              IconButton(
                                icon:const Icon(Icons.add),
                                onPressed: () {
                                  cartController.addToCart(investment);
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              }
            }),
          ),
          Obx(() {
            double totalCost = cartController.cartItems.entries.fold(0, (summed, entry) {
              return summed + entry.key.amount * entry.value;
            });
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Text(
                    'Total:  ₹${totalCost.toStringAsFixed(2)}',
                    style:const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                 const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () async {
                      String? whatsappNumber = await _showWhatsAppNumberDialog(context);
                      if (whatsappNumber != null && whatsappNumber.isNotEmpty) {
                        _submitOrder(whatsappNumber, totalCost);
                      }
                    },
                
  style: ElevatedButton.styleFrom(
    backgroundColor:const Color(0xFF00B899), // Background color based on ColorScheme
    foregroundColor: Theme.of(context).colorScheme.onPrimary, // Text color based on ColorScheme
    padding:const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
    textStyle:const TextStyle(fontSize: 18),
  ),   child:const Text('Proceed to invest'),

                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }

  Future<String?> _showWhatsAppNumberDialog(BuildContext context) {
    TextEditingController controller = TextEditingController();
    return showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title:const Text('Enter WhatsApp Number'),
          content: TextField(
            controller: controller,
            keyboardType: TextInputType.phone,
            decoration:const InputDecoration(hintText: 'WhatsApp number'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(controller.text);
              },
              child:const Text('Submit',style: TextStyle(color: Color(0xFF00B899)),),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child:const Text('Cancel',style: TextStyle(color: Color(0xFF00B899)),),
            ),
          ],
        );
      },
    );
  }

  Future<void> _submitOrder(String whatsappNumber, double totalAmount) async {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    final FirebaseAuth auth = FirebaseAuth.instance;
    final String userId = auth.currentUser!.uid;

    // Fetch user name from Firestore
    DocumentSnapshot userDoc = await firestore.collection('users').doc(userId).get();
    String userName = userDoc['name'];

    // Prepare order items
    List<Map<String, dynamic>> orderItems = cartController.cartItems.entries.map((entry) {
      return {
        'investment_id': entry.key.id,
        'investment_name': entry.key.name,
        'quantity': entry.value,
        'total_amount': entry.key.amount * entry.value,
      };
    }).toList();

    firestore.collection('orders').add({
      'user_id': userId,
      'user_name': userName,
      'whatsapp_number': whatsappNumber,
      'total_amount': totalAmount,
      'status': 'processing',
      'timestamp': FieldValue.serverTimestamp(),
      'items': orderItems,
    }).then((_) {
      cartController.clearCart(); // Clear the cart after placing the order
      Get.to(() =>const OrdersScreen()); // Navigate to OrdersScreen
    }).catchError((error) {
Get.snackbar(
      'Error', // Title of the Snackbar
      'Error adding order: $error', // Message of the Snackbar
      snackPosition: SnackPosition.BOTTOM, // Position of the Snackbar
      duration:const Duration(seconds: 3), // Duration for how long the Snackbar should be displayed
    );    });
  }

  String _getImagePath(String imageName) {
    switch (imageName) {
      case 'egg':
        return 'assets/images/egg.png';
      case 'banana':
        return 'assets/images/banana.png';
      case 'worm':
        return 'assets/images/worm.png';
      case 'hydro':
        return 'assets/images/hydro.png';
      default:
        return 'assets/images/Farmer-bro 1.png'; // Fallback image
    }
  }
}
