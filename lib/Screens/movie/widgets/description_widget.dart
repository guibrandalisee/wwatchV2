import 'package:drop_cap_text/drop_cap_text.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_icons/line_icons.dart';
import 'package:wwatch/Screens/full_screen_image/full_screen_image.dart';
import 'package:wwatch/Shared/Themes/app_colors.dart';
import 'package:wwatch/Shared/models/movie_model.dart';
import 'package:wwatch/stores/style_store.dart';

class DescriptionWidget extends StatelessWidget {
  DescriptionWidget({
    Key? key,
    required this.movie,
  }) : super(key: key);
  final CompleteMovie movie;

  @override
  Widget build(BuildContext context) {
    final styleStore = GetIt.I<StyleStore>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
            margin: EdgeInsets.only(left: 32, right: 32, bottom: 16),
            padding: EdgeInsets.all(4),
            alignment: Alignment.center,
            height: 32,
            decoration: BoxDecoration(
              color: styleStore.shapeColor,
              borderRadius: BorderRadius.circular(32),
            ),
            child: RichText(
              text: TextSpan(
                text: 'Status: ',
                style: GoogleFonts.getFont('Mitr',
                    color: AppColors.text,
                    fontSize: 16,
                    fontWeight: FontWeight.w300),
                children: <TextSpan>[
                  TextSpan(
                    text: '${movie.launchStatus}',
                    style: GoogleFonts.getFont('Kodchasan',
                        color: AppColors.text,
                        fontSize: 16,
                        fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            )),

        //TODO find out how to get movie Age Certifications
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Container(
            width: double.infinity,
            child: Text(
              movie.title,
              style: GoogleFonts.getFont('Mitr',
                  color: styleStore.textColor,
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
                color: styleStore.textColor,
                fontSize: 20,
                fontWeight: FontWeight.w300),
            dropCapPadding: const EdgeInsets.only(right: 16, bottom: 8),
            dropCap: DropCap(
                child: movie.posterPath != null
                    ? InkWell(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => FullScreenImage(
                                  path:
                                      "https://image.tmdb.org/t/p/original${movie.posterPath}")));
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
                                padding: const EdgeInsets.all(4),
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
                              color: styleStore.textColor,
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
