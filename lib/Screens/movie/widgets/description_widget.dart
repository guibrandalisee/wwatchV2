import 'package:drop_cap_text/drop_cap_text.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_icons/line_icons.dart';

import 'package:wwatch/Shared/Themes/app_colors.dart';
import 'package:wwatch/Shared/models/movie_model.dart';
import 'package:wwatch/stores/movie_store.dart';

class DescriptionWidget extends StatelessWidget {
  DescriptionWidget({
    Key? key,
    required this.movie,
  }) : super(key: key);
  final SimpleMovie movie;
  final MovieStore movieStore = GetIt.I<MovieStore>();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //TODO find out how to get movie Age Certifications
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 4,
                child: Container(
                  child: Text(
                    movie.title,
                    style: GoogleFonts.getFont('Mitr',
                        color: AppColors.text,
                        fontSize: 22,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 8, right: 8),
                width: 1,
                height: 24,
                color: AppColors.divider,
              ),
              Expanded(
                flex: 1,
                child: Padding(
                  padding: EdgeInsets.zero,
                  child: IconButton(
                    tooltip: 'Add to a list',
                    constraints: BoxConstraints(),
                    splashRadius: 20,
                    onPressed: () {},
                    icon: Icon(LineIcons.list, color: Colors.white),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Padding(
                  padding: EdgeInsets.zero,
                  child: IconButton(
                    tooltip: 'Add to your watchlist',
                    constraints: BoxConstraints(),
                    splashRadius: 20,
                    onPressed: () {},
                    icon: Icon(LineIcons.bookmark, color: Colors.white),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Padding(
                  padding: EdgeInsets.zero,
                  child: IconButton(
                    tooltip: 'Rate it!',
                    constraints: BoxConstraints(),
                    splashRadius: 20,
                    onPressed: () {},
                    icon: Icon(LineIcons.star, color: Colors.white),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Padding(
                  padding: EdgeInsets.zero,
                  child: IconButton(
                    tooltip: 'Mark as favorite',
                    constraints: BoxConstraints(),
                    splashRadius: 20,
                    onPressed: () {},
                    icon: Icon(LineIcons.heart, color: Colors.white),
                  ),
                ),
              ),
            ],
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
                child: movie.posterPath!.isNotEmpty
                    ? Image.network(
                        'https://image.tmdb.org/t/p/w500${movie.posterPath}',
                        filterQuality: FilterQuality.none,
                        fit: BoxFit.cover,
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
