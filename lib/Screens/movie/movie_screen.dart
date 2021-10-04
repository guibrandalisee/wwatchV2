import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_icons/line_icons.dart';

import 'package:wwatch/Screens/movie/widgets/description_widget.dart';
import 'package:wwatch/Screens/movie/widgets/header_widget.dart';
import 'package:wwatch/Screens/movie/widgets/posters_widget.dart';
import 'package:wwatch/Screens/welcome/welcome_screen.dart';
import 'package:wwatch/Shared/Themes/app_colors.dart';
import 'package:wwatch/stores/movie_store.dart';
import 'package:wwatch/stores/style_store.dart';

class MovieScreen extends StatelessWidget {
  final int movieId;
  MovieScreen({
    Key? key,
    required this.movieId,
  }) : super(key: key);
  final MovieStore movieStore = MovieStore();
  final StyleStore styleStore = GetIt.I<StyleStore>();
  @override
  Widget build(BuildContext context) {
    movieStore.getSingleMovie(movieId);
    return Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
        floatingActionButton: SpeedDial(
          child: Icon(LineIcons.plus),
          elevation: 8,
          direction: SpeedDialDirection.down,
          overlayColor: Colors.black,
          backgroundColor: styleStore.primaryColor,
          foregroundColor: AppColors.logo,
          spaceBetweenChildren: 16,
          children: [
            SpeedDialChild(
              backgroundColor: styleStore.primaryColor,
              child: Icon(LineIcons.list, color: AppColors.logo),
              labelWidget: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  'Add to a list',
                  style: GoogleFonts.getFont('Mitr',
                      color: AppColors.text,
                      fontSize: 16,
                      fontWeight: FontWeight.w300),
                ),
              ),
            ),
            SpeedDialChild(
              backgroundColor: styleStore.primaryColor,
              child: Icon(LineIcons.bookmark, color: AppColors.logo),
              labelWidget: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  'Add to your watchlist',
                  style: GoogleFonts.getFont('Mitr',
                      color: AppColors.text,
                      fontSize: 16,
                      fontWeight: FontWeight.w300),
                ),
              ),
            ),
            SpeedDialChild(
              backgroundColor: styleStore.primaryColor,
              child: Icon(LineIcons.star, color: AppColors.logo),
              labelWidget: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  'Rate it!',
                  style: GoogleFonts.getFont('Mitr',
                      color: AppColors.text,
                      fontSize: 16,
                      fontWeight: FontWeight.w300),
                ),
              ),
            ),
            SpeedDialChild(
              backgroundColor: styleStore.primaryColor,
              child: Icon(LineIcons.heart, color: AppColors.logo),
              labelWidget: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  'Mark as favorite',
                  style: GoogleFonts.getFont('Mitr',
                      color: AppColors.text,
                      fontSize: 16,
                      fontWeight: FontWeight.w300),
                ),
              ),
            ),
          ],
        ),
        backgroundColor: AppColors.background,
        appBar: AppBar(
          iconTheme: IconThemeData(color: AppColors.logo),
          backgroundColor: styleStore.primaryColor,
          title: InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => WelcomeScreen(),
                ),
              );
            },
            child: Ink(
              child: Hero(
                tag: "logo",
                child: SizedBox(
                  height: 56,
                  child: Image.asset(
                    "assets/images/WWatch2-png.png",
                    fit: BoxFit.fitHeight,
                    filterQuality: FilterQuality.medium,
                  ),
                ),
              ),
            ),
          ),
          actions: [],
        ),
        body: Observer(
          builder: (_) {
            if (movieStore.error)
              //TODO create a error screen

              return Center(
                child: Text(
                  'Ocorreu um Erro',
                  style: TextStyle(color: Colors.white),
                ),
              );
            if (movieStore.movie == null)
              return LinearProgressIndicator(
                valueColor: AlwaysStoppedAnimation(
                  styleStore.primaryColor,
                ),
                backgroundColor: styleStore.primaryColor!.withAlpha(100),
              );
            else
              return ListView.builder(
                  physics: BouncingScrollPhysics(),
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    switch (index) {
                      case 0:
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 16),
                          child: HeaderWidget(movie: movieStore.movie!),
                        );
                      case 1:
                        return DescriptionWidget(movie: movieStore.movie!);
                      case 2:
                        return movieStore.movie!.images != null &&
                                movieStore.movie!.images!.length > 0
                            ? PostersWidget(movie: movieStore.movie!)
                            : Container();
                      //TODO find a better way to display videos (this one is too performance heavy)
                      // case 3:
                      //   return movieStore.movie!.videos != null &&
                      //           movieStore.movie!.videos!.length > 0
                      //       ? TrailersWidget(
                      //           movie: movieStore.movie!,
                      //         )
                      //       : Container();
                      case 4:
                        return const SizedBox(
                          height: 64,
                        );
                      default:
                        return Container();
                    }
                    //   Column(
                    //   mainAxisSize: MainAxisSize.min,
                    //   children: [
                    //     Padding(
                    //       padding: const EdgeInsets.only(bottom: 16),
                    //       child: HeaderWidget(movie: movieStore.movie!),
                    //     ),
                    //     DescriptionWidget(movie: movieStore.movie!),
                    //     movieStore.movie!.images != null &&
                    //             movieStore.movie!.images!.length > 0
                    //         ? PostersWidget(movie: movieStore.movie!)
                    //         : Container(),
                    //      movieStore.movie!.videos != null &&
                    //              movieStore.movie!.videos!.length > 0
                    //        ? TrailersWidget(
                    //              movie: movieStore.movie!,
                    //            )
                    //          : Container(),
                    //     movieStore.movie!.watchProviders != null
                    //         ? WatchProvidersWidget()
                    //         : Container(),
                    //     const SizedBox(
                    //       height: 64,
                    //     )
                    //   ],
                    // );
                  });
          },
        ));
  }
}
