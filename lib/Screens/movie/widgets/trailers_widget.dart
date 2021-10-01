import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wwatch/Shared/Themes/app_colors.dart';

class TrailersWidget extends StatelessWidget {
  const TrailersWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 16,
        ),
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
          'Movie Trailers',
          style: GoogleFonts.getFont('Mitr',
              color: AppColors.text, fontSize: 22, fontWeight: FontWeight.w400),
        ),
      ],
    );
  }
}
