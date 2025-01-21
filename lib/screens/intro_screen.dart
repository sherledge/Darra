import 'package:darra5/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class IntroScreen extends StatelessWidget {
  const IntroScreen({super.key} );
  @override
  Widget build(BuildContext context) {
   
   
    return SafeArea(
      child: Scaffold(
        backgroundColor:const Color(0xFF00B899),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 0, 10),
                child: Image.asset('assets/images/logo.png', height: 70, width: 70),
              ),
            ),
            const Padding(
              padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: Text(
                'Cultivate Your Future',
                textAlign: TextAlign.left,
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'Livvic',
                  fontSize: 50,
                  fontWeight: FontWeight.normal,
                  height: 1,
                ),
              ),
            ),
            Image.asset('assets/images/intro.png', height: 400, width: 400),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {         
                 Get.offAll(() =>const LoginScreen());
               
              },
            
              style: ElevatedButton.styleFrom(
                elevation: 10,
                shadowColor: Colors.black.withOpacity(0.7),
                backgroundColor: Colors.white,
                minimumSize:const Size(300, 60),
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                textStyle: const TextStyle(fontSize: 20),
              ),
                child: const Text('Get Started', style: TextStyle(color: Colors.black,fontWeight: FontWeight.w600,)),
            ),
          const  SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
