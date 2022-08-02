import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_icons/line_icons.dart';
import 'package:wwatch/Shared/Themes/app_colors.dart';
import 'package:wwatch/stores/movie_store.dart';
import 'package:wwatch/stores/style_store.dart';
import 'package:wwatch/stores/user_store.dart';

class CustomSpeedDialMovieScreen extends StatefulWidget {
  CustomSpeedDialMovieScreen(
      {Key? key,
      this.watchlist,
      this.rate,
      required this.customSetState,
      required this.movieStore,
      required this.mediaId})
      : super(key: key);
  final bool? watchlist;
  final int? rate;
  final int mediaId;
  MovieStore movieStore;
  VoidCallback customSetState;

  @override
  State<CustomSpeedDialMovieScreen> createState() =>
      _CustomSpeedDialMovieScreenState();
}

class _CustomSpeedDialMovieScreenState
    extends State<CustomSpeedDialMovieScreen> {
  final StyleStore styleStore = GetIt.I<StyleStore>();

  final UserStore userStore = GetIt.I<UserStore>();

  @override
  Widget build(BuildContext context) {
    return SpeedDial(
      switchLabelPosition: styleStore.fabPosition == 0 ? true : false,
      elevation: 8,
      direction: SpeedDialDirection.up,
      overlayColor: Colors.black,
      backgroundColor: styleStore.primaryColor,
      iconTheme: IconThemeData(
        color: AppColors.textOnPrimaries[styleStore.colorIndex!],
      ),
      icon: Icons.add,
      activeIcon: Icons.close,
      spaceBetweenChildren: 16,
      children: [
        SpeedDialChild(
          backgroundColor: styleStore.primaryColor,
          child: Icon(
            LineIcons.list,
            color: AppColors.textOnPrimaries[styleStore.colorIndex!],
          ),
          labelWidget: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              'Add to a list',
              style: GoogleFonts.getFont('Mitr',
                  color: AppColors.text,
                  fontSize: 16,
                  fontWeight: FontWeight.w300),
            ),
          ),
        ),
        SpeedDialChild(
          onTap: () async {
            final response = await userStore.addToWatchList(
              mediaType: settingsStore.selectedContentType == 0
                  ? CustomContentType.MOVIE
                  : CustomContentType.TVSHOW,
              watchlist: !widget.movieStore.movie!.watchlist!,
              mediaID: widget.mediaId,
            );
            if (response['status_code'] != null) {
              widget.movieStore
                  .updateWatchlist(!widget.movieStore.movie!.watchlist!);
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(
                  widget.movieStore.movie!.watchlist!
                      ? settingsStore.selectedContentType == 0
                          ? "Movie" + " added to watchlist"
                          : "TV Show" + " added to watchlist"
                      : settingsStore.selectedContentType == 0
                          ? "Movie" + " removed from watchlist"
                          : "TV Show" + " removed from watchlist",
                  style: TextStyle(
                      color: AppColors.textOnPrimaries[styleStore.colorIndex!]),
                ),
                backgroundColor: styleStore.primaryColor,
              ));
              widget.customSetState();
            } else {
              print('Status Code:' + response['status_code']);
            }
          },
          backgroundColor: styleStore.primaryColor,
          child: Icon(
            widget.movieStore.movie!.watchlist!
                ? Icons.bookmark_remove_outlined
                : LineIcons.bookmark,
            color: AppColors.textOnPrimaries[styleStore.colorIndex!],
          ),
          labelWidget: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              widget.movieStore.movie!.watchlist!
                  ? 'Remove from watchlist'
                  : 'Add to your watchlist',
              style: GoogleFonts.getFont('Mitr',
                  color: AppColors.text,
                  fontSize: 16,
                  fontWeight: FontWeight.w300),
            ),
          ),
        ),
        SpeedDialChild(
          backgroundColor: styleStore.primaryColor,
          child: Icon(
            LineIcons.star,
            color: AppColors.textOnPrimaries[styleStore.colorIndex!],
          ),
          labelWidget: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              'Rate it!',
              style: GoogleFonts.getFont('Mitr',
                  color: AppColors.text,
                  fontSize: 16,
                  fontWeight: FontWeight.w300),
            ),
          ),
        ),
        SpeedDialChild(
          onTap: () async {
            final response = await userStore.markContentAsFavorite(
                mediaType: settingsStore.selectedContentType == 0
                    ? CustomContentType.MOVIE
                    : CustomContentType.TVSHOW,
                favorite: !widget.movieStore.movie!.favorite!,
                mediaID: widget.mediaId);
            if (response['status_code'] != null) {
              widget.movieStore
                  .updateFavorite(!widget.movieStore.movie!.favorite!);
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text(
                    widget.movieStore.movie!.favorite!
                        ? settingsStore.selectedContentType == 0
                            ? "Movie" + " added to watchlist"
                            : "TV Show" + " marked as favorite"
                        : settingsStore.selectedContentType == 0
                            ? "Movie" + " removed from watchlist"
                            : "TV Show" + " removed from favorites",
                    style: TextStyle(
                        color:
                            AppColors.textOnPrimaries[styleStore.colorIndex!]),
                  ),
                  backgroundColor: styleStore.primaryColor));
              widget.customSetState();
            } else {
              print('Status Code:' + response['status_code']);
            }
          },
          backgroundColor: styleStore.primaryColor,
          child: Icon(
            widget.movieStore.movie!.favorite != null &&
                    widget.movieStore.movie!.favorite!
                ? LineIcons.heartBroken
                : LineIcons.heart,
            color: AppColors.textOnPrimaries[styleStore.colorIndex!],
          ),
          labelWidget: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              widget.movieStore.movie!.favorite != null &&
                      widget.movieStore.movie!.favorite!
                  ? 'Remove from favorites'
                  : 'Mark as favorite',
              style: GoogleFonts.getFont('Mitr',
                  color: AppColors.text,
                  fontSize: 16,
                  fontWeight: FontWeight.w300),
            ),
          ),
        ),
      ],
    );
  }
}
