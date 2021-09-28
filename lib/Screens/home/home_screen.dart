import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:line_icons/line_icons.dart';
import 'package:wwatch/Screens/home/components/page_selection.dart';
import 'package:wwatch/Screens/login/login_screen.dart';
import 'package:wwatch/Screens/settings/settings_screen.dart';
import 'package:wwatch/Screens/welcome/welcome_screen.dart';
import 'package:wwatch/Shared/Themes/app_colors.dart';
import 'package:wwatch/Shared/Widgets/custom_fab.dart';
import 'package:wwatch/stores/style_store.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  StyleStore styleStore = GetIt.I<StyleStore>();
  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) {
        return Scaffold(
          floatingActionButtonLocation: styleStore.fabPosition == 0
              ? FloatingActionButtonLocation.startFloat
              : FloatingActionButtonLocation.endFloat,
          floatingActionButton: CustomFAB(
            search: true,
            popular: true,
            genres: true,
            upcoming: true,
            tvshows: true,
            movies: true,
            people: true,
          ),
          backgroundColor: AppColors.background,
          appBar: AppBar(
            backgroundColor: styleStore.primaryColor,
            leading: InkWell(
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => WelcomeScreen(),
                  ),
                );
              },
              child: Ink(
                child: Hero(
                  tag: "logo",
                  child: Image.asset(
                    "assets/images/WWatch2-png.png",
                    filterQuality: FilterQuality.medium,
                  ),
                ),
              ),
            ),
            actions: [
              IconButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => SettingsScreen()));
                },
                icon: Icon(
                  LineIcons.cog,
                  color: AppColors.logo,
                  size: 28,
                ),
              ),
              IconButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => LoginScreen()));
                },
                icon: Icon(
                  LineIcons.user,
                  color: AppColors.logo,
                  size: 28,
                ),
              ),
            ],
          ),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                PageSelection(),
              ],
            ),
          ),
        );
      },
    );
  }
}
