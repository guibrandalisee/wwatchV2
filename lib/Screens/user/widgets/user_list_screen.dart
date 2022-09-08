import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:wwatch/Shared/Themes/app_colors.dart';
import 'package:wwatch/stores/settings_store.dart';
import 'package:wwatch/stores/style_store.dart';

class UserListScreen extends StatelessWidget {
  UserListScreen({Key? key, required this.children}) : super(key: key);
  final StyleStore styleStore = GetIt.I<StyleStore>();
  final SettingsStore settingsStore = GetIt.I<SettingsStore>();
  final List<Widget> children;
  @override
  Widget build(BuildContext context) {
    children.insertAll(0, [
      SizedBox(
        height: 80,
        width: double.infinity,
      ),
      Hero(
        tag: 'logoImage',
        child: Container(
          decoration: BoxDecoration(boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha(50),
              blurRadius: 32,
              spreadRadius: 0,
            )
          ]),
          height: 140,
          child: Image(
            image: ResizeImage(
                AssetImage(
                  'assets/images/WWatch2-png.png',
                ),
                height: 420,
                width: 420),
            filterQuality: FilterQuality.medium,
            color: settingsStore.brightness != CustomBrightness.amoled
                ? styleStore.textColor
                : styleStore.primaryColor,
          ),
        ),
      ),
      SizedBox(
        height: 65,
      ),
    ]);
    children.insert(
        children.length,
        SizedBox(
          height: 48,
        ));
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
        title: Hero(
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
      body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: children,
          )),
    );
  }
}
