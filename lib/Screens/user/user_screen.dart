import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wwatch/Screens/full_screen_image/full_screen_image.dart';
import 'package:wwatch/Shared/Themes/app_colors.dart';
import 'package:wwatch/Shared/models/user_model.dart';
import 'package:wwatch/stores/settings_store.dart';
import 'package:wwatch/stores/style_store.dart';
import 'package:wwatch/stores/user_store.dart';

class UserScreen extends StatefulWidget {
  UserScreen({Key? key}) : super(key: key);

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  final SettingsStore settingsStore = GetIt.I<SettingsStore>();

  final StyleStore styleStore = GetIt.I<StyleStore>();

  final UserStore userStore = GetIt.I<UserStore>();

  @override
  void initState() {
    if (userStore.user == null) {
      userStore.getUserDetails();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(userStore.sessionId);

    return Scaffold(
      backgroundColor: styleStore.backgroundColor,
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (context) {
                    return Observer(builder: (context) {
                      return AlertDialog(
                        backgroundColor: styleStore.backgroundColor,
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Logout?",
                              style: GoogleFonts.getFont('Mitr',
                                  color: styleStore.textColor,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w300),
                            ),
                            SizedBox(
                              height: 16,
                            ),
                            Text(
                              "Are you sure you want to logout?",
                              style: GoogleFonts.getFont('Mitr',
                                  color: styleStore.textColor,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w100),
                            )
                          ],
                        ),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text(
                              "Cancel",
                              style: TextStyle(color: styleStore.primaryColor),
                            ),
                            style: ButtonStyle(
                                overlayColor: MaterialStateProperty.all(
                                    styleStore.shapeColor!.withAlpha(100))),
                          ),
                          ElevatedButton(
                            onPressed: !userStore.loading
                                ? () async {
                                    final response =
                                        await userStore.deleteSession();
                                    Navigator.of(context).pop();
                                    if (response) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                              content: Text("Logged Out"),
                                              backgroundColor:
                                                  styleStore.primaryColor));
                                      Navigator.of(context).pop();
                                    } else {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                              content: Text(
                                                  "Failed to delete session from TMDB servers, try again later"),
                                              backgroundColor:
                                                  Colors.redAccent));
                                    }
                                  }
                                : null,
                            child: Text(
                              "Logout",
                              style: TextStyle(
                                  color: styleStore.textOnPrimaryColor),
                            ),
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                  styleStore.primaryColor),
                            ),
                          ),
                        ],
                      );
                    });
                  });
            },
            icon: Icon(Icons.logout),
            splashRadius: 20,
          ),
        ],
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
      body: Observer(builder: (context) {
        if (userStore.loading)
          return LinearProgressIndicator(
            valueColor: AlwaysStoppedAnimation(
              styleStore.primaryColor,
            ),
            backgroundColor: styleStore.backgroundColor,
          );
        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 60,
                width: double.infinity,
              ),
              if (userStore.user!.avatar != null &&
                  userStore.user!.avatar!.isNotEmpty)
                GestureDetector(
                  onTap: userStore.user!.avatarType == AvatarType.tmdb
                      ? () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => FullScreenImage(
                                  path:
                                      "https://image.tmdb.org/t/p/original/${userStore.user!.avatar}")));
                        }
                      : null,
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(360),
                        border: Border.all(
                            color: styleStore.primaryColor!, width: 4)),
                    child: CircleAvatar(
                      radius: 60,
                      backgroundColor: Colors.transparent,
                      backgroundImage: userStore.user!.avatarType ==
                              AvatarType.tmdb
                          ? CachedNetworkImageProvider(
                              "https://image.tmdb.org/t/p/h632/${userStore.user!.avatar}")
                          : Image.network(
                              "https://www.gravatar.com/avatar/${userStore.user!.avatar}",
                            ).image,
                    ),
                  ),
                ),
              if (userStore.user!.avatar == null ||
                  userStore.user!.avatar!.isEmpty)
                Container(
                  height: 128,
                  width: 128,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(360),
                      border: Border.all(
                          color: styleStore.primaryColor!, width: 4)),
                  child: Center(
                      child: Text(
                    userStore.user!.username[0].toUpperCase(),
                    style: GoogleFonts.getFont('Mitr',
                        color: styleStore.primaryColor,
                        fontSize: 48,
                        fontWeight: FontWeight.w400),
                  )),
                ),
              SizedBox(
                height: 16,
              ),
              Text(
                userStore.user!.username,
                style: GoogleFonts.getFont('Mitr',
                    color: styleStore.textColor,
                    fontSize: 24,
                    fontWeight: FontWeight.w400),
              )
            ],
          ),
        );
      }),
    );
  }
}
