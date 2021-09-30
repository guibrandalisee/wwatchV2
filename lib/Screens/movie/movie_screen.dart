import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wwatch/Screens/movie/widgets/description_widget.dart';
import 'package:wwatch/Screens/movie/widgets/header_widget.dart';
import 'package:wwatch/Screens/welcome/welcome_screen.dart';
import 'package:wwatch/Shared/Themes/app_colors.dart';

import 'package:wwatch/Shared/models/movie_model.dart';
import 'package:wwatch/stores/movie_store.dart';
import 'package:wwatch/stores/style_store.dart';

class MovieScreen extends StatelessWidget {
  final SimpleMovie movie;

  MovieScreen({
    Key? key,
    required this.movie,
  }) : super(key: key);
  final StyleStore styleStore = GetIt.I<StyleStore>();
  final MovieStore movieStore = GetIt.I<MovieStore>();

  @override
  Widget build(BuildContext context) {
    if (movieStore.movieGenres.isEmpty) movieStore.getGenres(ContentType.MOVIE);

    return Scaffold(
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
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            HeaderWidget(movie: movie),
            SizedBox(
              height: 16,
            ),
            DescriptionWidget(movie: movie),
            Divider(
              color: AppColors.divider,
              thickness: 1,
              endIndent: 24,
              indent: 24,
            ),
            SizedBox(
              height: 16,
            ),
            Text(
              'Movie Posters',
              style: GoogleFonts.getFont('Mitr',
                  color: AppColors.text,
                  fontSize: 22,
                  fontWeight: FontWeight.w600),
            ),
            SizedBox(
              height: 16,
            ),
            Container(
              child: CarouselSlider.builder(
                  itemCount: 5,
                  itemBuilder: (context, index, realIdx) {
                    return Container(
                      color: styleStore.primaryColor,
                    );
                  },
                  options: CarouselOptions(
                      scrollPhysics: BouncingScrollPhysics(),
                      enableInfiniteScroll: false,
                      scrollDirection: Axis.horizontal,
                      aspectRatio: 7 / 8,
                      autoPlay: false,
                      enlargeCenterPage: true)),
            )
          ],
        ),
      ),
    );
  }
}
