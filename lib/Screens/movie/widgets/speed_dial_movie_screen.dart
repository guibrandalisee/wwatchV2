import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_icons/line_icons.dart';
import 'package:rate/rate.dart';
import 'package:wwatch/Shared/Themes/app_colors.dart';
import 'package:wwatch/stores/movie_store.dart';
import 'package:wwatch/stores/settings_store.dart';
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
  final MovieStore movieStore;
  final VoidCallback customSetState;

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
          onTap: () {
            showDialog(
                context: context,
                builder: (context) {
                  return RateItAlertDialog(
                    movieStore: widget.movieStore,
                    customSetState: widget.customSetState,
                  );
                });
          },
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

class RateItAlertDialog extends StatefulWidget {
  RateItAlertDialog(
      {Key? key, required this.movieStore, required this.customSetState})
      : super(key: key);
  final MovieStore movieStore;
  final VoidCallback customSetState;

  @override
  State<RateItAlertDialog> createState() => _RateItAlertDialogState();
}

class _RateItAlertDialogState extends State<RateItAlertDialog> {
  final StyleStore styleStore = GetIt.I<StyleStore>();
  final UserStore userStore = GetIt.I<UserStore>();
  final SettingsStore settingsStore = GetIt.I<SettingsStore>();
  double rating = 0;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Rating",
            style: GoogleFonts.mitr(
                color: styleStore.textColor,
                fontSize: 22,
                fontWeight: FontWeight.w300),
          ),
          RichText(
            text: TextSpan(
              text: rating.toStringAsFixed(0),
              style: GoogleFonts.getFont('Kodchasan',
                  color: AppColors.text,
                  fontSize: 22,
                  fontWeight: FontWeight.w300),
              children: <TextSpan>[
                TextSpan(
                  text: '/10',
                  style: GoogleFonts.getFont('Kodchasan',
                      color: AppColors.text,
                      fontSize: 16,
                      fontWeight: FontWeight.w300,
                      decoration: TextDecoration.overline),
                )
              ],
            ),
          )
        ],
      ),
      titlePadding: EdgeInsets.only(left: 16, top: 8, right: 16),
      backgroundColor: styleStore.shapeColor,
      content: Container(
        height: 40,
        child: Center(
          child: Rate(
            iconSize: 36,
            color: styleStore.primaryColor!,
            allowHalf: true,
            onChange: (value) {
              setState(() {
                rating = value * 2;
              });
            },
            allowClear: false,
          ),
        ),
      ),
      actions: [
        if (widget.movieStore.movie!.rate != null)
          ElevatedButton(
            onPressed: () async {
              final response = await userStore.deleteRateContent(
                  mediaType: settingsStore.selectedContentType == 0
                      ? CustomContentType.MOVIE
                      : CustomContentType.TVSHOW,
                  mediaID: widget.movieStore.movie!.id);
              if (response['error'] == null) {
                widget.movieStore.updateRate(null);
                Navigator.of(context).pop();
                widget.customSetState();
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text(
                    "Success!",
                    style: TextStyle(color: styleStore.textOnPrimaryColor),
                  ),
                  backgroundColor: styleStore.primaryColor,
                ));
              } else {
                print(response['error']);
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text(
                    "Error!",
                    style: TextStyle(color: styleStore.textOnPrimaryColor),
                  ),
                  backgroundColor: Colors.redAccent,
                ));
              }
            },
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.red)),
            child: Text(
              "Remove Rating",
              style: GoogleFonts.mitr(
                  color: AppColors.text,
                  fontSize: 18,
                  fontWeight: FontWeight.w300),
            ),
          ),
        ElevatedButton(
          onPressed: () async {
            if (rating != 0) {
              final response = await userStore.rateContent(
                rating: rating,
                mediaType: settingsStore.selectedContentType == 0
                    ? CustomContentType.MOVIE
                    : CustomContentType.TVSHOW,
                mediaID: widget.movieStore.movie!.id,
              );

              if (response['error'] == null) {
                widget.movieStore.updateRate(rating);
                widget.customSetState();
                Navigator.of(context).pop();

                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text(
                    "Success!",
                    style: TextStyle(color: styleStore.textOnPrimaryColor),
                  ),
                  backgroundColor: styleStore.primaryColor,
                ));
              } else {
                print(response['error']);
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text(
                    "Error!",
                    style: TextStyle(color: styleStore.textOnPrimaryColor),
                  ),
                  backgroundColor: Colors.redAccent,
                ));
              }
            }
          },
          style: ButtonStyle(
              backgroundColor:
                  MaterialStateProperty.all(styleStore.primaryColor)),
          child: Text(
            widget.movieStore.movie!.rate != null ? "Update" : "Rate It",
            style: GoogleFonts.mitr(
                color: AppColors.textOnPrimaries[styleStore.colorIndex!],
                fontSize: 18,
                fontWeight: FontWeight.w300),
          ),
        )
      ],
    );
  }
}
