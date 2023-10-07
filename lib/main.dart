import 'package:areaphonebook/screen/home/home_screen.dart';
import 'package:areaphonebook/screen/splash/splashScreen.dart';
import 'package:areaphonebook/utils/mycolors.dart';
import 'package:areaphonebook/utils/apptext.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await FlutterDownloader.initialize(debug: true, ignoreSsl: true);

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      // systemNavigationBarColor: MyColor.primary,
      statusBarColor: MyColor.primary, // status bar color
    ),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: MyString.appName,
      debugShowCheckedModeBanner: false,
      // navigatorKey: Get.key,
      initialRoute: SplashScreen.routeName,
      routes: {
        SplashScreen.routeName: (context) => const SplashScreen(),
        HomeScreen.routeName: (context) => const HomeScreen(),
      },
    );
  }
}
