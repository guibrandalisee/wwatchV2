import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wwatch/Shared/Themes/app_colors.dart';
import 'package:wwatch/main.dart';
import 'package:wwatch/stores/settings_store.dart';
import 'package:wwatch/stores/style_store.dart';
import 'package:wwatch/stores/user_store.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);
  final double inputWidth = 340;
  final StyleStore styleStore = GetIt.I<StyleStore>();
  final UserStore userStore = GetIt.I<UserStore>();
  final SettingsStore settingsStore = GetIt.I<SettingsStore>();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
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
                    controller: usernameController,
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
                    controller: passwordController,
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
                    launchInBrowser("https://www.themoviedb.org/signup");
                  },
                  child: Text(
                    "Don't have an account? Sign up on the TMDB website!",
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                Observer(builder: (
                  context,
                ) {
                  return SizedBox(
                    height: 46,
                    width: 180,
                    child: ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                              styleStore.primaryColor)),
                      onPressed: !userStore.loading
                          ? () async {
                              if (usernameController.text.isEmpty ||
                                  passwordController.text.isEmpty) {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
                                  content: Text("Preencha todos os campos"),
                                ));
                                return;
                              }

                              userStore.authError = false;
                              userStore.httpError = false;
                              if (userStore.requestToken == null ||
                                  userStore.requestToken!.token.isEmpty ||
                                  (userStore
                                          .requestToken!.expiresAt.isNotEmpty &&
                                      DateTime.parse(
                                              userStore.requestToken!.expiresAt)
                                          .isBefore(DateTime.now().toUtc()))) {
                                await userStore.getRequestToken();
                              }
                              if (!userStore.httpError) {
                                await userStore.createUserSession(
                                    username: usernameController.text,
                                    password: passwordController.text);
                              }
                              if (userStore.loginErrorMessage.isNotEmpty) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content:
                                            Text(userStore.loginErrorMessage),
                                        backgroundColor: Colors.redAccent));
                                userStore.loginErrorMessage = "";
                              }

                              if (userStore.sessionId != null &&
                                  userStore.sessionId!.isNotEmpty) {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
                                  content: Text(
                                    "Logged In!",
                                    style: TextStyle(
                                        color: styleStore.textOnPrimaryColor),
                                  ),
                                  backgroundColor: styleStore.primaryColor,
                                ));

                                //TODO replace this with user screen when it's done
                                //Also change icon on appbar to send user directly to user screen
                                //and only sen them to login screen if sessionId is not present on SharedPreferences
                                // or if it's not valid for requests anymore
                                Navigator.of(context).pop();
                              }
                            }
                          : null,
                      child: !userStore.loading
                          ? Text(
                              "Login",
                              style: GoogleFonts.getFont('Mitr',
                                  color: styleStore.textColor,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w300),
                            )
                          : CircularProgressIndicator(
                              color: styleStore.textOnPrimaryColor,
                            ),
                    ),
                  );
                }),
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
