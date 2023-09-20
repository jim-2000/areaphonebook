import 'package:areaphonebook/screen/home/home_screen.dart';
import 'package:areaphonebook/screen/splash/splashScreen.dart';
import 'package:get/get.dart';

class RouteHelper {
  static const String splashScreen = "/spalsh-screen";
  static const String homeScreen = "/home-screen";

  static List<GetPage> routes = [
    GetPage(name: splashScreen, page: () => const SplashScreen()),
    GetPage(name: homeScreen, page: () => const HomeScreen()),
  ];
}
