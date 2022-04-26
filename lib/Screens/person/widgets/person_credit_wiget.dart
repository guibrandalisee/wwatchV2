import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:wwatch/Screens/movie/movie_screen.dart';
import 'package:wwatch/Shared/Themes/app_colors.dart';
import 'package:wwatch/Shared/models/cast_and_crew_model.dart';
import 'package:wwatch/stores/settings_store.dart';
import 'package:wwatch/stores/style_store.dart';

class PersonCreditWidget extends StatelessWidget {
  PersonCreditWidget({
    Key? key,
    required this.person,
    required this.prefs,
  }) : super(key: key);
  final Person person;
  final StyleStore styleStore = GetIt.I<StyleStore>();
  final SettingsStore settingsStore = GetIt.I<SettingsStore>();
  final SharedPreferences prefs;
  bool scrollInProgress = false;
  ScrollController scrollController = ScrollController();
  ScrollController scrollController2 = ScrollController();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 32,
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 16),
          width: double.infinity,
          child: Text(
            AppLocalizations.of(context)!.knowFor,
            style: GoogleFonts.getFont('Mitr',
                color: styleStore.textColor,
                fontSize: 18,
                fontWeight: FontWeight.w400),
          ),
        ),
        if (person.personMovieCreditCast != null &&
            person.personMovieCreditCast!.length > 0)
          SizedBox(
            height: 32,
          ),
        if (person.personMovieCreditCast != null &&
            person.personMovieCreditCast!.length > 0)
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (person.personMovieCreditCast!.length > 1)
                IconButton(
                    splashRadius: 16,
                    onPressed: () async {
                      if (!scrollInProgress) {
                        scrollInProgress = true;
                        await scrollController.animateTo(
                            scrollController.offset -
                                MediaQuery.of(context).size.width -
                                32,
                            duration: Duration(milliseconds: 100),
                            curve: Curves.ease);
                        scrollInProgress = false;
                      }
                    },
                    icon: Icon(
                      Icons.chevron_left_rounded,
                      color: styleStore.textColor,
                      size: 22,
                    )),
              const SizedBox(
                width: 8,
              ),
              Text(
                AppLocalizations.of(context)!.appearInMovies,
                style: GoogleFonts.getFont('Mitr',
                    color: styleStore.textColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w400),
              ),
              const SizedBox(
                width: 8,
              ),
              if (person.personMovieCreditCast!.length > 1)
                IconButton(
                    splashRadius: 16,
                    onPressed: () async {
                      if (!scrollInProgress) {
                        scrollInProgress = true;
                        await scrollController.animateTo(
                            scrollController.offset +
                                MediaQuery.of(context).size.width -
                                32,
                            duration: Duration(milliseconds: 100),
                            curve: Curves.ease);
                        scrollInProgress = false;
                      }
                    },
                    icon: Icon(
                      Icons.chevron_right_rounded,
                      color: styleStore.textColor,
                      size: 22,
                    )),
            ],
          ),
        if (person.personMovieCreditCast != null &&
            person.personMovieCreditCast!.length > 0)
          SizedBox(
            height: 16,
          ),
        Container(
          width: MediaQuery.of(context).size.width,
          height: 280,
          child: ListView.builder(
              controller: scrollController,
              physics: BouncingScrollPhysics(),
              itemCount: person.personMovieCreditCast!.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: ((context, index) {
                return MovieWidget(
                  prefs: prefs,
                  tvShow: false,
                  index: index,
                  person: person,
                );
              })),
        ),
        if (person.personTVCreditCast != null &&
            person.personTVCreditCast!.length > 0)
          SizedBox(
            height: 32,
          ),
        if (person.personTVCreditCast != null &&
            person.personTVCreditCast!.length > 0)
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (person.personMovieCreditCast!.length > 1)
                IconButton(
                    splashRadius: 16,
                    onPressed: () async {
                      if (!scrollInProgress) {
                        scrollInProgress = true;
                        await scrollController2.animateTo(
                            scrollController2.offset -
                                MediaQuery.of(context).size.width -
                                32,
                            duration: Duration(milliseconds: 100),
                            curve: Curves.ease);
                        scrollInProgress = false;
                      }
                    },
                    icon: Icon(
                      Icons.chevron_left_rounded,
                      color: styleStore.textColor,
                      size: 22,
                    )),
              const SizedBox(
                width: 8,
              ),
              Text(
                AppLocalizations.of(context)!.appearInTvShows,
                style: GoogleFonts.getFont('Mitr',
                    color: styleStore.textColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w400),
              ),
              const SizedBox(
                width: 8,
              ),
              if (person.personMovieCreditCast!.length > 1)
                IconButton(
                    splashRadius: 16,
                    onPressed: () async {
                      if (!scrollInProgress) {
                        scrollInProgress = true;
                        await scrollController2.animateTo(
                            scrollController2.offset +
                                MediaQuery.of(context).size.width -
                                32,
                            duration: Duration(milliseconds: 100),
                            curve: Curves.ease);
                        scrollInProgress = false;
                      }
                    },
                    icon: Icon(
                      Icons.chevron_right_rounded,
                      color: styleStore.textColor,
                      size: 22,
                    )),
            ],
          ),
        if (person.personTVCreditCast != null &&
            person.personTVCreditCast!.length > 0)
          SizedBox(
            height: 16,
          ),
        if (person.personTVCreditCast != null &&
            person.personTVCreditCast!.length > 0)
          Container(
            width: MediaQuery.of(context).size.width,
            height: 280,
            child: ListView.builder(
                controller: scrollController2,
                physics: BouncingScrollPhysics(),
                itemCount: person.personTVCreditCast!.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: ((context, index) {
                  return MovieWidget(
                    prefs: prefs,
                    tvShow: true,
                    index: index,
                    person: person,
                  );
                })),
          ),
        SizedBox(
          height: 32,
        ),
      ],
    );
  }
}

