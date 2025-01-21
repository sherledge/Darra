import 'package:darra5/widgets/badge1.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:darra5/controllers/cart_controller.dart';
import 'package:darra5/models/investment.dart';

class InvestmentDetailsScreen extends StatelessWidget {
  final Investment investment;
  final CartController cartController = Get.find<CartController>();

  InvestmentDetailsScreen({super.key ,required this.investment});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(investment.name),
        actions: [
          Obx(() => Badges(
                value: cartController.totalItems.toString(),
                child: IconButton(
                  icon:const Icon(Icons.shopping_cart),
                  onPressed: () {
                    Get.toNamed('/cart');
                  },
                ),
              )),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 200,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                  image: AssetImage(_getImagePath(investment.image)),
                  fit: BoxFit.cover,
                ),
              ),
            ),
       const     SizedBox(height: 16),
            Text(
              investment.name,
              style:const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
      const      SizedBox(height: 8),
            Text(
              'Invest: \$${investment.amount.toStringAsFixed(2)}',
              style: TextStyle(fontSize: 18, color: Colors.grey[700]),
            ),
            Text(
              'Returns: \$${investment.returns.toStringAsFixed(2)}',
              style: TextStyle(fontSize: 18, color: Colors.grey[700]),
            ),
            Text(
              'Duration: ${investment.duration} months',
              style: TextStyle(fontSize: 18, color: Colors.grey[700]),
            ),
     const       SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                cartController.addToCart(investment);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor:const Color(0xFF00B899),
                padding:const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child:const Text(
                'Add to Cart',
                style: TextStyle(fontSize: 16,color: Colors.white),
              ),
            ),
     const       SizedBox(height: 16),
            
          
          ],
        ),
      ),
    );
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
