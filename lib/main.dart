//import 'package:flutter/material.dart';
//import 'package:unsplash_flutter/main_page.dart';
//import 'package:flutter/services.dart';
//import 'dart:async';
//
//void main() => runApp(FlutterUnsplash());
//
//class FlutterUnsplash extends StatelessWidget {
//  @override
//  Widget build(BuildContext context) {
//    // set status bar color
//    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
//      statusBarColor: Colors.black12,
//    ));
//
//    return new MaterialApp(
//      title: 'Flutter Unsplash',
//      theme: ThemeData(
//        accentColor: Colors.grey[400],
//        canvasColor: Colors.transparent,
//      ),
//      home: MainPage(),
//      debugShowCheckedModeBanner: false,
//    );
//  }
//}
import 'package:unsplash_flutter/ui/Global%20Variables/globals.dart';
import 'package:unsplash_flutter/ui/Screens/splash.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_version/get_version.dart';
import 'package:unsplash_flutter/ui/Utilities/my_theme_keys.dart';
import 'package:unsplash_flutter/ui/Utilities/shared_preference_handler.dart';
import 'package:unsplash_flutter/ui/Utilities/theme_handler.dart';


import 'main_page.dart';
import 'ui/constants.dart';

void main() {
  getTheme();
  updateStatusBarColor();
  getAppVersionName();
}

/* Method for change Statusbar color*/
void updateStatusBarColor() {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    systemNavigationBarColor: Colors.black,
    statusBarColor: Colors.white,
  ));
}

void getAppVersionName() async {
  try {
    platformVersion = await GetVersion.projectVersion;
  } on PlatformException {
    platformVersion = 'Failed to get platform version.';
  }
}

void getTheme() async {
  var key = await SharedPreference.getStringValue(SharedPreference.selectedTheme);
  switch (key) {
    case "MyThemeKeys.LIGHT":
      isDarkTheme = false;
      runApp(CustomTheme(initialThemeKey: MyThemeKeys.LIGHT, child: MyApp()));
      break;
    case "MyThemeKeys.DARKER":
      isDarkTheme = true;
      runApp(CustomTheme(initialThemeKey: MyThemeKeys.DARKER, child: MyApp()));
      break;
    default:
      isDarkTheme = false;
      runApp(CustomTheme(initialThemeKey: MyThemeKeys.LIGHT, child: MyApp()));
      break;
  }
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
        SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
      statusBarColor: Colors.black12,
    ));
// SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return MaterialApp(
      title: 'Pixcy',
      debugShowCheckedModeBanner: false,
      theme: CustomTheme.of(context),
      home: Splash(),
    );
  }
}
