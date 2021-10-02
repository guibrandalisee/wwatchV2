import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_icons/line_icons.dart';
import 'package:wwatch/Screens/movie/widgets/description_widget.dart';
import 'package:wwatch/Screens/movie/widgets/header_widget.dart';
import 'package:wwatch/Screens/movie/widgets/posters_widget.dart';
import 'package:wwatch/Screens/movie/widgets/trailers_widget.dart';
import 'package:wwatch/Screens/movie/widgets/watch_providers_widget.dart';
import 'package:wwatch/Screens/welcome/welcome_screen.dart';
import 'package:wwatch/Shared/Themes/app_colors.dart';

import 'package:wwatch/stores/movie_store.dart';
import 'package:wwatch/stores/style_store.dart';

class MovieScreen extends StatefulWidget {
  final int movieId;

  MovieScreen({
    Key? key,
    required this.movieId,
  }) : super(key: key);

  @override
  State<MovieScreen> createState() => _MovieScreenState();
}

class _MovieScreenState extends State<MovieScreen> {
  @override
  void initState() {
    movieStore.getSingleMovie(widget.movieId);
    super.initState();
  }

  final StyleStore styleStore = GetIt.I<StyleStore>();

  final MovieStore movieStore = MovieStore();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
        floatingActionButton: SpeedDial(
          child: Icon(LineIcons.angleDown),
          elevation: 8,
          direction: SpeedDialDirection.down,
          overlayColor: Colors.black,
          backgroundColor: styleStore.primaryColor,
          spaceBetweenChildren: 16,
          children: [
            SpeedDialChild(
              backgroundColor: styleStore.primaryColor,
              child: Icon(LineIcons.list, color: Colors.white),
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
              child: Icon(LineIcons.bookmark, color: Colors.white),
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
              child: Icon(LineIcons.star, color: Colors.white),
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
              child: Icon(LineIcons.heart, color: Colors.white),
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
              return SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: HeaderWidget(movie: movieStore.movie!),
                    ),
                    DescriptionWidget(movie: movieStore.movie!),
                    movieStore.movie!.images != null &&
                            movieStore.movie!.images!.length > 0
                        ? PostersWidget(movie: movieStore.movie!)
                        : Container(),
                    movieStore.movie!.videos != null &&
                            movieStore.movie!.videos!.length > 0
                        ? TrailersWidget(
                            movie: movieStore.movie!,
                          )
                        : Container(),
                    movieStore.movie!.watchProviders != null
                        ? WatchProvidersWidget()
                        : Container(),
                    SizedBox(
                      height: 64,
                    )
                  ],
                ),
              );
          },
        ));
  }
}
