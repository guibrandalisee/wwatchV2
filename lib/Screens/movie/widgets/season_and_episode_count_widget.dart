import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wwatch/Shared/Themes/app_colors.dart';

import 'package:wwatch/stores/style_store.dart';

class SeasonEpisodeCount extends StatelessWidget {
  SeasonEpisodeCount({
    Key? key,
    required this.title,
    required this.value,
  }) : super(key: key);
  final StyleStore styleStore = GetIt.I<StyleStore>();
  final String title;
  final int value;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
          height: 56,
          padding: EdgeInsets.symmetric(vertical: 16, horizontal: 24),
          decoration: BoxDecoration(
              color: styleStore.shapeColor,
              borderRadius: BorderRadius.circular(5)),
          child: Center(
            child: RichText(
              text: TextSpan(
                text: (value).toString(),
                style: GoogleFonts.getFont('Kodchasan',
                    color: styleStore.textColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w500),
                children: <TextSpan>[
                  TextSpan(
                    text: ' $title',
                    style: GoogleFonts.getFont('Mitr',
                        color: styleStore.textColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w100),
                  ),
                ],
              ),
            ),
          )),
    );
  }
}
