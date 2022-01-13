import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';

import 'package:wwatch/Screens/movie/widgets/description_widget.dart';
import 'package:wwatch/Screens/movie/widgets/error_movie_screen.dart';
import 'package:wwatch/Screens/movie/widgets/header_widget.dart';
import 'package:wwatch/Screens/movie/widgets/loading_screen.dart';
import 'package:wwatch/Screens/movie/widgets/movie_stats_widget.dart';
import 'package:wwatch/Screens/movie/widgets/posters_widget.dart';
import 'package:wwatch/Screens/movie/widgets/similar_movies_widget.dart';
import 'package:wwatch/Screens/movie/widgets/speed_dial_movie_screen.dart';
import 'package:wwatch/Screens/movie/widgets/tagline_widget.dart';
import 'package:wwatch/Screens/movie/widgets/trailers_widget.dart';
import 'package:wwatch/Shared/Themes/app_colors.dart';
import 'package:wwatch/stores/movie_store.dart';
import 'package:wwatch/stores/settings_store.dart';
import 'package:wwatch/stores/style_store.dart';

class MovieScreen extends StatelessWidget {
  final int movieId;
  MovieScreen({
    Key? key,
    required this.movieId,
  }) : super(key: key);
  final MovieStore movieStore = MovieStore();
  final StyleStore styleStore = GetIt.I<StyleStore>();
  final SettingsStore settingsStore = GetIt.I<SettingsStore>();
  @override
  Widget build(BuildContext context) {
    movieStore.getSingleMovie(movieId);
    movieStore.getSimilarMovies(movieId);
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
              movieId: movieId,
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
                  if (movieStore.similarMovies.length > 0)
                    SimilarMoviesWidget(movieStore: movieStore),
                  MovieStatsWidget(
                    movie: movieStore.movie!,
                  ),
                  SizedBox(
                    height: 256,
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
