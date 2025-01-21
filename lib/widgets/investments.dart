import 'package:darra5/controllers/cart_controller.dart';
import 'package:flutter/material.dart';
import 'package:darra5/models/investment.dart';
import 'package:get/get.dart';

class InvestmentCard extends StatelessWidget {
  final Investment investment;

  InvestmentCard({super.key, required this.investment});
  final CartController cartController = Get.put(CartController());

  String _getImagePath(String imageName) {
    // Assuming images are named and stored in 'assets/images/'
    switch (imageName) {
      case 'egg':
        return 'assets/images/egg.png';
      case 'banana':
        return 'assets/images/banana.png';
      case 'worm':
        return 'assets/images/worm.png';
        case 'hydro':
        return 'assets/images/hydro.png';
      case '':
        return 'assets/images/Farmer-bro 1.png';
      
      // Add more cases as needed
      default:
        return 'assets/images/Farmer-bro 1.png'; // Fallback image
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin:const EdgeInsets.all(8.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            SizedBox(
              width: 200,
              height: 200,
              child: Image.asset(
                _getImagePath(investment.image,),
                fit: BoxFit.cover,
              ),
            ),
         const   SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    investment.name,
                    style:const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
             const     SizedBox(height: 8),
                  Text('Invest    ->  ${investment.amount}'),
                  Text('Returns  ->  ${investment.returns}'),
                  Text('Duration ->  ${investment.duration} months'),
                  ElevatedButton(
                    onPressed: (){cartController.addToCart(investment);}, child:const Text('add to cart'))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
