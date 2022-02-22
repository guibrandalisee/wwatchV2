import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wwatch/Shared/Themes/app_colors.dart';

import 'package:wwatch/Shared/models/movie_model.dart';
import 'package:wwatch/stores/movie_store.dart';
import 'package:wwatch/stores/settings_store.dart';
import 'package:wwatch/stores/style_store.dart';

class MovieStatsWidget extends StatelessWidget {
  const MovieStatsWidget({
    Key? key,
    required this.movie,
  }) : super(key: key);
  final CompleteMovie movie;

  @override
  Widget build(BuildContext context) {
    StyleStore styleStore = GetIt.I<StyleStore>();
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          Divider(
            color: AppColors.divider,
            thickness: 1,
            endIndent: 24,
            indent: 24,
          ),
          const SizedBox(
            height: 32,
          ),
          Text(
            settingsStore.selectedContentType == 0
                ? 'Movie Information'
                : 'Information',
            style: GoogleFonts.getFont('Mitr',
                color: styleStore.textColor,
                fontSize: 22,
                fontWeight: FontWeight.w500),
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 32,
          ),
          CustomStatWidget(
              title: 'Original Title',
              content: movie.originalTitle.toString().trim()),
          CustomStatWidget(
              title: 'Original Language',
              content: movie.originalLanguage.toString().toUpperCase()),
          if (movie.runtime != null &&
              !movie.runtime!.isNaN &&
              movie.runtime! > 1)
            CustomStatWidget(
                title: 'Runtime', content: formatTime(movie.runtime!)),
          if (movie.releaseDate != null &&
              movie.releaseDate! != '0000-00-00' &&
              movie.releaseDate!.isNotEmpty &&
              settingsStore.selectedContentType == 0)
            CustomStatWidget(
                title: 'Release Date',
                content: formatDate(movie) + ' - ${movie.launchStatus}'),
          if (movie.releaseDate != null &&
              movie.releaseDate! != '0000-00-00' &&
              movie.releaseDate!.isNotEmpty &&
              settingsStore.selectedContentType == 1)
            CustomStatWidget(
                title: 'First Air Date', content: formatDate(movie)),
          if (movie.budget != null && !movie.budget!.isNaN && movie.budget! > 1)
            CustomStatWidget(
                title: 'Budget', content: moneyFormat(movie.budget.toString())),
          if (movie.revenue != null &&
              !movie.revenue!.isNaN &&
              movie.revenue! > 1)
            CustomStatWidget(
                title: 'Revenue',
                content: moneyFormat(movie.revenue.toString())),
          if (!movie.voteCount.isNaN)
            CustomStatWidget(
                title: 'Vote Count', content: movie.voteCount.toString()),
        ],
      ),
    );
  }
}

String formatTime(int value) {
  if (value < 60) return "$value minutes";

  String hours = '${(value / 60).truncate()} hours';
  String minutes = value - ((value / 60).truncate() * 60) != 0
      ? ' and ${value - ((value / 60).truncate() * 60)} minutes'
      : '';
  return hours + minutes;
}

String formatDate(CompleteMovie movie) {
  SettingsStore settingsStore = GetIt.I<SettingsStore>();

  switch (settingsStore.dateFormat) {
    case 'dd/mm/yyyy':
      return '${movie.releaseDate!.substring(8, 10)}/${movie.releaseDate!.substring(5, 7)}/${movie.releaseDate!.substring(0, 4)}';

    case 'mm/dd/yyyy':
      return '${movie.releaseDate!.substring(5, 7)}/${movie.releaseDate!.substring(8, 10)}/${movie.releaseDate!.substring(0, 4)}';

    case 'yyyy/mm/dd':
      return movie.releaseDate!.replaceAll('-', '/');
  }
  return '';
}

String moneyFormat(String price) {
  if (price.length > 2) {
    var value = price;
    value = value.replaceAll(RegExp(r'\D'), '');
    value = value.replaceAll(RegExp(r'\B(?=(\d{3})+(?!\d))'), ',');
    return '\$' + value;
  } else {
    return '\$' + price;
  }
}

class CustomStatWidget extends StatelessWidget {
  const CustomStatWidget({
    Key? key,
    required this.title,
    required this.content,
  }) : super(key: key);
  final String title;
  final String content;
  @override
  Widget build(BuildContext context) {
    StyleStore styleStore = GetIt.I<StyleStore>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          title,
          style: GoogleFonts.getFont('Mitr',
              color: styleStore.textColor,
              fontSize: 15,
              fontWeight: FontWeight.w500),
          textAlign: TextAlign.start,
        ),
        const SizedBox(
          height: 4,
        ),
        Text(
          content,
          style: GoogleFonts.getFont('Mitr',
              color: styleStore.textColor,
              fontSize: 13,
              fontWeight: FontWeight.w300),
          textAlign: TextAlign.start,
        ),
        const SizedBox(
          height: 2,
        ),
        Divider(
          color: styleStore.textColor,
        ),
        const SizedBox(
          height: 8,
        ),
      ],
    );
  }
}
