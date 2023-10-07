// flutter_native_splash:
//   # This package generates native code to customize Flutter's default white native splash screen
//   # with background color and splash image.
//   # Customize the parameters below, and run the following command in the terminal:
//   # dart run flutter_native_splash:create
//   # To restore Flutter's default white splash screen, run the following command in the terminal:
//   # dart run flutter_native_splash:remove

//   # IMPORTANT NOTE: These parameter do not affect the configuration of Android 12 and later, which
//   # handle splash screens differently that prior versions of Android.  Android 12 and later must be
//   # configured specifically in the android_12 section below.
  
//   # color or background_image is the only required parameter.  Use color to set the background
//   # of your splash screen to a solid color.  Use background_image to set the background of your
//   # splash screen to a png image.  This is useful for gradients. The image will be stretch to the
//   # size of the app. Only one parameter can be used, color and background_image cannot both be set.
//   color: "#E84C3D"
//   #background_image: "assets/background.png"

//   # Optional parameters are listed below.  To enable a parameter, uncomment the line by removing
//   # the leading # character.

//   # The image parameter allows you to specify an image used in the splash screen.  It must be a
//   # png file and should be sized for 4x pixel density.
//   #image: assets/splash.png assets/imgs/splash.png

//   # The branding property allows you to specify an image used as branding in the splash screen.
//   # It must be a png file. It is supported for Android, iOS and the Web.  For Android 12,
//   # see the Android 12 section below.
//   branding: assets/imgs/splash.png

//   # To position the branding image at the bottom of the screen you can use bottom, bottomRight,
//   # and bottomLeft. The default values is bottom if not specified or specified something else.
//   #branding_mode: bottom

//   # The color_dark, background_image_dark, image_dark, branding_dark are parameters that set the background
//   # and image when the device is in dark mode. If they are not specified, the app will use the
//   # parameters from above. If the image_dark parameter is specified, color_dark or
//   # background_image_dark must be specified.  color_dark and background_image_dark cannot both be
//   # set.
//   #color_dark: "#042a49"
//   #background_image_dark: "assets/dark-background.png"
//   #image_dark: assets/splash-invert.png
//   #branding_dark: assets/dart_dark.png

//   # Android 12 handles the splash screen differently than previous versions.  Please visit
//   # https://developer.android.com/guide/topics/ui/splash-screen
//   # Following are Android 12 specific parameter.
//   android_12:
//     # The image parameter sets the splash screen icon image.  If this parameter is not specified,
//     # the app's launcher icon will be used instead.
//     # Please note that the splash screen will be clipped to a circle on the center of the screen.
//     # App icon with an icon background: This should be 960×960 pixels, and fit within a circle
//     # 640 pixels in diameter.
//     # App icon without an icon background: This should be 1152×1152 pixels, and fit within a circle
//     # 768 pixels in diameter.
//     #image: assets/android12splash.png

//     # Splash screen background color.
//     #color: "#E84C3D"

//     # App icon background color.
//     #icon_background_color: "#111111"

//     # The branding property allows you to specify an image used as branding in the splash screen.
//     #branding: assets/dart.png

//     # The image_dark, color_dark, icon_background_color_dark, and branding_dark set values that
//     # apply when the device is in dark mode. If they are not specified, the app will use the
//     # parameters from above.
//     #image_dark: assets/android12splash-invert.png
//     #color_dark: "#042a49"
//     #icon_background_color_dark: "#eeeeee"

//   # The android, ios and web parameters can be used to disable generating a splash screen on a given
//   # platform.
//   #android: false
//   #ios: false
//   #web: false

//   # Platform specific images can be specified with the following parameters, which will override
//   # the respective parameter.  You may specify all, selected, or none of these parameters:
//   #color_android: "#42a5f5"
//   #color_dark_android: "#042a49"
//   #color_ios: "#42a5f5"
//   #color_dark_ios: "#042a49"
//   #color_web: "#42a5f5"
//   #color_dark_web: "#042a49"
//   #image_android: assets/splash-android.png
//   #image_dark_android: assets/splash-invert-android.png
//   #image_ios: assets/splash-ios.png
//   #image_dark_ios: assets/splash-invert-ios.png
//   #image_web: assets/splash-web.gif
//   #image_dark_web: assets/splash-invert-web.gif
//   #background_image_android: "assets/background-android.png"
//   #background_image_dark_android: "assets/dark-background-android.png"
//   #background_image_ios: "assets/background-ios.png"
//   #background_image_dark_ios: "assets/dark-background-ios.png"
//   #background_image_web: "assets/background-web.png"
//   #background_image_dark_web: "assets/dark-background-web.png"
//   #branding_android: assets/brand-android.png
//   #branding_dark_android: assets/dart_dark-android.png
//   #branding_ios: assets/brand-ios.gif
//   #branding_dark_ios: assets/dart_dark-ios.gif

//   # The position of the splash image can be set with android_gravity, ios_content_mode, and
//   # web_image_mode parameters.  All default to center.
//   #
//   # android_gravity can be one of the following Android Gravity (see
//   # https://developer.android.com/reference/android/view/Gravity): bottom, center,
//   # center_horizontal, center_vertical, clip_horizontal, clip_vertical, end, fill, fill_horizontal,
//   # fill_vertical, left, right, start, or top.
//   android_gravity: center
//   #
//   # ios_content_mode can be one of the following iOS UIView.ContentMode (see
//   # https://developer.apple.com/documentation/uikit/uiview/contentmode): scaleToFill,
//   # scaleAspectFit, scaleAspectFill, center, top, bottom, left, right, topLeft, topRight,
//   # bottomLeft, or bottomRight.
//   ios_content_mode: center
//   #
//   # web_image_mode can be one of the following modes: center, contain, stretch, and cover.
//   #web_image_mode: center

//   # The screen orientation can be set in Android with the android_screen_orientation parameter.
//   # Valid parameters can be found here:
//   # https://developer.android.com/guide/topics/manifest/activity-element#screen
//   #android_screen_orientation: sensorLandscape

//   # To hide the notification bar, use the fullscreen parameter.  Has no effect in web since web
//   # has no notification bar.  Defaults to false.
//   # NOTE: Unlike Android, iOS will not automatically show the notification bar when the app loads.
//   #       To show the notification bar, add the following code to your Flutter app:
//   #       WidgetsFlutterBinding.ensureInitialized();
//   #       SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [SystemUiOverlay.bottom, SystemUiOverlay.top], );
//   #fullscreen: true

//   # If you have changed the name(s) of your info.plist file(s), you can specify the filename(s)
//   # with the info_plist_files parameter.  Remove only the # characters in the three lines below,
//   # do not remove any spaces:
//   #info_plist_files:
//   #  - 'ios/Runner/Info-Debug.plist'
//   #  - 'ios/Runner/Info-Release.plist'