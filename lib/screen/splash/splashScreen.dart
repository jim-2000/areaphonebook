// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'dart:developer';

import 'package:areaphonebook/screen/home/home_screen.dart';
import 'package:areaphonebook/utils/app_animation.dart';
import 'package:areaphonebook/utils/mycolors.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatefulWidget {
  static const routeName = "splash_screen";

  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late ConnectivityResult result;
  late StreamSubscription subscription;
  bool isDeviceConnected = true;

  @override
  void initState() {
    log("splash_screen");
    FlutterNativeSplash.remove();
    startStreaming();
    super.initState();
  }

  @override
  void dispose() {
    subscription.cancel();
    super.dispose();
  }

  void startStreaming() {
    subscription = Connectivity().onConnectivityChanged.listen((event) async {
      await checkInternet();
    });
  }

  checkInternet() async {
    result = await Connectivity().checkConnectivity();
    log(result.name);
    if (result != ConnectivityResult.none) {
      isDeviceConnected = true;
      subscription.cancel();
      Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
    } else {
      isDeviceConnected = false;
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColor.primary,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          !isDeviceConnected
              ? const SizedBox.shrink()
              : Container(
                  color: Colors.white,
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.1,
                      ),
                      const Text(
                        "Something Went Wrong!",
                        style: TextStyle(fontSize: 24, fontWeight: FontWeight.w400),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        "It seems that there is no active internet connection...",
                        style: TextStyle(fontSize: 14, color: Colors.grey.shade700),
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      Center(
                        child: LottieBuilder.asset(
                          MyAnimations.noInternet,
                          height: 400,
                        ),
                      ),
                    ],
                  ))
        ],
      ),
    );
  }
}
