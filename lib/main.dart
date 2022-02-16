import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wwatch/Screens/home/home_screen.dart';
import 'package:wwatch/stores/settings_store.dart';
import 'package:wwatch/stores/style_store.dart';

//TODO add routes 2.0
//TODO reduce the number of lines in all build methods

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    systemNavigationBarColor: Colors.transparent,
  ));
  SystemChrome.setEnabledSystemUIMode(
    SystemUiMode.edgeToEdge,
  );
  SharedPreferences prefs = await SharedPreferences.getInstance();
  setupLocators(prefs);
  runApp(
    DevicePreview(
      enabled: false,
      builder: (_) => MyApp(),
    ),
  );
}

void setupLocators(SharedPreferences preferences) {
  GetIt.I.registerSingleton(SettingsStore(prefs: preferences));

  GetIt.I.registerSingleton(StyleStore(prefs: preferences));
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
      builder: DevicePreview.appBuilder,
      locale: DevicePreview.locale(context),
      debugShowCheckedModeBanner: false,
      title: 'WWatch',
      theme: ThemeData(
          primarySwatch: Colors.blue,
          appBarTheme: AppBarTheme(
            systemOverlayStyle: SystemUiOverlayStyle(
              // Navigation bar
              statusBarColor: Colors.transparent,

              // Status bar
            ),
          )),
      //home: WelcomeScreen(),
      home: HomeScreen(contentType: type.movie),
    );
  }
}
//gradle-wrapper.properties \/
//distributionUrl=https\://services.gradle.org/distributions/gradle-6.7-all.zip

//android/buid.gradle \/
//    dependencies {
//        classpath 'com.android.tools.build:gradle:4.1.0'
//        classpath "org.jetbrains.kotlin:kotlin-gradle-plugin:$kotlin_version"
//    }