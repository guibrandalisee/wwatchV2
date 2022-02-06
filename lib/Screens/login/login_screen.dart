import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:transition/transition.dart';
import 'package:wwatch/Screens/signup/signup_screen.dart';
import 'package:wwatch/Shared/Themes/app_colors.dart';
import 'package:wwatch/stores/settings_store.dart';
import 'package:wwatch/stores/style_store.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double inputWidth = 340;
    StyleStore styleStore = GetIt.I<StyleStore>();

    SettingsStore settingsStore = GetIt.I<SettingsStore>();
    return Scaffold(
      backgroundColor: styleStore.backgroundColor,
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: settingsStore.brightness != CustomBrightness.amoled
              ? AppColors.textOnPrimaries[styleStore.colorIndex!]
              : styleStore.primaryColor,
        ),
        backgroundColor: settingsStore.brightness == CustomBrightness.amoled
            ? styleStore.backgroundColor
            : styleStore.primaryColor,
        title: Container(
          child: Hero(
            tag: "logo",
            child: SizedBox(
              height: 56,
              child: Image(
                image: ResizeImage(
                    AssetImage(
                      'assets/images/WWatch2-png.png',
                    ),
                    height: 156,
                    width: 156),
                filterQuality: FilterQuality.medium,
                color: settingsStore.brightness != CustomBrightness.amoled
                    ? AppColors.textOnPrimaries[styleStore.colorIndex!]
                    : styleStore.primaryColor,
              ),
            ),
          ),
        ),
      ),
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          Container(
            height: double.infinity,
            alignment: Alignment.bottomCenter,
            child: ColorFiltered(
              child: Image.asset(
                "assets/images/LoginDecoration.png",
                filterQuality: FilterQuality.medium,
              ),
              colorFilter: ColorFilter.mode(
                  styleStore.primaryColor!.withAlpha(200), BlendMode.modulate),
            ),
          ),
          SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  width: double.infinity,
                  height: 60,
                ),
                Text(
                  "LOGIN",
                  style: GoogleFonts.getFont('Mitr',
                      color: styleStore.textColor,
                      fontSize: 48,
                      fontWeight: FontWeight.w300),
                ),
                SizedBox(
                  height: 60,
                ),
                SizedBox(
                  width: inputWidth,
                  child: Text(
                    "Username",
                    style: GoogleFonts.getFont('Mitr',
                        color: styleStore.textColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w100),
                    textAlign: TextAlign.start,
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                Container(
                  padding: EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  width: inputWidth,
                  child: TextField(
                    decoration: InputDecoration(
                        isDense: true,
                        border: InputBorder.none,
                        hintText: "Username..."),
                  ),
                ),
                SizedBox(
                  height: 32,
                ),
                SizedBox(
                  width: inputWidth,
                  child: Text(
                    "Password",
                    style: GoogleFonts.getFont('Mitr',
                        color: styleStore.textColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w100),
                    textAlign: TextAlign.start,
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                Container(
                  padding: EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  width: inputWidth,
                  child: TextField(
                    obscureText: true,
                    decoration: InputDecoration(
                      isDense: true,
                      border: InputBorder.none,
                      hintText: "Password...",
                    ),
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                        context,
                        Transition(
                            child: SignupScreen(),
                            transitionEffect: TransitionEffect.FADE));
                  },
                  child: Text(
                    "Don't have an accout? Sign Up!",
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                SizedBox(
                  height: 46,
                  width: 180,
                  child: ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(styleStore.primaryColor)),
                    onPressed: () {},
                    child: Text(
                      "Login",
                      style: GoogleFonts.getFont('Mitr',
                          color: styleStore.textColor,
                          fontSize: 18,
                          fontWeight: FontWeight.w300),
                    ),
                  ),
                ),
                SizedBox(
                  height: 16,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
