import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wwatch/Screens/home/home_screen.dart';
import 'package:wwatch/l10n/l10n.dart';
import 'package:wwatch/stores/settings_store.dart';
import 'package:wwatch/stores/style_store.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart' as DotEnv;
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

//TODO add routes 2.0

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DotEnv.load(fileName: "api.env");
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
      builder: (_) => MyApp(prefs),
    ),
  );
}

void setupLocators(SharedPreferences preferences) {
  GetIt.I.registerSingleton(SettingsStore(prefs: preferences));

  GetIt.I.registerSingleton(StyleStore(prefs: preferences));
}

Future<void> launchInBrowser(String url) async {
  try {
    await launch(
      url,
      forceSafariVC: false,
      forceWebView: false,
    );
  } catch (e) {
    print(e);
  }
}

class MyApp extends StatelessWidget {
  MyApp(this.prefs);
  final SharedPreferences prefs;

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
      home: HomeScreen(
        contentType: type.movie,
        prefs: prefs,
      ),
      supportedLocales: L10n.all,
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate
      ],
    );
  }
}
