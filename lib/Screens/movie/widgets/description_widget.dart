import 'package:drop_cap_text/drop_cap_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_icons/line_icons.dart';
import 'package:wwatch/Screens/full_image/full_image_screen.dart';

import 'package:wwatch/Shared/Themes/app_colors.dart';
import 'package:wwatch/Shared/models/movie_model.dart';

class DescriptionWidget extends StatelessWidget {
  DescriptionWidget({
    Key? key,
    required this.movie,
  }) : super(key: key);
  final CompleteMovie movie;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //TODO find out how to get movie Age Certifications
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Container(
            width: double.infinity,
            child: Text(
              movie.title,
              style: GoogleFonts.getFont('Mitr',
                  color: AppColors.text,
                  fontSize: 22,
                  fontWeight: FontWeight.w600),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: DropCapText(
            movie.overview,
            style: GoogleFonts.getFont('Mitr',
                color: AppColors.text,
                fontSize: 20,
                fontWeight: FontWeight.w300),
            dropCapPadding: EdgeInsets.only(right: 16, bottom: 8),
            dropCap: DropCap(
                //TODO add a gesture detector arround the image to view in full screen
                child: movie.posterPath!.isNotEmpty
                    ? GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => FullImageScreen(
                                        imgPath:
                                            'https://image.tmdb.org/t/p/w500${movie.posterPath}',
                                      )));
                        },
                        child: Stack(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.network(
                                'https://image.tmdb.org/t/p/w500${movie.posterPath}',
                                filterQuality: FilterQuality.medium,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Positioned(
                              left: 8,
                              top: 8,
                              child: Container(
                                padding: EdgeInsets.all(4),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(4),
                                    color: AppColors.shape.withAlpha(100)),
                                child: Icon(
                                  LineIcons.alternateExpandArrows,
                                  size: 22,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    : Container(
                        alignment: Alignment.center,
                        child: Text(
                          'No Image :(',
                          style: GoogleFonts.getFont('Mitr',
                              color: AppColors.text,
                              fontSize: 18,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                width: 128,
                height: 190),
          ),
        ),
      ],
    );
  }
}
