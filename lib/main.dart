import 'package:darra5/controllers/cart_controller.dart';
import 'package:darra5/controllers/intro_controller.dart';
import 'package:darra5/screens/cart_screen.dart';
import 'package:darra5/screens/intro_screen.dart';
import 'package:darra5/screens/orders_screen.dart';
import 'package:darra5/screens/profile_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:darra5/controllers/auth_controller.dart';
import 'package:darra5/screens/login_screen.dart';
import 'package:darra5/screens/investments_screen.dart';
import 'package:darra5/screens/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
    Get.put(CartController());

  Get.put(IntroController());
  Get.put(AuthController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
 const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Darra',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/splash',
      getPages: [
        GetPage(name: '/splash', page: () =>const SplashScreen()),
        GetPage(name: '/intro', page: () =>const IntroScreen()),
        GetPage(name: '/login', page: () =>const LoginScreen()),
        GetPage(name: '/investments', page: () =>const InvestmentListScreen()),
        GetPage(name: '/cart', page: () => CartScreen()),
        GetPage(name: '/profile', page: () => ProfileScreen()),
        GetPage(name: '/orders', page: () =>const OrdersScreen()),
        

      ],
    );
  }
}
