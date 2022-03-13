import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:wwatch/Screens/home/components/content_filter_widget.dart';
import 'package:wwatch/Shared/Themes/app_colors.dart';
import 'package:wwatch/stores/movie_store.dart';
import 'package:wwatch/stores/style_store.dart';

class CustomNothingFoundErrorScreen extends StatelessWidget {
  const CustomNothingFoundErrorScreen({
    Key? key,
    required this.movieStore,
    required this.focusNode,
  }) : super(key: key);
  final MovieStore movieStore;
  final FocusNode focusNode;

  @override
  Widget build(BuildContext context) {
    final StyleStore styleStore = GetIt.I<StyleStore>();
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(
            height: 28,
          ),
          ContentFilter(
            focusNode: focusNode,
            movieStore: movieStore,
          ),
          Center(
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
                  const SizedBox(
                    height: 32,
                  ),
                  Container(
                    height: 120,
                    child: SvgPicture.asset(
                      styleStore.nothingFoundImage!,
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                  const SizedBox(
                    height: 32,
                  ),
                  Text(
                    "Couldn't find any movies with the especified filters :(",
                    style: GoogleFonts.getFont('Mitr',
                        color: AppColors.text,
                        fontSize: 16,
                        fontWeight: FontWeight.w300),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
