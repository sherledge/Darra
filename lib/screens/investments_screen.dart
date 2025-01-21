import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:darra5/controllers/investment_controller.dart';
import 'package:darra5/controllers/cart_controller.dart';
import 'package:darra5/widgets/badge1.dart';
import 'package:darra5/screens/investment_details_screen.dart';

class InvestmentListScreen extends StatefulWidget {
 const InvestmentListScreen({super.key});

  @override
  InvestmentListScreenState createState() => InvestmentListScreenState();
}

class InvestmentListScreenState extends State<InvestmentListScreen> {
  final InvestmentController investmentController = Get.put(InvestmentController());
  final CartController cartController = Get.find<CartController>();

  void _onItemTapped(int index) {
    switch (index) {
      case 0:
        // Stay on InvestmentListScreen
        break;
      case 1:
        Get.toNamed('/orders');
        break;
      case 2:
        Get.toNamed('/profile');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title:const Text('Invest & Earn'),
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
      body: Column(
        children: [
          Obx(() {
            if (investmentController.investments.isEmpty) {
              return const Center(child: CircularProgressIndicator());
            } else {
              return Expanded(
                child: ListView.builder(
                  itemCount: investmentController.investments.length,
                  itemBuilder: (context, index) {
                    final investment = investmentController.investments[index];
                    return GestureDetector(
                      onTap: () {
                        Get.to(() => InvestmentDetailsScreen(investment: investment));
                      },
                      child: Card(
                        margin:const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        elevation: 5,
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: 150,
                                height: 150,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  image: DecorationImage(
                                    image: AssetImage(_getImagePath(investment.image,),),
                      
                                  ),
                                ),
                              ),
                           const   SizedBox(width: 16),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      investment.name,
                                      style:const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                               const     SizedBox(height: 8),
                                    Text.rich(
                                      TextSpan(
                                        children: [
                                          TextSpan(
                                      text: 'Invest: ',
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.grey[700],
                                      ),
                                          ),
                                          TextSpan(
                                            text: '₹${investment.amount.toStringAsFixed(2)}',
                                            style:const TextStyle(fontSize: 13,color: Color(0xFF00B899),fontWeight: FontWeight.w500)
                                          )

                                        ]
                                      ),
                                      
                                    ),
                                    Text.rich(
                                      TextSpan(
                                        children: [
                                     TextSpan( text:  'Returns:',

                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.grey[700],
                                      ),
                                      
                                      ),
                                      
TextSpan(
text: ' ₹${investment.returns.toStringAsFixed(2)}',
style:const TextStyle(
  color: Color(0xFF00B899),
  fontSize: 13,fontWeight: FontWeight.w500
))]
                                      )

                                    ),
                                    Text.rich(
                                      TextSpan(
                                        children: [
                                      TextSpan(text:   'Duration:',
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.grey[700],

                                      ),
                                      
                                      ),
                                      TextSpan(
                                        text: ' ${investment.duration} months',
                                        style:const TextStyle(color: Color.fromARGB(255, 0, 0, 0),
                                        fontSize: 15,fontWeight: FontWeight.w400)
                                      )
                                        ]
                                      )
                                    ),
                                const    SizedBox(height: 8),
                                    ElevatedButton(
                                      onPressed: () {
                                        cartController.addToCart(investment);
                                      },
                                      style: ElevatedButton.styleFrom(
                                         backgroundColor:const Color(0xFF00B899),
                                         foregroundColor: Colors.white,
                                        padding:const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                      ),
                                      child:const Text(
                                        'Add to Cart',
                                        style: TextStyle(fontSize: 16),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              );
            }
          }),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.shop),
            label: 'Shop',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'Orders',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: 0,
        selectedItemColor: Colors.blue,
        onTap: _onItemTapped,
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
