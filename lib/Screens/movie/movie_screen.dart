import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_icons/line_icons.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

import 'package:wwatch/Screens/movie/widgets/description_widget.dart';
import 'package:wwatch/Screens/movie/widgets/header_widget.dart';
import 'package:wwatch/Screens/movie/widgets/posters_widget.dart';
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
    return Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        floatingActionButton: SpeedDial(
          elevation: 8,
          direction: SpeedDialDirection.up,
          overlayColor: Colors.black,
          backgroundColor: styleStore.primaryColor,
          iconTheme: IconThemeData(
            color: AppColors.textOnPrimaries[styleStore.colorIndex!],
          ),
          icon: Icons.add,
          activeIcon: Icons.close,
          spaceBetweenChildren: 16,
          children: [
            SpeedDialChild(
              backgroundColor: styleStore.primaryColor,
              child: Icon(
                LineIcons.list,
                color: AppColors.textOnPrimaries[styleStore.colorIndex!],
              ),
              labelWidget: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  'Add to a list',
                  style: GoogleFonts.getFont('Mitr',
                      color: styleStore.textColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w300),
                ),
              ),
            ),
            SpeedDialChild(
              backgroundColor: styleStore.primaryColor,
              child: Icon(
                LineIcons.bookmark,
                color: AppColors.textOnPrimaries[styleStore.colorIndex!],
              ),
              labelWidget: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  'Add to your watchlist',
                  style: GoogleFonts.getFont('Mitr',
                      color: styleStore.textColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w300),
                ),
              ),
            ),
            SpeedDialChild(
              backgroundColor: styleStore.primaryColor,
              child: Icon(
                LineIcons.star,
                color: AppColors.textOnPrimaries[styleStore.colorIndex!],
              ),
              labelWidget: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  'Rate it!',
                  style: GoogleFonts.getFont('Mitr',
                      color: styleStore.textColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w300),
                ),
              ),
            ),
            SpeedDialChild(
              backgroundColor: styleStore.primaryColor,
              child: Icon(
                LineIcons.heart,
                color: AppColors.textOnPrimaries[styleStore.colorIndex!],
              ),
              labelWidget: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  'Mark as favorite',
                  style: GoogleFonts.getFont('Mitr',
                      color: styleStore.textColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w300),
                ),
              ),
            ),
          ],
        ),
        backgroundColor: styleStore.backgroundColor,
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: settingsStore.brightness != CustomBrightness.amoled
                ? AppColors.textOnPrimaries[styleStore.colorIndex!]
                : AppColors.text,
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
                    : AppColors.text,
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
              return Center(
                child: Container(
                  margin: EdgeInsets.all(32),
                  padding: EdgeInsets.all(16),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: styleStore.shapeColor,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'ERROR',
                        style: GoogleFonts.getFont('Mitr',
                            color: styleStore.textColor,
                            fontSize: 24,
                            fontWeight: FontWeight.w400),
                      ),
                      SizedBox(
                        height: 32,
                      ),
                      Container(
                        height: 120,
                        child: SvgPicture.asset(
                          styleStore.errorImage!,
                          fit: BoxFit.fitHeight,
                        ),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Text(
                        "We couldn't connect you to the TMDB servers",
                        style: GoogleFonts.getFont('Mitr',
                            color: styleStore.textColor,
                            fontSize: 14,
                            fontWeight: FontWeight.w300),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Text(
                        "verify your internet connection and try again",
                        style: GoogleFonts.getFont('Mitr',
                            color: styleStore.textColor,
                            fontSize: 12,
                            fontWeight: FontWeight.w100),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                        height: 32,
                      ),
                      Container(
                        height: 48,
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                  styleStore.primaryColor)),
                          onPressed: () {
                            movieStore.error = false;
                            movieStore.getSingleMovie(movieId);
                          },
                          child: Text(
                            "Try Again",
                            style: GoogleFonts.getFont('Mitr',
                                color: styleStore.textColor,
                                fontSize: 16,
                                fontWeight: FontWeight.w300),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              );
            if (movieStore.movie == null)
              return SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    LinearProgressIndicator(
                      valueColor: AlwaysStoppedAnimation(
                        styleStore.primaryColor,
                      ),
                      backgroundColor: styleStore.primaryColor!.withAlpha(100),
                    ),
                    Container(
                      height: 300,
                      child: Stack(
                        alignment: Alignment.bottomLeft,
                        children: [
                          Positioned(
                            bottom: 56,
                            left: 8,
                            child: Container(
                              clipBehavior: Clip.antiAlias,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16)),
                              child: Shimmer(
                                child: Container(
                                  height: 40,
                                  width: 180,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(bottom: 8),
                            height: 30,
                            child: ListView.builder(
                                physics: BouncingScrollPhysics(),
                                scrollDirection: Axis.horizontal,
                                itemCount: 5,
                                itemBuilder: (context, index) {
                                  return Container(
                                    clipBehavior: Clip.antiAlias,
                                    margin:
                                        EdgeInsets.symmetric(horizontal: 16),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8)),
                                    child: Shimmer(
                                      child: Container(
                                        height: 18,
                                        width: 96,
                                      ),
                                    ),
                                  );
                                }),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 16),
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16)),
                      child: Shimmer(
                        child: Container(
                          height: 32,
                          width: 180,
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 16, top: 16),
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16)),
                      child: Shimmer(
                        child: Container(
                          height: 190,
                          width: 128,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 45,
                    ),
                    Divider(
                      color: AppColors.divider,
                      thickness: 1,
                      endIndent: 24,
                      indent: 24,
                    ),
                    SizedBox(
                      height: 45,
                    ),
                  ],
                ),
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

                      case 3:
                        return movieStore.movie!.videos != null &&
                                movieStore.movie!.videos!.length > 0
                            ? TrailersWidget(
                                movie: movieStore.movie!,
                              )
                            : Container();
                      case 4:
                        return const SizedBox(
                          height: 64,
                        );
                      default:
                        return Container();
                    }
                  });
          },
        ));
  }
}
