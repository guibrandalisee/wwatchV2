import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:transition/transition.dart';
import 'package:wwatch/Screens/login/login_screen.dart';
import 'package:wwatch/Shared/Themes/app_colors.dart';
import 'package:wwatch/stores/settings_store.dart';
import 'package:wwatch/stores/style_store.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    StyleStore styleStore = GetIt.I<StyleStore>();
    SettingsStore settingsStore = GetIt.I<SettingsStore>();
    final double inputWidth = 260;
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
              child: Image.asset(
                "assets/images/WWatch2-png.png",
                color: settingsStore.brightness != CustomBrightness.amoled
                    ? AppColors.textOnPrimaries[styleStore.colorIndex!]
                    : styleStore.primaryColor,
                fit: BoxFit.fitHeight,
                filterQuality: FilterQuality.medium,
              ),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: double.infinity,
              height: 60,
            ),
            Text(
              "SIGN UP",
              style: GoogleFonts.getFont('Mitr',
                  color: styleStore.textColor,
                  fontSize: 48,
                  fontWeight: FontWeight.w300),
            ),
            SizedBox(
              height: 32,
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
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
                        decoration: InputDecoration(
                            isDense: true,
                            border: InputBorder.none,
                            hintText: "Password..."),
                      ),
                    ),
                    SizedBox(
                      height: 32,
                    ),
                    SizedBox(
                      width: inputWidth,
                      child: Text(
                        "Repeat Password",
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
                            hintText: "Repeat Password..."),
                      ),
                    ),
                    SizedBox(
                      height: 32,
                    ),
                    SizedBox(
                      width: inputWidth,
                      child: Text(
                        "E-Mail",
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
                            hintText: "E-Mail..."),
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Container(
                      width: inputWidth,
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                              context,
                              Transition(
                                  child: LoginScreen(),
                                  transitionEffect: TransitionEffect.FADE));
                        },
                        child: Text(
                          "already have an account? Login!",
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Container(
                      width: inputWidth,
                      alignment: Alignment.centerRight,
                      child: SizedBox(
                        height: 46,
                        width: 180,
                        child: ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                  styleStore.primaryColor)),
                          onPressed: () {},
                          child: Text(
                            "Sign Up",
                            style: GoogleFonts.getFont('Mitr',
                                color: styleStore.textColor,
                                fontSize: 18,
                                fontWeight: FontWeight.w300),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 40,
                    )
                  ],
                ),
                SizedBox(
                  width: 16,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: styleStore.primaryColor,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(16),
                              bottomRight: Radius.circular(16),
                            ),
                          ),
                          height: 420,
                          width: 24,
                        ),
                        SizedBox(
                          height: 40,
                        )
                      ],
                    ),
                    SizedBox(
                      width: 16,
                    ),
                    Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: styleStore.primaryColor,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(16),
                              bottomRight: Radius.circular(16),
                            ),
                          ),
                          height: 420,
                          width: 24,
                        ),
                        SizedBox(
                          height: 80,
                        )
                      ],
                    ),
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
