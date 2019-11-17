import 'package:unsplash_flutter/ui/Global%20Variables/globals.dart';
import 'package:unsplash_flutter/ui/Screens/about.dart';
import 'package:unsplash_flutter/ui/Screens/bmi_main.dart';
import 'package:unsplash_flutter/ui/Screens/settings.dart';
import 'package:unsplash_flutter/ui/Utilities/app_util.dart';
import 'package:unsplash_flutter/ui/Utilities/my_theme_keys.dart';
import 'package:unsplash_flutter/ui/Utilities/shared_preference_handler.dart';
import 'package:unsplash_flutter/ui/Utilities/theme_handler.dart';
import 'package:unsplash_flutter/ui/animations/size_transition.dart';
import 'package:drawerbehavior/drawer_scaffold.dart';
import 'package:drawerbehavior/menu_screen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:launch_review/launch_review.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:unsplash_flutter/main_page.dart';
import '../../main_page.dart';

class DrawerMenu extends StatefulWidget {
  @override
  _DrawerMenuState createState() => _DrawerMenuState();
}

class _DrawerMenuState extends State<DrawerMenu> {
  Icon icon = Icon(
    FontAwesomeIcons.solidMoon,
    color: Colors.black38,
  );
  void getTheme() async {
    var key = await SharedPreference.getStringValue(SharedPreference.selectedTheme);
    switch (key) {
      case "MyThemeKeys.LIGHT":
        isDarkTheme = false;
        isSwitched = false;
        themeLabel = "Light Mode";
        icon = Icon(FontAwesomeIcons.solidMoon, color: Colors.black38);
        break;
      case "MyThemeKeys.DARKER":
        isDarkTheme = true;
        isSwitched = true;
        themeLabel = "Dark Mode";
        icon = Icon(FontAwesomeIcons.solidSun);
        break;
      default:
        isDarkTheme = false;
        isSwitched = false;
        themeLabel = "Light Mode";
        icon = Icon(FontAwesomeIcons.solidMoon, color: Colors.black38);
        break;
    }
  }

  void _changeTheme(BuildContext buildContext, MyThemeKeys key) {
    CustomTheme.instanceOf(buildContext).changeTheme(key);
  }

  final menu = new Menu(
    items: [
      new MenuItem(id: 'home', title: 'Home'),
      new MenuItem(id: 'setting', title: 'Settings'),
      new MenuItem(id: 'aboutapp', title: 'About App'),
      new MenuItem(id: 'share', title: 'Share App'),
      new MenuItem(id: 'rateus', title: 'Rate App'),
      new MenuItem(id: 'feedback', title: 'Send Feedback')
    ],
  );

  var selectedMenuItemId = 'home';
  var _widget = Text("1");

