import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wwatch/Screens/all_watch_providers/all_watch_providers_screen.dart';
import 'package:wwatch/Screens/movie/widgets/account_states_widget.dart';

import 'package:wwatch/Screens/movie/widgets/credits_widget.dart';
import 'package:wwatch/Screens/movie/widgets/description_widget.dart';
import 'package:wwatch/Screens/movie/widgets/error_movie_screen.dart';
import 'package:wwatch/Screens/movie/widgets/header_widget.dart';
import 'package:wwatch/Screens/movie/widgets/loading_screen.dart';
import 'package:wwatch/Screens/movie/widgets/movie_stats_widget.dart';
import 'package:wwatch/Screens/movie/widgets/posters_widget.dart';
import 'package:wwatch/Screens/movie/widgets/recommendations_widget.dart';
import 'package:wwatch/Screens/movie/widgets/season_and_episode_count_widget.dart';
import 'package:wwatch/Screens/movie/widgets/season_and_episode_widget.dart';
import 'package:wwatch/Screens/movie/widgets/speed_dial_movie_screen.dart';
import 'package:wwatch/Screens/movie/widgets/tagline_widget.dart';
import 'package:wwatch/Screens/movie/widgets/trailers_widget.dart';
import 'package:wwatch/Screens/movie/widgets/watch_providers_widget.dart';
import 'package:wwatch/Shared/Themes/app_colors.dart';
import 'package:wwatch/stores/movie_store.dart';
import 'package:wwatch/stores/settings_store.dart';
import 'package:wwatch/stores/style_store.dart';

class MovieScreen extends StatefulWidget {
  final int movieId;
  final int contentType;
  final SharedPreferences prefs;
  MovieScreen({
    Key? key,
    required this.movieId,
    required this.contentType,
    required this.prefs,
  }) : super(key: key);

  @override
  State<MovieScreen> createState() => _MovieScreenState();
}

class _MovieScreenState extends State<MovieScreen> {
  @override
  void initState() {
    super.initState();
    // if (!widget.prefs.containsKey('language') ||
    //     !widget.prefs.containsKey('languageISO')) {
    //   movieStore.language = AppLocalizations.delegate
    //           .isSupported(WidgetsBinding.instance.window.locale)
    //       ? '${WidgetsBinding.instance.window.locale.languageCode}-${WidgetsBinding.instance.window.locale.countryCode}'
    //       : 'en-US';
    // }
    movieStore.getSingleMovie(widget.movieId, widget.contentType);
    movieStore.getRecommendations(widget.movieId);
  }

  final MovieStore movieStore = MovieStore();

  final StyleStore styleStore = GetIt.I<StyleStore>();

