import 'dart:async';
import 'dart:io';
import 'package:areaphonebook/utils/app_animation.dart';
import 'package:areaphonebook/utils/mycolors.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:lottie/lottie.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = "home_screen";
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late ConnectivityResult result;
  late StreamSubscription subscription;
  bool isDeviceConnected = false;

  String url = 'https://areaphonebook.com';
  final GlobalKey webViewKey = GlobalKey();

  InAppWebViewController? webViewController;
  InAppWebViewGroupOptions options = InAppWebViewGroupOptions(
      crossPlatform: InAppWebViewOptions(
        useShouldOverrideUrlLoading: true,
        mediaPlaybackRequiresUserGesture: false,
        supportZoom: false,
        clearCache: true,
        javaScriptEnabled: true,
        verticalScrollBarEnabled: false,
        cacheEnabled: true,
        javaScriptCanOpenWindowsAutomatically: true,
        useOnLoadResource: true,
      ),
      android: AndroidInAppWebViewOptions(
        useHybridComposition: true,
        scrollbarFadingEnabled: false,
        allowContentAccess: true,
        displayZoomControls: false,
        builtInZoomControls: false,
        clearSessionCache: false,
        cacheMode: AndroidCacheMode.LOAD_DEFAULT,
        domStorageEnabled: true,
      ),
      ios: IOSInAppWebViewOptions(
        allowsInlineMediaPlayback: true,
      ));

  @override
  void initState() {
    startStreaming();
    if (Platform.isAndroid) {
      AndroidInAppWebViewController.setWebContentsDebuggingEnabled(true);
    }
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
    if (result != ConnectivityResult.none) {
      isDeviceConnected = true;
      subscription.cancel();
    } else {
      isDeviceConnected = false;
    }
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: WillPopScope(
        onWillPop: () async {
          final controller = webViewController;
          if (controller != null) {
            if (await controller.canGoBack()) {
              controller.goBack();
              return false;
            }
          }
          return true;
        },
        child: Scaffold(
          backgroundColor: isDeviceConnected ? MyColor.primary : Colors.white,
          body: !isDeviceConnected
              ? SizedBox(
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
              : InAppWebView(
                  key: webViewKey,
                  initialUrlRequest: URLRequest(url: Uri.parse(url)),
                  onWebViewCreated: (controller) {
                    webViewController = controller;
                  },
                  initialOptions: options,
                  onLoadStart: (controller, url) async {
                    setState(() {
                      this.url = url.toString();
                    });
                  },
                  androidOnPermissionRequest: (controller, origin, resources) async {
                    return PermissionRequestResponse(resources: resources, action: PermissionRequestResponseAction.GRANT);
                  },
                  shouldOverrideUrlLoading: (controller, navigationAction) async {
                    var uri = navigationAction.request.url!;

                    if (uri.scheme == "tel") {
                      if (await canLaunchUrl(Uri.parse(url))) {
                        launchUrl(
                          uri,
                          mode: LaunchMode.externalApplication,
                        );
                      }
                      return NavigationActionPolicy.CANCEL;
                    }
                    if (!["http", "https", "file", "chrome", "data", "javascript", "about"].contains(uri.scheme)) {
                      await launchUrl(
                        Uri.parse(url),
                        mode: LaunchMode.inAppWebView,
                        webViewConfiguration: const WebViewConfiguration(
                          enableJavaScript: true,
                        ),
                      );
                      return NavigationActionPolicy.CANCEL;
                    }
                    return NavigationActionPolicy.ALLOW;
                  },
                  onLoadStop: (controller, url) async {
                    await controller.injectJavascriptFileFromUrl(
                      urlFile: Uri.parse("https://code.jquery.com/jquery-1.8.3.min.js"),
                    );

                    setState(() {
                      this.url = url.toString();
                    });
                  },
                  onLoadError: (controller, url, code, message) {},
                  onProgressChanged: (controller, progress) {},
                  onUpdateVisitedHistory: (controller, url, androidIsReload) {
                    setState(() {
                      this.url = url.toString();
                    });
                  },
                  onConsoleMessage: (controller, consoleMessage) {},
                ),
        ),
      ),
    );
  }
}
