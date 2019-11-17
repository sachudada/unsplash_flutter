import 'package:unsplash_flutter/ui/Screens/bmi_main.dart';
import 'package:unsplash_flutter/ui/animations/scale_route.dart';
import 'package:unsplash_flutter/ui/animations/size_transition.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

import 'drawer_menu.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {

  /// Returns the SearchAppBar.
//  Widget _buildSearchAppBar() => SliverAppBar(
//    title: keyword != null
//        ?
//    // either search-field or just the title
//    TextField(
//      keyboardType: TextInputType.text,
//      decoration: InputDecoration(
//          hintText: 'Search...', border: InputBorder.none),
//      onSubmitted: (String keyword) =>
//      // search and display images associated to the keyword
//      _loadImages(keyword: keyword),
//      autofocus: true,
//    )
//        : const Text('Flutter Unsplash',
//        style: TextStyle(color: Colors.black87)),
//    actions: <Widget>[
//      // either search oder clear button
//      keyword != null
//          ? IconButton(
//        icon: Icon(Icons.clear),
//        color: Colors.black87,
//        onPressed: () {
//          // reset the state
//          _resetImages();
//        },
//      )
//          : IconButton(
//        icon: Icon(Icons.search),
//        color: Colors.black87,
//        onPressed: () =>
//        // go into searching state
//        setState(() => keyword = ""),
//      )
//    ],
//    backgroundColor: Colors.grey[50],
//  );

  @override
  Widget build(BuildContext context) {

    // SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.top]);
    // SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return AnnotatedRegion(
      child: Material(
        type: MaterialType.transparency,
        child: Stack(
          children: <Widget>[
            Container(
              child: Image.asset(
                "Assets/Images/fitmen.jpg",
                height: double.infinity,
                width: double.infinity,
                alignment: Alignment.center,
                fit: BoxFit.cover,
                excludeFromSemantics: true,
                scale: 50.0,
              ),
            ),
            Container(
              color: Colors.black54,
            ),
            Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.all(40.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Wallpaper App",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 24.0,
                        fontWeight: FontWeight.w500,),
                  ),
                  TyperAnimatedTextKit(
                    duration: Duration(
                      seconds: 2,
                    ),
                    textAlign: TextAlign.start,
                    alignment: AlignmentDirectional.bottomCenter,
                    isRepeatingAnimation: false,
                    textStyle: TextStyle(
                        color: Colors.green.shade200,
                        fontSize: 100.0,
                        fontWeight: FontWeight.w900),
                    text: <String>["Pixcy."],
                  )
                ],
              ),
            ),
            Container(
              alignment: Alignment.bottomCenter,
              margin: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 60.0),
              child: MaterialButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(22.0)),
                minWidth: 200.0,
                height: 45,
                elevation: 10.0,
                color: Colors.white,
                child: new Text('Let\'s get started',
                    style: new TextStyle(
                        fontSize: 16.0,
                        color: Colors.deepPurple,
                        fontWeight: FontWeight.w800)),
                onPressed: () {
                  Navigator.pushReplacement(context, SizeRoute(page: DrawerMenu()));
                },
              ),
            ),
          ],
        ),
      ),
      value: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: Colors.transparent,
        systemNavigationBarDividerColor: Colors.transparent,
        systemNavigationBarIconBrightness: Brightness.light,
      ),
    );
  }
}
