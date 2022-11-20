import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wwatch/Screens/all_watch_providers/all_watch_providers_screen.dart';

import 'package:wwatch/Shared/Themes/app_colors.dart';
import 'package:wwatch/Shared/models/movie_watch_providers_model.dart';
import 'package:wwatch/main.dart';
import 'package:wwatch/stores/movie_store.dart';
import 'package:wwatch/stores/settings_store.dart';
import 'package:wwatch/stores/style_store.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

enum WatchProviderType { flatrate, buy, rent, ads, free }

//TODO refactor this
//A lot of useleess ifs
class WatchProvidersWidgetMovieScreen extends StatefulWidget {
  WatchProvidersWidgetMovieScreen({
    Key? key,
    required this.movieStore,
  }) : super(key: key);
  final MovieStore movieStore;

  @override
  State<WatchProvidersWidgetMovieScreen> createState() =>
      _WatchProvidersWidgetMovieScreenState();
}

class _WatchProvidersWidgetMovieScreenState
    extends State<WatchProvidersWidgetMovieScreen> {
  @override
  void initState() {
    if (widget.movieStore.movie!.movieAvaliableWatchProviders!.flatrate !=
            null &&
        widget.movieStore.movie!.movieAvaliableWatchProviders!.flatrate!
            .isNotEmpty) {
      print('Flatrate');
      watchProviderType = WatchProviderType.flatrate;
    } else if (widget.movieStore.movie!.movieAvaliableWatchProviders!.rent !=
            null &&
        widget
            .movieStore.movie!.movieAvaliableWatchProviders!.rent!.isNotEmpty) {
      watchProviderType = WatchProviderType.rent;
      print('Rent');

      return;
    } else if (widget.movieStore.movie!.movieAvaliableWatchProviders!.buy !=
            null &&
        widget
            .movieStore.movie!.movieAvaliableWatchProviders!.buy!.isNotEmpty) {
      watchProviderType = WatchProviderType.buy;
      print('Buy');

      return;
    } else if (widget.movieStore.movie!.movieAvaliableWatchProviders!.free !=
            null &&
        widget
            .movieStore.movie!.movieAvaliableWatchProviders!.free!.isNotEmpty) {
      watchProviderType = WatchProviderType.free;
      print('Free');

      return;
    } else if (widget.movieStore.movie!.movieAvaliableWatchProviders!.ads !=
            null &&
        widget
            .movieStore.movie!.movieAvaliableWatchProviders!.ads!.isNotEmpty) {
      watchProviderType = WatchProviderType.ads;
      print('Ads');

      return;
    }

    super.initState();
  }

  final SettingsStore settingsStore = GetIt.I<SettingsStore>();

  final StyleStore styleStore = GetIt.I<StyleStore>();

  WatchProviderType watchProviderType = WatchProviderType.flatrate;

  List<AvaliableWatchProvider> currentWatchProviders = [];

  @override
  Widget build(BuildContext context) {
    switch (watchProviderType) {
      case WatchProviderType.flatrate:
        if (widget.movieStore.movie!.movieAvaliableWatchProviders != null &&
            widget.movieStore.movie!.movieAvaliableWatchProviders!.flatrate !=
                null) {
          currentWatchProviders =
              widget.movieStore.movie!.movieAvaliableWatchProviders!.flatrate!;
        } else {
          currentWatchProviders = [];
        }
        break;
      case WatchProviderType.buy:
        if (widget.movieStore.movie!.movieAvaliableWatchProviders != null &&
            widget.movieStore.movie!.movieAvaliableWatchProviders!.buy !=
                null) {
          currentWatchProviders =
              widget.movieStore.movie!.movieAvaliableWatchProviders!.buy!;
        } else {
          currentWatchProviders = [];
        }
        break;
      case WatchProviderType.rent:
        if (widget.movieStore.movie!.movieAvaliableWatchProviders != null &&
            widget.movieStore.movie!.movieAvaliableWatchProviders!.rent !=
                null) {
          currentWatchProviders =
              widget.movieStore.movie!.movieAvaliableWatchProviders!.rent!;
        } else {
          currentWatchProviders = [];
        }
        break;
      case WatchProviderType.ads:
        if (widget.movieStore.movie!.movieAvaliableWatchProviders != null &&
            widget.movieStore.movie!.movieAvaliableWatchProviders!.ads !=
                null) {
          currentWatchProviders =
              widget.movieStore.movie!.movieAvaliableWatchProviders!.ads!;
        } else {
          currentWatchProviders = [];
        }
        break;
      case WatchProviderType.free:
        if (widget.movieStore.movie!.movieAvaliableWatchProviders != null &&
            widget.movieStore.movie!.movieAvaliableWatchProviders!.free !=
                null) {
          currentWatchProviders =
              widget.movieStore.movie!.movieAvaliableWatchProviders!.free!;
        } else {
          currentWatchProviders = [];
        }
        break;
    }
    List<Widget> rowWidgets = [
      Column(
        children: [
          if (widget.movieStore.movie!.movieAvaliableWatchProviders!.flatrate !=
                  null &&
              widget.movieStore.movie!.movieAvaliableWatchProviders!.flatrate!
                      .length !=
                  0)
            WatchProviderSelector(
              watchProvider: WatchProviderType.flatrate,
              currentWatchProvider: watchProviderType,
              onTap: () {
                setState(() {
                  watchProviderType = WatchProviderType.flatrate;
                });
              },
              title: AppLocalizations.of(context)!.stream,
            ),
          if (widget.movieStore.movie!.movieAvaliableWatchProviders!.rent !=
                  null &&
              widget.movieStore.movie!.movieAvaliableWatchProviders!.rent!
                      .length !=
                  0)
            WatchProviderSelector(
              watchProvider: WatchProviderType.rent,
              currentWatchProvider: watchProviderType,
              onTap: () {
                setState(() {
                  watchProviderType = WatchProviderType.rent;
                });
              },
              title: AppLocalizations.of(context)!.rent,
            ),
          if (widget.movieStore.movie!.movieAvaliableWatchProviders!.buy !=
                  null &&
              widget.movieStore.movie!.movieAvaliableWatchProviders!.buy!
                      .length !=
                  0)
            WatchProviderSelector(
              watchProvider: WatchProviderType.buy,
              currentWatchProvider: watchProviderType,
              onTap: () {
                setState(() {
                  watchProviderType = WatchProviderType.buy;
                });
              },
              title: AppLocalizations.of(context)!.buy,
            ),
          if (widget.movieStore.movie!.movieAvaliableWatchProviders!.ads !=
                  null &&
              widget.movieStore.movie!.movieAvaliableWatchProviders!.ads!
                      .length !=
                  0)
            WatchProviderSelector(
              watchProvider: WatchProviderType.ads,
              currentWatchProvider: watchProviderType,
              onTap: () {
                setState(() {
                  watchProviderType = WatchProviderType.ads;
                });
              },
              title: AppLocalizations.of(context)!.wAds,
            ),
          if (widget.movieStore.movie!.movieAvaliableWatchProviders!.free !=
                  null &&
              widget.movieStore.movie!.movieAvaliableWatchProviders!.free!
                      .length !=
                  0)
            WatchProviderSelector(
              watchProvider: WatchProviderType.free,
              currentWatchProvider: watchProviderType,
              onTap: () {
                setState(() {
                  watchProviderType = WatchProviderType.free;
                });
              },
              title: AppLocalizations.of(context)!.free,
            ),
        ],
      ),
      SizedBox(
        width: 16,
      ),
      Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: styleStore.primaryColor),
        width: 4,
        height: 320,
      ),
      SizedBox(
        width: 16,
      ),
      Expanded(
        child: Container(
          child: ListView.builder(
              physics: BouncingScrollPhysics(),
              itemCount: currentWatchProviders.length != 0
                  ? currentWatchProviders.length
                  : 1,
              itemBuilder: (context, index) {
                if (currentWatchProviders.length != 0)
                  return InkWell(
                    onDoubleTap: () {
                      launchInBrowser(widget.movieStore.movie!
                          .movieAvaliableWatchProviders!.link);
                    },
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                      margin: EdgeInsets.symmetric(vertical: 8),
                      width: double.infinity,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: styleStore.backgroundColor),
                      child: Row(children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          clipBehavior: Clip.antiAlias,
                          height: 32,
                          child: CachedNetworkImage(
                              imageUrl:
                                  'https://image.tmdb.org/t/p/w154/${currentWatchProviders[index].logoPath}'),
                        ),
                        SizedBox(
                          width: 16,
                        ),
                        Expanded(
                          child: Text(
                            currentWatchProviders[index].providerName,
                            style: GoogleFonts.getFont('Mitr',
                                color: styleStore.textColor,
                                fontSize: 16,
                                fontWeight: FontWeight.w200),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                          ),
                        ),
                      ]),
                    ),
                  );
                return Container();
              }),
        ),
      ),
    ];
    return Column(
      children: [
        Divider(
          color: AppColors.divider,
          thickness: 1,
          endIndent: 24,
          indent: 24,
        ),
        const SizedBox(
          height: 16,
        ),
        Text(
          AppLocalizations.of(context)!.whereToWatch,
          style: GoogleFonts.getFont('Mitr',
              color: styleStore.textColor,
              fontSize: 22,
              fontWeight: FontWeight.w400),
        ),
        const SizedBox(
          height: 16,
        ),
        Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: styleStore.shapeColor),
          width: double.infinity,
          margin: EdgeInsets.all(16),
          padding: EdgeInsets.all(16),
          height: 376,
          child: Row(
              children: styleStore.fabPosition == 0
                  ? rowWidgets
                  : rowWidgets.reversed.toList()),
        ),
        if (widget.movieStore.movie!.allWatchProviders != null)
          TextButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => AllWatchProvidersScreen(
                        watchProvidersData:
                            widget.movieStore.movie!.allWatchProviders!,
                      )));
            },
            child: Text(
              AppLocalizations.of(context)!.viewForAllCountries,
              style: GoogleFonts.getFont('Mitr',
                  color: styleStore.primaryColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w200),
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
            ),
          )
      ],
    );
  }
}

class WatchProviderSelector extends StatelessWidget {
  WatchProviderSelector(
      {required this.currentWatchProvider,
      required this.onTap,
      required this.title,
      required this.watchProvider,
      this.height,
      this.margin,
      this.width,
      this.color});
  final VoidCallback onTap;
  final StyleStore styleStore = GetIt.I<StyleStore>();
  final WatchProviderType currentWatchProvider;
  final String title;
  final WatchProviderType watchProvider;
  final Color? color;
  final double? height;
  final double? width;
  final EdgeInsets? margin;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin ?? EdgeInsets.only(bottom: 16),
      child: InkWell(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: color ?? styleStore.backgroundColor,
              border: currentWatchProvider == watchProvider
                  ? Border.all(color: styleStore.primaryColor!, width: 2)
                  : null),
          height: height ?? 56,
          width: width ?? 120,
          child: Center(
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: GoogleFonts.getFont('Mitr',
                  color: styleStore.textColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w100),
            ),
          ),
        ),
      ),
    );
  }
}
