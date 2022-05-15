import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:wwatch/Shared/Themes/app_colors.dart';
import 'package:wwatch/Shared/models/movie_watch_providers_model.dart';
import 'package:wwatch/main.dart';
import 'package:wwatch/stores/movie_store.dart';
import 'package:wwatch/stores/settings_store.dart';
import 'package:wwatch/stores/style_store.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

enum WatchProviderType { flatrate, buy, rent, ads, free }

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
          'Watch Providers',
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
            children: [
              Column(
                children: [
                  InkWell(
                    onTap: () {
                      setState(() {
                        watchProviderType = WatchProviderType.flatrate;
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: styleStore.backgroundColor,
                          border:
                              watchProviderType == WatchProviderType.flatrate
                                  ? Border.all(
                                      color: styleStore.primaryColor!, width: 2)
                                  : null),
                      height: 56,
                      width: 120,
                      child: Center(
                        child: Text(
                          'Stream',
                          style: GoogleFonts.getFont('Mitr',
                              color: styleStore.textColor,
                              fontSize: 16,
                              fontWeight: FontWeight.w100),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        watchProviderType = WatchProviderType.rent;
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: styleStore.backgroundColor,
                          border: watchProviderType == WatchProviderType.rent
                              ? Border.all(
                                  color: styleStore.primaryColor!, width: 2)
                              : null),
                      height: 56,
                      width: 120,
                      child: Center(
                        child: Text(
                          'Rent',
                          style: GoogleFonts.getFont('Mitr',
                              color: styleStore.textColor,
                              fontSize: 16,
                              fontWeight: FontWeight.w100),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        watchProviderType = WatchProviderType.buy;
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: styleStore.backgroundColor,
                          border: watchProviderType == WatchProviderType.buy
                              ? Border.all(
                                  color: styleStore.primaryColor!, width: 2)
                              : null),
                      height: 56,
                      width: 120,
                      child: Center(
                        child: Text(
                          'Buy',
                          style: GoogleFonts.getFont('Mitr',
                              color: styleStore.textColor,
                              fontSize: 16,
                              fontWeight: FontWeight.w100),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        watchProviderType = WatchProviderType.ads;
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: styleStore.backgroundColor,
                          border: watchProviderType == WatchProviderType.ads
                              ? Border.all(
                                  color: styleStore.primaryColor!, width: 2)
                              : null),
                      height: 56,
                      width: 120,
                      child: Center(
                        child: Text(
                          'With Ads',
                          style: GoogleFonts.getFont('Mitr',
                              color: styleStore.textColor,
                              fontSize: 16,
                              fontWeight: FontWeight.w100),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        watchProviderType = WatchProviderType.free;
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: styleStore.backgroundColor,
                          border: watchProviderType == WatchProviderType.free
                              ? Border.all(
                                  color: styleStore.primaryColor!, width: 2)
                              : null),
                      height: 56,
                      width: 120,
                      child: Center(
                        child: Text(
                          'Free',
                          style: GoogleFonts.getFont('Mitr',
                              color: styleStore.textColor,
                              fontSize: 16,
                              fontWeight: FontWeight.w100),
                        ),
                      ),
                    ),
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
                              padding: EdgeInsets.symmetric(
                                  vertical: 8, horizontal: 16),
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
                        return Center(
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 16),
                            child: Text(
                              'No Services Avaliable for the selected country',
                              style: GoogleFonts.getFont('Mitr',
                                  color: styleStore.textColor,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w200),
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.center,
                              maxLines: 6,
                            ),
                          ),
                        );
                      }),
                ),
              ),
            ],
          ),
        ),
        //TODO make a screen to see in which country the movie can be watched on
        //similiar to https://unogs.com/
        TextButton(
          onPressed: () {},
          child: Text(
            'View For All Countries',
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