class MovieWidget extends StatelessWidget {
  MovieWidget(
      {Key? key,
      required this.person,
      required this.index,
      required this.tvShow,
      required this.prefs})
      : super(key: key);
  final Person person;
  final StyleStore styleStore = GetIt.I<StyleStore>();
  final SettingsStore settingsStore = GetIt.I<SettingsStore>();
  final int index;
  final bool tvShow;
  final SharedPreferences prefs;

  String formatDate(String date) {
    switch (settingsStore.dateFormat) {
      case 'dd/mm/yyyy':
        return '${date.substring(8, 10)}/${date.substring(5, 7)}/${date.substring(0, 4)}';

      case 'mm/dd/yyyy':
        return '${date.substring(5, 7)}/${date.substring(8, 10)}/${date.substring(0, 4)}';

      case 'yyyy/mm/dd':
        return date.replaceAll('-', '/');
    }
    return '';
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: Feedback.wrapForTap(() {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => MovieScreen(
                prefs: prefs,
                movieId: !tvShow
                    ? person.personMovieCreditCast![index].id
                    : person.personTVCreditCast![index].id,
                contentType: !tvShow ? 0 : 1)));
      }, context),
      child: Container(
        height: 280,
        width: MediaQuery.of(context).size.width - 48,
        decoration: BoxDecoration(
          color: styleStore.shapeColor,
          borderRadius: BorderRadius.circular(8),
        ),
        padding: EdgeInsets.all(16),
        margin: EdgeInsets.only(left: index == 0 ? 16 : 8, right: 8),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              width: 120,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  (!tvShow &&
                              person.personMovieCreditCast![index].posterPath !=
                                  null) ||
                          (tvShow &&
                              person.personTVCreditCast![index].posterPath !=
                                  null)
                      ? Container(
                          height: 180,
                          width: 120,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.network(
                              'https://image.tmdb.org/t/p/w342${!tvShow ? person.personMovieCreditCast![index].posterPath : person.personTVCreditCast![index].posterPath}',
                              filterQuality: FilterQuality.medium,
                              fit: BoxFit.cover,
                            ),
                          ),
                        )
                      : Container(
                          width: 165,
                          height: 180,
                          alignment: Alignment.center,
                          child: Text(
                            'No Image :(',
                            style: GoogleFonts.getFont('Mitr',
                                color: styleStore.textColor,
                                fontSize: 18,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                  SizedBox(
                    height: 16,
                  ),
                  Container(
                      margin: EdgeInsets.symmetric(horizontal: 8),
                      alignment: Alignment.center,
                      height: 24,
                      width: 56,
                      decoration: BoxDecoration(
                        color: AppColors.shape,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                            color: styleStore.primaryColor!, width: 2),
                      ),
                      child: RichText(
                        text: TextSpan(
                          text:
                              '${(!tvShow ? person.personMovieCreditCast![index].voteAverage : person.personTVCreditCast![index].voteAverage)}',
                          style: GoogleFonts.getFont('Kodchasan',
                              color: AppColors.text,
                              fontSize: 12,
                              fontWeight: FontWeight.w800),
                          children: <TextSpan>[
                            TextSpan(
                              text: '/10',
                              style: GoogleFonts.getFont(
                                'Kodchasan',
                                color: AppColors.text,
                                fontSize: 8,
                                fontWeight: FontWeight.w300,
                                decoration: TextDecoration.overline,
                              ),
                            )
                          ],
                        ),
                      )),
                  SizedBox(
                    height: 8,
                  ),
                  if ((!tvShow &&
                          person.personMovieCreditCast![index].releaseDate !=
                              null &&
                          person.personMovieCreditCast![index].releaseDate !=
                              '') ||
                      (tvShow &&
                          person.personTVCreditCast![index].firstAirDate !=
                              null &&
                          person.personTVCreditCast![index].firstAirDate != ''))
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 8),
                      width: 165,
                      child: Text(
                        formatDate(!tvShow
                            ? person.personMovieCreditCast![index].releaseDate!
                            : person.personTVCreditCast![index].firstAirDate!),
                        style: GoogleFonts.getFont(
                          'Mitr',
                          color: styleStore.textColor,
                          fontSize: 12,
                          fontWeight: FontWeight.w200,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                ],
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.only(left: 16, right: 8, top: 8),
                  width: MediaQuery.of(context).size.width - 200,
                  child: Wrap(
                    children: [
                      Text(
                        !tvShow
                            ? person.personMovieCreditCast![index].title
                            : person.personTVCreditCast![index].name,
                        style: GoogleFonts.getFont('Mitr',
                            color: styleStore.textColor,
                            fontSize: 14,
                            fontWeight: FontWeight.w300),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                if ((!tvShow &&
                        person.personMovieCreditCast![index].character != '') ||
                    (tvShow &&
                        person.personTVCreditCast![index].character != ''))
                  Container(
                    padding: EdgeInsets.only(left: 16, right: 8, top: 8),
                    width: MediaQuery.of(context).size.width - 200,
                    child: Wrap(
                      children: [
                        Text(
                          '${AppLocalizations.of(context)!.appearedAs} ${!tvShow ? person.personMovieCreditCast![index].character : person.personTVCreditCast![index].character}',
                          style: GoogleFonts.getFont('Kodchasan',
                              color: styleStore.textColor,
                              fontSize: 10,
                              fontWeight: FontWeight.w700),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                SizedBox(
                  height: 8,
                ),
                Container(
                  padding: EdgeInsets.only(left: 16, right: 8),
                  width: MediaQuery.of(context).size.width - 200,
                  child: Wrap(
                    children: [
                      Text(
                        !tvShow
                            ? person.personMovieCreditCast![index].overview
                            : person.personTVCreditCast![index].overview,
                        style: GoogleFonts.getFont('Mitr',
                            color: styleStore.textColor,
                            fontSize: 13,
                            fontWeight: FontWeight.w200),
                        maxLines: 7,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
