import 'dart:async';
import 'dart:io';
import 'package:areaphonebook/utils/app_animation.dart';
import 'package:areaphonebook/utils/mycolors.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
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
  bool isLoading = true;

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
    FlutterNativeSplash.remove();
    // startStreaming();
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
    return WillPopScope(
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
        backgroundColor: MyColor.primary,
        body: Stack(
          children: [
            isLoading
                ? Container(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    color: MyColor.primary,
                    child: const Align(alignment: Alignment.topCenter, child: CircularProgressIndicator(color: MyColor.primary)),
                  )
                : const SizedBox.shrink(),
            SafeArea(
              child: InAppWebView(
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
                    isLoading = false;
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
          ],
        ),
      ),
    );
  }
}
