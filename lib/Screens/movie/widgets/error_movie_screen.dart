import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wwatch/stores/movie_store.dart';

import 'package:wwatch/stores/style_store.dart';

class CustomErrorMovieScreen extends StatelessWidget {
  const CustomErrorMovieScreen({
    Key? key,
    required this.movieStore,
    required this.movieId,
  }) : super(key: key);
  final MovieStore movieStore;
  final int movieId;
  @override
  Widget build(BuildContext context) {
    final StyleStore styleStore = GetIt.I<StyleStore>();
    return Center(
      child: Container(
        margin: const EdgeInsets.all(32),
        padding: const EdgeInsets.all(16),
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
            const SizedBox(
              height: 32,
            ),
            Container(
              height: 120,
              child: SvgPicture.asset(
                styleStore.errorImage!,
                fit: BoxFit.fitHeight,
              ),
            ),
            const SizedBox(
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
            const SizedBox(
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
            const SizedBox(
              height: 32,
            ),
            Container(
              height: 48,
              width: double.infinity,
              child: ElevatedButton(
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(styleStore.primaryColor)),
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
  }
}
