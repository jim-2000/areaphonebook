import 'package:areaphonebook/utils/app_animation.dart';
import 'package:areaphonebook/utils/app_routes.dart';
import 'package:areaphonebook/utils/dimention.dart';
import 'package:areaphonebook/utils/mycolors.dart';
import 'package:areaphonebook/utils/url.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Future.delayed(
        const Duration(microseconds: 3000),
        () {
          Get.offAllNamed(RouteHelper.homeScreen);
        },
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColor.primary,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Align(
            child: Container(
              padding: const EdgeInsets.all(6),
              height: Dimensions.appLogoHeight,
              width: Dimensions.appLogoWidth,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(60),
              ),
              child: Lottie.asset(MyAnimations.phone),
            ),
          )
        ],
      ),
    );
  }
}
