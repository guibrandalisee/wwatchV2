import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:wwatch/Screens/movie/widgets/watch_providers_widget.dart';
import 'package:wwatch/Shared/Themes/app_colors.dart';
import 'package:wwatch/Shared/models/movie_watch_providers_model.dart';
import 'package:wwatch/main.dart';
import 'package:wwatch/stores/movie_store.dart';
import 'package:wwatch/stores/settings_store.dart';
import 'package:wwatch/stores/style_store.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AllWatchProvidersScreen extends StatefulWidget {
  AllWatchProvidersScreen({
    Key? key,
    required this.watchProvidersData,
  }) : super(key: key);
  final Map<String, dynamic> watchProvidersData;

  @override
  State<AllWatchProvidersScreen> createState() =>
      _AllWatchProvidersScreenState();
}

class _AllWatchProvidersScreenState extends State<AllWatchProvidersScreen> {
  final StyleStore styleStore = GetIt.I<StyleStore>();

  final SettingsStore settingsStore = GetIt.I<SettingsStore>();
  final MovieStore movieStore = MovieStore();
  WatchProviderType currentWatchProvider = WatchProviderType.flatrate;
  @override
  void initState() {
    movieStore.getAllCountriesWatchProviders(widget.watchProvidersData);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<Country> currentWatchProviderCountries =
        switchWP(currentWatchProvider, movieStore);
    return Scaffold(
      backgroundColor: styleStore.backgroundColor,
      appBar: AppBar(
        title: SizedBox(
          height: 56,
          child: Image(
            image: ResizeImage(
                AssetImage(
                  'assets/images/WWatch2-png.png',
                ),
                height: 156,
                width: 156),
            filterQuality: FilterQuality.medium,
            color: settingsStore.brightness != CustomBrightness.amoled
                ? AppColors.textOnPrimaries[styleStore.colorIndex!]
                : styleStore.primaryColor,
          ),
        ),
        iconTheme: IconThemeData(
          color: settingsStore.brightness != CustomBrightness.amoled
              ? AppColors.textOnPrimaries[styleStore.colorIndex!]
              : styleStore.primaryColor,
        ),
        backgroundColor: settingsStore.brightness == CustomBrightness.amoled
            ? styleStore.backgroundColor
            : styleStore.primaryColor,
      ),
      body: Stack(
        children: [
          ListView.builder(
            physics: BouncingScrollPhysics(),
            itemCount: currentWatchProviderCountries.length + 2,
            itemBuilder: (conext, index) {
              if (index == 0) {
                return Column(
                  children: [
                    SizedBox(
                      height: 80,
                      width: double.infinity,
                    ),
                    Hero(
                      tag: 'logoImage',
                      child: Container(
                        decoration: BoxDecoration(boxShadow: [
                          BoxShadow(
                            color: Colors.black.withAlpha(50),
                            blurRadius: 32,
                            spreadRadius: 0,
                          )
                        ]),
                        height: 140,
                        child: Image(
                          image: ResizeImage(
                              AssetImage(
                                'assets/images/WWatch2-png.png',
                              ),
                              height: 420,
                              width: 420),
                          filterQuality: FilterQuality.medium,
                          color: settingsStore.brightness !=
                                  CustomBrightness.amoled
                              ? styleStore.textColor
                              : styleStore.primaryColor,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 65,
                    ),
                  ],
                );
              }
              if (index == currentWatchProviderCountries.length + 1)
                return SizedBox(
                  height: 200,
                );
              if (currentWatchProviderCountries[index - 1].name.isNotEmpty)
                return Container(
                  padding: EdgeInsets.symmetric(vertical: 4),
                  child: Container(
                    child: ExpansionTile(
                      childrenPadding: EdgeInsets.only(bottom: 8),
                      title:
                          Text(currentWatchProviderCountries[index - 1].name),
                      collapsedBackgroundColor: styleStore.shapeColor,
                      backgroundColor: styleStore.shapeColor,
                      textColor: styleStore.textColor,
                      collapsedTextColor: styleStore.textColor,
                      iconColor: styleStore.primaryColor,
                      collapsedIconColor: styleStore.textColor,
                      initiallyExpanded: true,
                      children: widget.watchProvidersData[
                              currentWatchProviderCountries[index - 1]
                                  // ignore: sdk_version_since
                                  .iso_3166_1][currentWatchProvider.name]
                          .map<Widget>((e) {
                        return InkWell(
                          onDoubleTap: () {
                            launchInBrowser(widget.watchProvidersData[
                                currentWatchProviderCountries[index - 1]
                                    .iso_3166_1]['link']);
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 8, horizontal: 16),
                            margin: EdgeInsets.symmetric(
                                vertical: 4, horizontal: 8),
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
                                        'https://image.tmdb.org/t/p/w154/${e['logo_path']}'),
                              ),
                              SizedBox(
                                width: 16,
                              ),
                              Expanded(
                                child: Text(
                                  e['provider_name'],
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
                      }).toList(),
                    ),
                  ),
                );

              return Container();
            },
          ),
          Positioned(
              bottom: 0,
              right: 0,
              child: Container(
                decoration: BoxDecoration(
                  color: styleStore.shapeColor!.withOpacity(0.9),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16),
                  ),
                ),
                padding: EdgeInsets.all(8),
                width: MediaQuery.of(context).size.width,
                child: SafeArea(
                  child: Wrap(
                    alignment: WrapAlignment.center,
                    children: [
                      WatchProviderSelector(
                          margin: EdgeInsets.all(8),
                          width: 100,
                          currentWatchProvider: currentWatchProvider,
                          onTap: () {
                            setState(() {
                              currentWatchProvider = WatchProviderType.flatrate;
                            });
                          },
                          title: AppLocalizations.of(context)!.stream,
                          watchProvider: WatchProviderType.flatrate),
                      WatchProviderSelector(
                          width: 100,
                          margin: EdgeInsets.all(8),
                          currentWatchProvider: currentWatchProvider,
                          onTap: () {
                            setState(() {
                              currentWatchProvider = WatchProviderType.buy;
                            });
                          },
                          title: AppLocalizations.of(context)!.buy,
                          watchProvider: WatchProviderType.buy),
                      WatchProviderSelector(
                          width: 100,
                          margin: EdgeInsets.all(8),
                          currentWatchProvider: currentWatchProvider,
                          onTap: () {
                            setState(() {
                              currentWatchProvider = WatchProviderType.rent;
                            });
                          },
                          title: AppLocalizations.of(context)!.rent,
                          watchProvider: WatchProviderType.rent),
                      WatchProviderSelector(
                          width: 100,
                          margin: EdgeInsets.all(8),
                          currentWatchProvider: currentWatchProvider,
                          onTap: () {
                            setState(() {
                              currentWatchProvider = WatchProviderType.ads;
                            });
                          },
                          title: AppLocalizations.of(context)!.wAds,
                          watchProvider: WatchProviderType.ads),
                      WatchProviderSelector(
                          width: 100,
                          margin: EdgeInsets.all(8),
                          currentWatchProvider: currentWatchProvider,
                          onTap: () {
                            setState(() {
                              currentWatchProvider = WatchProviderType.free;
                            });
                          },
                          title: AppLocalizations.of(context)!.free,
                          watchProvider: WatchProviderType.free)
                    ],
                  ),
                ),
              )),
        ],
      ),
    );
  }
}

List<Country> switchWP(WatchProviderType wP, MovieStore movieStore) {
  switch (wP) {
    case WatchProviderType.flatrate:
      return movieStore.allCountriesWatchProviders!.flatrate;
    case WatchProviderType.buy:
      return movieStore.allCountriesWatchProviders!.buy;
    case WatchProviderType.rent:
      return movieStore.allCountriesWatchProviders!.rent;
    case WatchProviderType.ads:
      return movieStore.allCountriesWatchProviders!.ads;
    case WatchProviderType.free:
      return movieStore.allCountriesWatchProviders!.free;
  }
}
