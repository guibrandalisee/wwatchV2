import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_icons/line_icons.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:wwatch/Screens/all_person/all_person_screen.dart';
import 'package:wwatch/Screens/person/person_screen.dart';
import 'package:wwatch/Shared/Themes/app_colors.dart';
import 'package:wwatch/Shared/models/cast_and_crew_model.dart';
import 'package:wwatch/stores/style_store.dart';

class CreditsWidget extends StatelessWidget {
  const CreditsWidget({
    Key? key,
    required this.credits,
    required this.prefs,
  }) : super(key: key);
  final Credits credits;
  final SharedPreferences prefs;

  @override
  Widget build(BuildContext context) {
    final StyleStore styleStore = GetIt.I<StyleStore>();
    if (credits.cast != null) credits.cast!.sort((a, b) => a.order - b.order);

    return Container(
      width: double.infinity,
      child: Column(
        children: [
          const SizedBox(
            height: 16,
          ),
          Divider(
            color: AppColors.divider,
            thickness: 1,
            endIndent: 24,
            indent: 24,
          ),
          const SizedBox(
            height: 32,
          ),
          Text(
            AppLocalizations.of(context)!.credits,
            style: GoogleFonts.getFont('Mitr',
                color: styleStore.textColor,
                fontSize: 22,
                fontWeight: FontWeight.w500),
            textAlign: TextAlign.center,
          ),
          if (credits.cast!.isNotEmpty)
            const SizedBox(
              height: 32,
            ),
          if (credits.cast!.isNotEmpty)
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    AppLocalizations.of(context)!.cast,
                    style: GoogleFonts.getFont('Mitr',
                        color: styleStore.textColor,
                        fontSize: 20,
                        fontWeight: FontWeight.w300),
                    textAlign: TextAlign.center,
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => AllPersonScreen(
                                prefs: prefs,
                                type: AllPersonType.cast,
                                credits: credits,
                              )));
                    },
                    child: Text(
                      AppLocalizations.of(context)!.viewMore,
                      style: GoogleFonts.getFont('Mitr',
                          color: styleStore.primaryColor,
                          fontSize: 16,
                          fontWeight: FontWeight.w100),
                      textAlign: TextAlign.center,
                    ),
                  )
                ],
              ),
            ),
          if (credits.cast!.isNotEmpty)
            SizedBox(
              height: 16,
            ),
          if (credits.cast != null &&
              credits.cast!.isNotEmpty &&
              credits.cast!.length > 0)
            CastWidget(
                cast: credits.cast![0],
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => PersonScreen(
                            id: credits.cast![0].id,
                            prefs: prefs,
                          )));
                }),
          const SizedBox(
            height: 8,
          ),
          if (credits.cast != null &&
              credits.cast!.isNotEmpty &&
              credits.cast!.length > 1)
            CastWidget(
                cast: credits.cast![1],
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) =>
                          PersonScreen(id: credits.cast![1].id, prefs: prefs)));
                }),
          const SizedBox(
            height: 8,
          ),
          if (credits.cast != null &&
              credits.cast!.isNotEmpty &&
              credits.cast!.length > 2)
            CastWidget(
                cast: credits.cast![2],
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) =>
                          PersonScreen(id: credits.cast![2].id, prefs: prefs)));
                }),
          if (credits.crew!.isNotEmpty)
            const SizedBox(
              height: 16,
            ),
          if (credits.cast!.isNotEmpty && credits.crew!.isNotEmpty)
            Divider(
              color: AppColors.divider,
              thickness: 1,
              endIndent: 24,
              indent: 24,
            ),
          if (credits.crew!.isNotEmpty)
            const SizedBox(
              height: 16,
            ),
          if (credits.crew!.isNotEmpty)
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    AppLocalizations.of(context)!.crew,
                    style: GoogleFonts.getFont('Mitr',
                        color: styleStore.textColor,
                        fontSize: 20,
                        fontWeight: FontWeight.w300),
                    textAlign: TextAlign.center,
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => AllPersonScreen(
                                prefs: prefs,
                                type: AllPersonType.crew,
                                credits: credits,
                              )));
                    },
                    child: Text(
                      AppLocalizations.of(context)!.viewMore,
                      style: GoogleFonts.getFont('Mitr',
                          color: styleStore.primaryColor,
                          fontSize: 16,
                          fontWeight: FontWeight.w100),
                      textAlign: TextAlign.center,
                    ),
                  )
                ],
              ),
            ),
          if (credits.crew!.isNotEmpty)
            SizedBox(
              height: 16,
            ),
          if (credits.crew != null &&
              credits.crew!.isNotEmpty &&
              credits.crew!.length > 0)
            CastWidget(
              crew: credits.crew![0],
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => PersonScreen(
                      id: credits.crew![0].id,
                      prefs: prefs,
                    ),
                  ),
                );
              },
            ),
          const SizedBox(
            height: 8,
          ),
          if (credits.crew != null &&
              credits.crew!.isNotEmpty &&
              credits.crew!.length > 1)
            CastWidget(
                crew: credits.crew![1],
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) =>
                          PersonScreen(id: credits.crew![1].id, prefs: prefs),
                    ),
                  );
                }),
          const SizedBox(
            height: 8,
          ),
          if (credits.crew != null &&
              credits.crew!.isNotEmpty &&
              credits.crew!.length > 2)
            CastWidget(
                crew: credits.crew![2],
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) =>
                          PersonScreen(id: credits.crew![2].id, prefs: prefs),
                    ),
                  );
                }),
        ],
      ),
    );
  }
}

