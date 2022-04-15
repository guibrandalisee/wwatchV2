import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:wwatch/Screens/movie/widgets/credits_widget.dart';
import 'package:wwatch/Screens/person/person_screen.dart';
import 'package:wwatch/Shared/Themes/app_colors.dart';
import 'package:wwatch/Shared/models/cast_and_crew_model.dart';
import 'package:wwatch/stores/settings_store.dart';
import 'package:wwatch/stores/style_store.dart';

enum AllPersonType { cast, crew }

class AllPersonScreen extends StatelessWidget {
  AllPersonScreen({
    Key? key,
    required this.credits,
    required this.prefs,
    required this.type,
  }) : super(key: key);
  final Credits credits;
  final SharedPreferences prefs;

  final AllPersonType type;
  final ScrollController _controller =
      ScrollController(initialScrollOffset: 320);
  @override
  Widget build(BuildContext context) {
    final SettingsStore settingsStore = GetIt.I<SettingsStore>();
    final StyleStore styleStore = GetIt.I<StyleStore>();

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
      ),
      body: ListView.builder(
          controller: _controller,
          physics: BouncingScrollPhysics(),
          itemCount: type == AllPersonType.cast
              ? credits.cast!.length + 1
              : credits.crew!.length + 1,
          itemBuilder: (context, index) {
            if (index == 0)
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    height: 80,
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
                        color:
                            settingsStore.brightness != CustomBrightness.amoled
                                ? styleStore.textColor
                                : styleStore.primaryColor,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 160,
                  ),
                ],
              );
            return Container(
              margin: const EdgeInsets.only(bottom: 16),
              child: CastWidget(
                cast: type == AllPersonType.cast
                    ? credits.cast![index - 1]
                    : null,
                crew: type == AllPersonType.crew
                    ? credits.crew![index - 1]
                    : null,
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => PersonScreen(
                          prefs: prefs,
                          id: type == AllPersonType.cast
                              ? credits.cast![index - 1].id
                              : credits.crew![index - 1].id)));
                },
              ),
            );
          }),
    );
  }
}
