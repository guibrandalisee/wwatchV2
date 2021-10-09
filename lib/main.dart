import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wwatch/Screens/welcome/welcome_screen.dart';
import 'package:wwatch/stores/settings_store.dart';
import 'package:wwatch/stores/style_store.dart';

//TODO recreate the project with flutter create because of issues after updating to flutter 2.5

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    systemNavigationBarColor: Colors.transparent,
  ));
  SystemChrome.setEnabledSystemUIMode(
    SystemUiMode.edgeToEdge,
  );
  runApp(MyApp());
  runApp(MyApp());
  SharedPreferences prefs = await SharedPreferences.getInstance();
  setupLocators(prefs);
}

void setupLocators(SharedPreferences preferences) {
  GetIt.I.registerSingleton(StyleStore(prefs: preferences));
  GetIt.I.registerSingleton(SettingsStore(prefs: preferences));
}

Future<void> launchInBrowser(String url) async {
  if (await canLaunch(url)) {
    await launch(
      url,
      forceSafariVC: false,
      forceWebView: false,
    );
  } else {
    throw 'Could not launch $url';
  }
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
          primarySwatch: Colors.blue,
          appBarTheme: AppBarTheme(
            systemOverlayStyle: SystemUiOverlayStyle(
              // Navigation bar
              statusBarColor: Colors.transparent,

              // Status bar
            ),
          )),
      home: WelcomeScreen(),
    );
  }
}
