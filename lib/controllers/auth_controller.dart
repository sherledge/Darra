import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthController extends GetxController {
  var errorMessage = ''.obs;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Rx<User?> user = Rx<User?>(null);
  RxBool selectedIndex = true.obs; // true for Login, false for Sign-up
  var userProfile = Rx<Map<String, dynamic>?>(null);

  bool isLoggedIn() {
    return _firebaseAuth.currentUser != null;
  }

  @override
  void onInit() {
    super.onInit();
    user.bindStream(_firebaseAuth.authStateChanges());
    ever(user, _setInitialProfile);
  }

  Future<void> signInWithEmailAndPassword({required String email, required String password}) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
      _setInitialProfile(user.value);
    } catch (e) {
      errorMessage.value = e.toString();
    }
  }

  Future<void> createUserWithEmailAndPassword({required String email, required String password, required String name, required String address,required String phoneNumber}) async {
    try {
      UserCredential userCredential = await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
      await _firestore.collection('users').doc(userCredential.user?.uid).set({
        'name': name,
        'email': email,
        'address': address,
        'phone number': phoneNumber,
      });
      _setInitialProfile(userCredential.user);
    } catch (e) {
      errorMessage.value = e.toString();
    }
  }

  Future<void> signOut() async {
    try {
      await FirebaseAuth.instance.signOut();
      Get.offAllNamed('/login');
    } catch (e) {
      errorMessage.value = e.toString();
    }
  }

  void _setInitialProfile(User? user) async {
    if (user != null) {
      DocumentSnapshot doc = await _firestore.collection('users').doc(user.uid).get();
      userProfile.value = doc.data() as Map<String, dynamic>?;
    } else {
      userProfile.value = null;
    }
  }
}
