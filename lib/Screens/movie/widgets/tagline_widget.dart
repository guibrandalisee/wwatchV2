import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wwatch/Shared/Themes/app_colors.dart';

import 'package:wwatch/Shared/models/movie_model.dart';
import 'package:wwatch/stores/style_store.dart';

class TaglineWidget extends StatelessWidget {
  const TaglineWidget({
    Key? key,
    required this.movie,
  }) : super(key: key);
  final CompleteMovie movie;
  @override
  Widget build(BuildContext context) {
    StyleStore styleStore = GetIt.I<StyleStore>();
    return Column(
      children: [
        Divider(
          color: AppColors.divider,
          thickness: 1,
          endIndent: 24,
          indent: 24,
        ),
        Padding(
          padding: const EdgeInsets.all(16),
          child: Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              '${movie.tagline!}',
              style: GoogleFonts.getFont(
                'Kodchasan',
                color: styleStore.textColor,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
            // child: RichText(
            //   textAlign: TextAlign.center,
            //   text: TextSpan(
            //     text: '\“',
            //     style: GoogleFonts.getFont(
            //       'Kodchasan',
            //       color: AppColors.text,
            //       fontSize: 28,
            //       fontWeight: FontWeight.w500,
            //     ),
            //     children: <TextSpan>[
            //       TextSpan(
            //         text: movie.tagline!.endsWith('.')
            //             ? '${movie.tagline!.substring(0, movie.tagline!.length - 1)}'
            //             : '${movie.tagline!}',
            //         style: GoogleFonts.getFont('Kodchasan',
            //             color: AppColors.text,
            //             fontSize: 16,
            //             fontWeight: FontWeight.w400),
            //       ),
            //       TextSpan(
            //         text: '\„',
            //         style: GoogleFonts.getFont(
            //           'Kodchasan',
            //           color: AppColors.text,
            //           fontSize: 28,
            //           fontWeight: FontWeight.w500,
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
          ),
        ),
      ],
    );
  }
}
