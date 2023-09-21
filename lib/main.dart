import 'package:areaphonebook/utils/app_routes.dart';
import 'package:areaphonebook/utils/mycolors.dart';
import 'package:areaphonebook/utils/apptext.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
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
    return GetMaterialApp(
      title: MyString.appName,
      defaultTransition: Transition.noTransition,
      transitionDuration: const Duration(milliseconds: 200),
      debugShowCheckedModeBanner: false,
      navigatorKey: Get.key,
      initialRoute: RouteHelper.splashScreen,
      getPages: RouteHelper.routes,
    );
  }
}
