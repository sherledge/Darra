import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:darra5/widgets/login.dart';
import 'package:darra5/widgets/register.dart';
import 'package:darra5/controllers/auth_controller.dart';

class LoginScreen extends StatefulWidget {
const  LoginScreen({super.key});

  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  final AuthController authController = Get.put(AuthController());
  bool _selectedIndex = true; // true for Login, false for Sign-up
  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();
  final TextEditingController _controllerConfirmPassword =
      TextEditingController();
  final TextEditingController _controllerFullName = TextEditingController();
  final PageController _pageController = PageController(initialPage: 0);
  final TextEditingController _controllerAddress = TextEditingController();
  final TextEditingController _controllerPhoneNumber = TextEditingController();

  void _onTabSelected(bool index) {
    setState(() {
      _selectedIndex = index;
    });
    _pageController.animateToPage(
      index ? 0 : 1,
      duration:const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }

  Future<void> signInWithEmailAndPassword(String email, String password) async {
    authController.errorMessage.value = '';
    try {
      await authController.signInWithEmailAndPassword(
          email: email, password: password);
      if (authController.errorMessage.value.isEmpty) {
        Get.offAllNamed('/investments');
      }
    } catch (e) {
      authController.errorMessage.value = e.toString();
    }
  }

  Future<void> createUserWithEmailAndPassword(String email, String password,
      String name, String address, String phoneNumber) async {
    authController.errorMessage.value = '';
    try {
      await authController.createUserWithEmailAndPassword(
          email: email,
          password: password,
          name: name,
          address: address,
          phoneNumber: phoneNumber);
      if (authController.errorMessage.value.isEmpty) {
        Get.offAllNamed('/investments');
      }
    } catch (e) {
      authController.errorMessage.value = e.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NotificationListener<ScrollNotification>(
        onNotification: (scrollNotification) {
          return true;
        },
        child: Stack(
          children: [
            Column(
              children: [
                Container(
                  height: 305,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset:const Offset(0, 3),
                      ),
                    ],
                    color: Colors.white,
                    borderRadius:const BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                    ),
                  ),
                  child: Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                       const   SizedBox(height: 20),
                          Image.asset(
                            'assets/images/Farmer-bro 1.png',
                            width: 250,
                            height: 250,
                          ),
                          Container(
                            padding:const EdgeInsets.only(bottom: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                GestureDetector(
                                  onTap: () => _onTabSelected(true),
                                  child: Container(
                                    padding:const
                                        EdgeInsets.symmetric(horizontal: 20),
                                    child:const Text(
                                      'Login',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                ),
                             const   SizedBox(width: 60),
                                GestureDetector(
                                  onTap: () => _onTabSelected(false),
                                  child: Container(
                                    padding:
                                     const   EdgeInsets.symmetric(horizontal: 20),
                                    child:const Text(
                                      'Sign-up',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      AnimatedPositioned(
                        duration:const Duration(milliseconds: 300),
                        bottom: 0,
                        left: _selectedIndex ? 53.0 : 200.0,
                        child: Container(
                          width: 100,
                          height: 2,
                          color: Colors.blue,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: PageView(
                    controller: _pageController,
                    onPageChanged: (value) => setState(() {
                      _selectedIndex = value == 0;
                    }),
                    scrollDirection: Axis.horizontal,
                    children: [
                      SingleChildScrollView(
                        child: Column(
                          children: [
                            Login(
                              controllerEmail: _controllerEmail,
                              controllerPassword: _controllerPassword,
                            ),
                          ],
                        ),
                      ),
                      SingleChildScrollView(
                        child: Column(
                          children: [
                            Register(
                              controllerEmail: _controllerEmail,
                              controllerPassword: _controllerPassword,
                              controllerFullName: _controllerFullName,
                              controllerConfirmPassword:
                                  _controllerConfirmPassword,
                              controllerAddress: _controllerAddress,
                              controllerPhoneNumber: _controllerPhoneNumber,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding:const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Obx(() {
              return authController.errorMessage.value.isNotEmpty
                  ? Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 40),
                      child: Text(
                        authController.errorMessage.value,
                        style:const TextStyle(color: Colors.red, fontSize: 12),
                      ),
                    )
                  :const SizedBox.shrink();
            }),
       const     SizedBox(
              height: 40,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor:const Color(0xFF00B899),
                    foregroundColor: Colors.white,                minimumSize:const Size(310, 70),
              ),
              
                onPressed: () {
                  if (_selectedIndex) {
                    signInWithEmailAndPassword(
                        _controllerEmail.text, _controllerPassword.text);
                  } else {
                    if (_controllerAddress.text.isEmpty ||
                        _controllerPhoneNumber.text.isEmpty ||
                        _controllerFullName.text.isEmpty ||
                        _controllerPassword.text.isEmpty ||
                        _controllerConfirmPassword.text.isEmpty) {
                      authController.errorMessage.value =
                          'Please fill all fields';
                    } else {
                      if (_controllerPassword.text ==
                          _controllerConfirmPassword.text) {
                        createUserWithEmailAndPassword(
                          _controllerEmail.text,
                          _controllerPassword.text,
                          _controllerFullName.text,
                          _controllerAddress.text,
                          _controllerPhoneNumber.text,
                        );
                      } else {
                        authController.errorMessage.value =
                            'Passwords do not match';
                      }
                    }
                  }
                },
                                child: Text(_selectedIndex ? 'Login' : 'Register'),

              ),
            ),
          ],
        ),
      ),
    );
  }
}
