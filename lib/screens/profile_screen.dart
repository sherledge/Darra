import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:darra5/controllers/auth_controller.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});
  final AuthController authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:const Text('Profile'),
      ),
      body: Obx(() {
        if (authController.userProfile.value == null) {
          return const Center(child: Text('no data for this user'));
        } else {
          var profile = authController.userProfile.value!;
          return Padding(
            padding:const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
              const  Text(
                  'Profile',
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                ),
       const         SizedBox(height: 16),
                Row(
                  children: [
                
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          profile['name'] ?? 'User Name', 
                          style:const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          profile['email'] ?? 'user@example.com', 
                          style:const TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                  ],
                ),
            const    SizedBox(height: 24),
             const   Text(
                  'Address',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Text(
                  profile['address'] ?? 'No address provided', 
                  style:const TextStyle(fontSize: 16),
                ),
          const      SizedBox(height: 24),
                
            const    SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    authController.signOut();
                  },
                  style: ElevatedButton.styleFrom(backgroundColor:const Color(0xFF00B899),minimumSize:const Size(150, 50)
                ),
                                  child: const Text('Logout',style: TextStyle(color: Colors.white),),

                ),
              ],
            ),
          );
        }
      }),
    );
  }
}
