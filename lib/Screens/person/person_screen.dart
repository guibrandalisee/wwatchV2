import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:wwatch/Screens/person/widgets/person_biography_widget.dart';
import 'package:wwatch/Screens/person/widgets/person_credit_wiget.dart';
import 'package:wwatch/Screens/person/widgets/person_header_widget.dart';
import 'package:wwatch/Screens/person/widgets/person_photos_widget.dart';
import 'package:wwatch/Screens/person/widgets/person_social_media_widget.dart';
import 'package:wwatch/Shared/Themes/app_colors.dart';
import 'package:wwatch/stores/movie_store.dart';
import 'package:wwatch/stores/settings_store.dart';
import 'package:wwatch/stores/style_store.dart';

class PersonScreen extends StatefulWidget {
  PersonScreen({Key? key, required this.prefs, required this.id})
      : super(key: key);
  final id;
  @override
  State<PersonScreen> createState() => _PersonScreenState();
  final SharedPreferences prefs;
}

class _PersonScreenState extends State<PersonScreen> {
  @override
  void initState() {
    if (!widget.prefs.containsKey('language') ||
        !widget.prefs.containsKey('languageISO') &&
            (WidgetsBinding.instance != null)) {
      movieStore.language = AppLocalizations.delegate
              .isSupported(WidgetsBinding.instance!.window.locale)
          ? '${WidgetsBinding.instance!.window.locale.languageCode}-${WidgetsBinding.instance!.window.locale.countryCode}'
          : 'en-US';
    }
    movieStore.getPerson(widget.id);
    super.initState();
  }

  final MovieStore movieStore = MovieStore();

  final StyleStore styleStore = GetIt.I<StyleStore>();
  final SettingsStore settingsStore = GetIt.I<SettingsStore>();

  @override
  Widget build(BuildContext context) {
    print(movieStore.person);

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
      body: Observer(
        builder: (context) {
          if (movieStore.person == null)
            return LinearProgressIndicator(
              valueColor: AlwaysStoppedAnimation(styleStore.primaryColor),
              backgroundColor: styleStore.backgroundColor,
            );
          if (movieStore.error)
            //TODO make error screen
            return Container(
              child: Text(
                'Error',
                style: TextStyle(color: styleStore.textColor),
              ),
            );

          return SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Container(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: double.infinity,
                    height: 120,
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                          styleStore.shapeColor!.withOpacity(0.8),
                          Colors.transparent
                        ])),
                  ),
                  PersonHeaderWidget(movieStore: movieStore),
                  if (movieStore.person!.externalIds != null &&
                      ((movieStore.person!.externalIds!.facebookId != null &&
                              movieStore.person!.externalIds!.facebookId !=
                                  '') ||
                          (movieStore.person!.externalIds!.instagramId !=
                                  null &&
                              movieStore.person!.externalIds!.instagramId !=
                                  '') ||
                          (movieStore.person!.externalIds!.twitterId != null &&
                              movieStore.person!.externalIds!.twitterId != '')))
                    PersonSocialMediaWidget(
                        externalIds: movieStore.person!.externalIds!),
                  if (movieStore.person!.images != null &&
                      movieStore.person!.images!.length > 1)
                    PersonPhotosWidget(movieStore: movieStore),
                  if (movieStore.person!.biography != null &&
                      movieStore.person!.biography!.isNotEmpty)
                    PersonBiographyWidget(movieStore: movieStore),
                  if ((movieStore.person!.personMovieCreditCast != null &&
                          movieStore.person!.personMovieCreditCast!.length >
                              0) ||
                      (movieStore.person!.personTVCreditCast != null &&
                          movieStore.person!.personTVCreditCast!.length > 0))
                    PersonCreditWidget(
                      prefs: widget.prefs,
                      person: movieStore.person!,
                    ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