  final SettingsStore settingsStore = GetIt.I<SettingsStore>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: styleStore.fabPosition == 0
          ? FloatingActionButtonLocation.startFloat
          : FloatingActionButtonLocation.endFloat,
      floatingActionButton: userStore.sessionId != null
          ? Observer(builder: (context) {
              if (movieStore.movie != null)
                return CustomSpeedDialMovieScreen(
                  mediaId: movieStore.movie!.id,
                  movieStore: movieStore,
                  customSetState: () {
                    setState(() {});
                  },
                );

              return Container();
            })
          : null,
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
        actions: [],
      ),
      body: Observer(
        builder: (_) {
          if (movieStore.error)
            return CustomErrorMovieScreen(
              movieId: widget.movieId,
              movieStore: movieStore,
            );
          if (movieStore.movie == null)
            return const CustomLoadingMovieScreen();
          else {
            return SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: HeaderWidget(movie: movieStore.movie!),
                  ),
                  DescriptionWidget(movie: movieStore.movie!),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      children: [
                        if (movieStore.movie!.numberOfSeasons != null &&
                            movieStore.movie!.numberOfSeasons! > 0)
                          SeasonEpisodeCount(
                            title: AppLocalizations.of(context)!.seasons,
                            value: movieStore.movie!.numberOfSeasons!,
                          ),
                        SizedBox(
                          width: 16,
                        ),
                        if (movieStore.movie!.numberOfEpisodes != null &&
                            movieStore.movie!.numberOfEpisodes! > 0)
                          SeasonEpisodeCount(
                            title: AppLocalizations.of(context)!.episodes,
                            value: movieStore.movie!.numberOfEpisodes!,
                          ),
                      ],
                    ),
                  ),
                  if ((movieStore.movie!.tagline != null &&
                          movieStore.movie!.tagline!.isNotEmpty) ||
                      movieStore.movie!.secondaryLanguageContent != null &&
                          movieStore.movie!.secondaryLanguageContent!.tagline !=
                              null &&
                          movieStore.movie!.secondaryLanguageContent!.tagline!
                              .isNotEmpty)
                    TaglineWidget(
                      movie: movieStore.movie!,
                    ),
                  if (movieStore.movie!.favorite != null &&
                      movieStore.movie!.watchlist != null &&
                      (movieStore.movie!.favorite! ||
                          movieStore.movie!.watchlist! ||
                          movieStore.movie!.rate != null))
                    AccountStatesWidget(
                      contentType: widget.contentType == 0
                          ? CustomContentType.MOVIE
                          : CustomContentType.TVSHOW,
                      favorite: movieStore.movie!.favorite!,
                      watchlist: movieStore.movie!.watchlist!,
                      rate: movieStore.movie!.rate,
                    ),
                  if (movieStore.movie!.images != null &&
                      movieStore.movie!.images!.length > 0)
                    PostersWidget(movie: movieStore.movie!),
                  if (!(movieStore.movie!.videos != null &&
                      movieStore.movie!.videos!.length > 0))
                    SizedBox(
                      height: 16,
                    ),
                  if (movieStore.movie!.videos != null &&
                      movieStore.movie!.videos!.length > 0)
                    TrailersWidget(
                      movie: movieStore.movie!,
                    ),
                  if (movieStore.movie!.numberOfSeasons != null &&
                      movieStore.movie!.numberOfSeasons! > 0)
                    SeasonEpisodeWidget(
                      prefs: widget.prefs,
                      movieStore: movieStore,
                    ),
                  if (movieStore.recommendations.length > 0)
                    RecommendationsWidget(
                      movieStore: movieStore,
                      prefs: widget.prefs,
                    ),
                  if (movieStore.movie!.movieAvaliableWatchProviders != null)
                    WatchProvidersWidgetMovieScreen(
                      movieStore: movieStore,
                    ),
                  if (movieStore.movie!.movieAvaliableWatchProviders == null)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Divider(
                          color: AppColors.divider,
                          thickness: 1,
                          endIndent: 24,
                          indent: 24,
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        Text(
                          AppLocalizations.of(context)!.whereToWatch,
                          style: GoogleFonts.getFont('Mitr',
                              color: styleStore.textColor,
                              fontSize: 22,
                              fontWeight: FontWeight.w400),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        Text(
                          AppLocalizations.of(context)!.noWPFound,
                          style: GoogleFonts.getFont('Mitr',
                              color: styleStore.textColor,
                              fontSize: 16,
                              fontWeight: FontWeight.w300),
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                          maxLines: 2,
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => AllWatchProvidersScreen(
                                      watchProvidersData:
                                          movieStore.movie!.allWatchProviders!,
                                    )));
                          },
                          child: Text(
                            AppLocalizations.of(context)!.wpAllCountries,
                            style: GoogleFonts.getFont('Mitr',
                                color: styleStore.primaryColor,
                                fontSize: 16,
                                fontWeight: FontWeight.w200),
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.center,
                            maxLines: 2,
                          ),
                        ),
                        SizedBox(
                          height: 16,
                        ),
                      ],
                    ),
                  if ((movieStore.movie!.credits.cast != null &&
                          movieStore.movie!.credits.cast!.isNotEmpty) ||
                      (movieStore.movie!.credits.crew != null &&
                          movieStore.movie!.credits.crew!.isNotEmpty))
                    CreditsWidget(
                      prefs: widget.prefs,
                      credits: movieStore.movie!.credits,
                    ),
                  MovieStatsWidget(
                    movie: movieStore.movie!,
                  ),
                  SizedBox(
                    height: 56,
                  )
                ],
              ),
            );
          }
          // return ListView.builder(
          //     physics: const BouncingScrollPhysics(),
          //     key: UniqueKey(),
          //     itemCount: 5,
          //     itemBuilder: (context, index) {
          //       switch (index) {
          //         case 0:
          //           return Padding(
          //             padding: const EdgeInsets.only(bottom: 16),
          //             child: HeaderWidget(movie: movieStore.movie!),
          //           );
          //         case 1:
          //           return DescriptionWidget(movie: movieStore.movie!);
          //         case 2:
          //           return movieStore.movie!.images != null &&
          //                   movieStore.movie!.images!.length > 0
          //               ? PostersWidget(movie: movieStore.movie!)
          //               : Container();

          //         case 3:
          //           return movieStore.movie!.videos != null &&
          //                   movieStore.movie!.videos!.length > 0
          //               ? TrailersWidget(
          //                   movie: movieStore.movie!,
          //                 )
          //               : Container();
          //         case 4:
          //           return const SizedBox(
          //             height: 64,
          //           );
          //         default:
          //           return Container();
          //       }
          //     },);
        },
      ),
    );
  }
}