  Widget headerView(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(20.0, 0.0, 0.0, 0.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: 20),
          Image(
              image: AssetImage("Assets/Images/ic_launcher.png"),
              filterQuality: FilterQuality.high,
              width: 100.0,
              height: 100.0),
          Text("  Pixcy.",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 34.0,
                  fontWeight: FontWeight.bold))
        ],
      ),
    );
  }

  Widget footerView(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(30.0, 0.0, 0.0, 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Row(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Text(
                "Built with  ",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 10.0,
                    fontWeight: FontWeight.w600),
              ),
              Icon(
                FontAwesomeIcons.solidHeart,
                color: Colors.red,
                size: 10,
              ),
              Text(
                "  By",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 10.0,
                    fontWeight: FontWeight.w600),
              )
            ],
          ),
          Text(""),
          GestureDetector(
            child: Row(
              children: <Widget>[
                CircleAvatar(
                    radius: 20.0,
                    backgroundImage: NetworkImage('https://lh3.googleusercontent.com/oLHQXqxsiMHZ9li0UUB60p_3XtK59bR2v_jSDMF-zAYaGJXktbmi0N9sk8KZx5zY88w=w144-h144-n-rw')),
                Text("  Sk Developer\n  Studios",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold))
              ],
            ),
            onTap: () {
              _launchURL();
            },
          ),
        ],
      ),
    );
  }

  _launchURL() async {
    const url = 'https://play.google.com/store/apps/dev?id=8692000933032355843';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }



  @override
  Widget build(BuildContext context) {
    getTheme();
    setState(() => _widget = Text("default"));

    return new DrawerScaffold(
      percentage: .8,
      cornerRadius: 20,
      showAppBar: true,
      appBar: AppBarProps(
          automaticallyImplyLeading: true,
          primary: true,
          backgroundColor: Theme.of(context).primaryColor,
          elevation: 1.0,
          centerTitle: true,
          title: Text('Pixcy Wallpaper',
              textDirection: TextDirection.ltr,
              style: TextStyle(
                  color: Theme.of(context).accentColor,
                  fontSize: 16.0,
                  fontWeight: FontWeight.w900)),
          actions: <Widget>[
            Container(
              padding: EdgeInsets.fromLTRB(0.0, 0.0, 15.0, 0.0),
              height: MediaQuery.of(context).size.height,
              child: IconButton(
                icon: icon,
                onPressed: () {
                  setState(() {

                    if (isDarkTheme) {
                      isDarkTheme = false;
                      isSwitched = false;
                      themeLabel = "Light Mode";
                      icon = Icon(FontAwesomeIcons.solidMoon,
                          color: Colors.black38);
                      _changeTheme(context, MyThemeKeys.LIGHT);
                      SharedPreference.setStringValue(
                          SharedPreference.selectedTheme,
                          MyThemeKeys.LIGHT.toString());
                    } else {
                      isDarkTheme = true;
                      isSwitched = true;
                      themeLabel = "Dark Mode";
                      icon = Icon(FontAwesomeIcons.solidSun);
                      _changeTheme(context, MyThemeKeys.DARKER);
                      SharedPreference.setStringValue(
                          SharedPreference.selectedTheme,
                          MyThemeKeys.DARKER.toString());
                    }
                  });
                },
              ),
            )
          ]),
      menuView: new MenuView(
        menu: menu,
        headerView: headerView(context),
        footerView: footerView(context),
        animation: true,
        padding: EdgeInsets.fromLTRB(40.0, 16.0, 0.0, 10.0),
        color: Colors.black87,
        background: DecorationImage(
            image: AssetImage("Assets/Images/fitmen.jpg"),
            colorFilter: ColorFilter.mode(Colors.white54, BlendMode.dstOut),
            fit: BoxFit.cover),
        selectorColor: Color.fromRGBO(67, 193, 152, 1),
        textStyle: TextStyle(
            fontWeight: FontWeight.bold, fontSize: 17.0, color: Colors.white70),
        selectedItemId: selectedMenuItemId,
        onMenuItemSelected: (String itemId) {
          selectedMenuItemId = itemId;
          switch (itemId) {
            case 'home':
              setState(() => _widget = Text("1"));
              break;
            case 'setting':
              initMeasurementUnit();
              Navigator.push(context, SizeRoute(page: Settings()));
              setState(() => _widget = Text("default"));
              break;
            case 'aboutapp':
              Navigator.push(context, SizeRoute(page: AboutUS()));
              setState(() => _widget = Text("default"));
              break;
            case 'share':
              AppUtil.onShareTap(context);
              setState(() => _widget = Text("default"));
              break;
            case 'rateus':
              LaunchReview.launch();
              setState(() => _widget = Text("default"));
              break;
            case 'feedback':
              var emailUrl = mailTo;
              var out = Uri.encodeFull(emailUrl);
              launchURL(out);
              setState(() => _widget = Text("default"));
              break;
            default:
              setState(() => _widget = Text("default"));
              break;
          }
        },
      ),
      contentView: Screen(
        contentBuilder: (context) => Center(child: MainPage()),
        color: Colors.white,
      ),
    );
  }

  void initMeasurementUnit() {
    // selectedChoice = SharedPreference.getStringValue(SharedPreference.selectedMUnit)??"";
    print("chip ${SharedPreference.getStringValue(SharedPreference.selectedMUnit)}");
  }

  launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
