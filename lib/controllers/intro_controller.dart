import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class IntroController extends GetxController {
  var introPassed = false.obs;

  @override
  void onInit() {
    super.onInit();
    _loadIntroStatus();
  }

  Future<void> _loadIntroStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    introPassed.value = prefs.getBool('introPassed') ?? false;
  }

  Future<void> setIntroPassed(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('introPassed', value);
    introPassed.value = value;
  }
}