class CastWidget extends StatelessWidget {
  const CastWidget({Key? key, this.cast, this.crew, required this.onTap})
      : super(key: key);
  final Cast? cast;
  final Crew? crew;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    bool isCast = cast != null;
    bool isCrew = crew != null;
    final StyleStore styleStore = GetIt.I<StyleStore>();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
              color: styleStore.shapeColor,
              borderRadius: BorderRadius.circular(8)),
          width: double.infinity,
          height: 128,
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                child: (isCast && cast!.profilePath != null) ||
                        (isCrew && crew!.profilePath != null)
                    ? Container(
                        width: 86,
                        child: ClipRRect(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(8),
                                bottomLeft: Radius.circular(8)),
                            child: CachedNetworkImage(
                              imageUrl:
                                  'https://image.tmdb.org/t/p/w185${isCast ? cast!.profilePath : crew!.profilePath}',
                              filterQuality: FilterQuality.medium,
                              fit: BoxFit.cover,
                            )),
                      )
                    : Center(
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(8),
                                  bottomLeft: Radius.circular(8)),
                              color: styleStore.shapeColor!
                                  .withBlue(styleStore.shapeColor!.blue + 5)
                                  .withGreen(styleStore.shapeColor!.green + 5)
                                  .withRed(styleStore.shapeColor!.red + 5)),
                          width: 86,
                          child: Center(
                            child: Icon(
                              LineIcons.user,
                              color: styleStore.textColor,
                              size: 36,
                            ),
                          ),
                        ),
                      ),
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(12),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width - 56,
                        child: Wrap(
                          children: [
                            Text(
                              isCast ? cast!.name : crew!.name,
                              style: GoogleFonts.getFont('Mitr',
                                  color: styleStore.textColor,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w300),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                      if ((isCast && cast!.character.isNotEmpty) ||
                          (!isCast && crew!.knownForFepartment.isNotEmpty))
                        Container(
                          width: MediaQuery.of(context).size.width - 56,
                          child: Wrap(
                            children: [
                              Text(
                                isCast
                                    ? '${AppLocalizations.of(context)!.as} ${cast!.character}'
                                    : crew!.knownForFepartment,
                                style: GoogleFonts.getFont('Mitr',
                                    color: styleStore.textColor,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w200),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
