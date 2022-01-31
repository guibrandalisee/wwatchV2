import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';

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
import 'package:wwatch/Shared/Themes/app_colors.dart';
import 'package:wwatch/stores/movie_store.dart';
import 'package:wwatch/stores/settings_store.dart';
import 'package:wwatch/stores/style_store.dart';

//TODO add TV shows seasons and episodes

class MovieScreen extends StatefulWidget {
  final int movieId;
  final int contentType;
  MovieScreen({
    Key? key,
    required this.movieId,
    required this.contentType,
  }) : super(key: key);

  @override
  State<MovieScreen> createState() => _MovieScreenState();
}

class _MovieScreenState extends State<MovieScreen> {
  @override
  void initState() {
    super.initState();
    movieStore.getSingleMovie(widget.movieId, widget.contentType);
    movieStore.getRecommendations(widget.movieId);
  }

  final MovieStore movieStore = MovieStore();

  final StyleStore styleStore = GetIt.I<StyleStore>();

  final SettingsStore settingsStore = GetIt.I<SettingsStore>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: const CustomSpeedDialMovieScreen(),
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
          else
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
                            title: 'Seasons',
                            value: movieStore.movie!.numberOfSeasons!,
                          ),
                        SizedBox(
                          width: 16,
                        ),
                        if (movieStore.movie!.numberOfEpisodes != null &&
                            movieStore.movie!.numberOfEpisodes! > 0)
                          SeasonEpisodeCount(
                            title: 'Episodes',
                            value: movieStore.movie!.numberOfEpisodes!,
                          ),
                      ],
                    ),
                  ),
                  if (movieStore.movie!.tagline != null &&
                      movieStore.movie!.tagline!.isNotEmpty)
                    TaglineWidget(
                      movie: movieStore.movie!,
                    ),
                  if (movieStore.movie!.images != null &&
                      movieStore.movie!.images!.length > 0)
                    PostersWidget(movie: movieStore.movie!),
                  if (movieStore.movie!.videos != null &&
                      movieStore.movie!.videos!.length > 0)
                    TrailersWidget(
                      movie: movieStore.movie!,
                    ),
                  if (movieStore.movie!.numberOfSeasons != null &&
                      movieStore.movie!.numberOfSeasons! > 0)
                    SeasonEpisodeWidget(
                      movieStore: movieStore,
                    ),
                  if (movieStore.recommendations.length > 0)
                    RecommendationsWidget(movieStore: movieStore),
                  MovieStatsWidget(
                    movie: movieStore.movie!,
                  ),
                  SizedBox(
                    height: 56,
                  )
                ],
              ),
            );
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
