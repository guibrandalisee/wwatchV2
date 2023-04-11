import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wwatch/Screens/filters_screen/components/filter_widget_base.dart';
import 'package:wwatch/Screens/watch_providers/widgets/watch_providers_widget.dart';
import 'package:wwatch/Shared/Themes/app_colors.dart';
import 'package:wwatch/Shared/models/movie_watch_providers_model.dart';
import 'package:wwatch/stores/movie_store.dart';
import 'package:wwatch/stores/settings_store.dart';
import 'package:wwatch/stores/style_store.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:mobx/mobx.dart';

class WatchProvidersScreen extends StatefulWidget {
  WatchProvidersScreen({
    Key? key,
    required this.movieStore,
  }) : super(key: key);
  final MovieStore movieStore;

  @override
  State<WatchProvidersScreen> createState() => _WatchProvidersScreenState();
}

class _WatchProvidersScreenState extends State<WatchProvidersScreen> {
  @override
  void initState() {
    if (settingsStore.selectedContentType == 0) {
      if (settingsStore.avaliableWatchProvidersMovies.isEmpty) {
        settingsStore.getPossibleWatchProviders(true);
      }
    } else {
      if (settingsStore.avaliableWatchProvidersTvShows.isEmpty) {
        settingsStore.getPossibleWatchProviders(false);
      }
    }
    super.initState();
  }

  final SettingsStore settingsStore = GetIt.I<SettingsStore>();

  final StyleStore styleStore = GetIt.I<StyleStore>();

  @override
  Widget build(BuildContext context) {
    final bool movie = settingsStore.selectedContentType == 0;
    List<AvaliableWatchProvider> watchProviders = [];
    return Scaffold(
      floatingActionButtonLocation: styleStore.fabPosition == 0
          ? FloatingActionButtonLocation.startFloat
          : FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        backgroundColor: styleStore.primaryColor,
        child: Center(
          child: Icon(
            Icons.keyboard_arrow_down_rounded,
            color: AppColors.textOnPrimaries[styleStore.colorIndex!],
          ),
        ),
      ),
      backgroundColor: styleStore.backgroundColor,
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: settingsStore.brightness != CustomBrightness.amoled
              ? AppColors.textOnPrimaries[styleStore.colorIndex!]
              : styleStore.primaryColor,
        ),
        backgroundColor: settingsStore.brightness == CustomBrightness.amoled
            ? styleStore.backgroundColor
            : styleStore.primaryColor,
      ),
      body: Observer(
        builder: (context) {
          if (settingsStore.loadingWatchProviders) {
            return LinearProgressIndicator(
              valueColor: AlwaysStoppedAnimation(
                styleStore.primaryColor,
              ),
              backgroundColor: styleStore.backgroundColor,
            );
          } else {
            if (watchProviders.isEmpty) {
              watchProviders = movie
                  ? settingsStore.avaliableWatchProvidersMovies
                  : settingsStore.avaliableWatchProvidersTvShows;
            }
          }
          return ListView.builder(
              physics: BouncingScrollPhysics(),
              itemCount: movie
                  ? settingsStore.avaliableWatchProvidersMovies.length + 2
                  : settingsStore.avaliableWatchProvidersTvShows.length + 2,
              itemBuilder: (context, index) {
                if (index == 0)
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        height: 80,
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
                        height: 80,
                      ),
                      Container(
                        padding: EdgeInsets.all(8),
                        child: Text(
                          AppLocalizations.of(context)!.wpFilerHeading,
                          style: GoogleFonts.getFont(
                            'Mitr',
                            color: styleStore.textColor,
                            fontSize: 18,
                            fontWeight: FontWeight.w100,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Observer(builder: (context) {
                        return FilterWidgetBase(
                          onChanged: (a) {
                            if (settingsStore.selectedContentType == 0) {
                              settingsStore.setRememberSelectedWatchPMovies(a);
                            } else {
                              settingsStore.setRememberSelectedWatchPTVShows(a);
                            }
                          },
                          title:
                              "${AppLocalizations.of(context)!.rememberSelected}" +
                                  (settingsStore.selectedContentType == 0
                                      ? AppLocalizations.of(context)!.movies
                                      : AppLocalizations.of(context)!.tvShows),
                          value: settingsStore.selectedContentType == 0
                              ? settingsStore.rememberSelectedWatchPMovies
                              : settingsStore.rememberSelectedWatchPTVShows,
                          shapeColor: true,
                        );
                      }),
                      SizedBox(
                        height: 32,
                      ),
                      Observer(builder: (context) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 8),
                          child: SizedBox(
                            height: 48,
                            child: ElevatedButton(
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.resolveWith<Color>(
                                    (Set<MaterialState> states) {
                                      if (states
                                          .contains(MaterialState.disabled))
                                        return styleStore.shapeColor!
                                            .withAlpha(100);
                                      return styleStore.primaryColor!;
                                    },
                                  ),
                                ),
                                onPressed: (settingsStore.selectedContentType ==
                                                0 &&
                                            settingsStore
                                                .selectedWatchProvidersMovies
                                                .isNotEmpty) ||
                                        settingsStore.selectedContentType ==
                                                1 &&
                                            settingsStore
                                                .selectedWatchProvidersTVShows
                                                .isNotEmpty
                                    ? () {
                                        if (settingsStore.selectedContentType ==
                                            0) {
                                          settingsStore
                                                  .selectedWatchProvidersMovies =
                                              ObservableList();
                                          widget.movieStore.didChange = true;
                                        } else {
                                          settingsStore
                                                  .selectedWatchProvidersTVShows =
                                              ObservableList();
                                          widget.movieStore.didChange = true;
                                        }
                                      }
                                    : null,
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.remove_from_queue_rounded,
                                      color: (settingsStore
                                                          .selectedContentType ==
                                                      0 &&
                                                  settingsStore
                                                      .selectedWatchProvidersMovies
                                                      .isNotEmpty) ||
                                              (settingsStore
                                                          .selectedContentType ==
                                                      1 &&
                                                  settingsStore
                                                      .selectedWatchProvidersTVShows
                                                      .isNotEmpty)
                                          ? AppColors.textOnPrimaries[
                                              styleStore.colorIndex!]
                                          : styleStore.textColor,
                                    ),
                                    SizedBox(
                                      width: 16,
                                    ),
                                    Text(
                                      "Clear selections",
                                      style: GoogleFonts.getFont(
                                        'Mitr',
                                        color: (settingsStore
                                                            .selectedContentType ==
                                                        0 &&
                                                    settingsStore
                                                        .selectedWatchProvidersMovies
                                                        .isNotEmpty) ||
                                                (settingsStore
                                                            .selectedContentType ==
                                                        1 &&
                                                    settingsStore
                                                        .selectedWatchProvidersTVShows
                                                        .isNotEmpty)
                                            ? AppColors.textOnPrimaries[
                                                styleStore.colorIndex!]
                                            : styleStore.textColor,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w100,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                )),
                          ),
                        );
                      }),
                    ],
                  );

                //*Shape at bottom---------------------------------------------------------------
                if (index ==
                    (movie
                        ? settingsStore.avaliableWatchProvidersMovies.length + 1
                        : settingsStore.avaliableWatchProvidersTvShows.length +
                            1))
                  return Container(
                    height: 96,
                    child: Center(
                      child: Stack(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                height: 16,
                                width: 16,
                                margin: EdgeInsets.symmetric(
                                  horizontal: 8,
                                ),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: styleStore.primaryColor),
                              ),
                              Container(
                                height: 16,
                                width: 16,
                                margin: EdgeInsets.symmetric(
                                  horizontal: 8,
                                ),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: styleStore.primaryColor),
                              ),
                              Container(
                                height: 16,
                                width: 16,
                                margin: EdgeInsets.symmetric(
                                  horizontal: 8,
                                ),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: styleStore.primaryColor),
                              ),
                            ],
                          ),
                          Positioned(
                            top: 6,
                            left: MediaQuery.of(context).size.width / 2 - 48,
                            child: Container(
                              height: 4,
                              width: 76,
                              margin: EdgeInsets.symmetric(
                                horizontal: 8,
                              ),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: styleStore.primaryColor),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
//*-----------------------------------------------------------------------------------------------
                return WatchProvidersWidget(
                  index: index - 1,
                  onTap: () {
                    widget.movieStore.didChange = true;
                    if (settingsStore.selectedContentType == 0) {
                      if (!settingsStore.selectedWatchProvidersMovies
                          .contains(watchProviders[index - 1].providerId)) {
                        settingsStore.selectedWatchProvidersMovies
                            .add(watchProviders[index - 1].providerId);
                        widget.movieStore.didChange = true;
                      } else {
                        settingsStore.selectedWatchProvidersMovies
                            .remove(watchProviders[index - 1].providerId);
                        widget.movieStore.didChange = true;
                      }
                    } else {
                      widget.movieStore.didChange = true;
                      if (!settingsStore.selectedWatchProvidersTVShows
                          .contains(watchProviders[index - 1].providerId)) {
                        settingsStore.selectedWatchProvidersTVShows
                            .add(watchProviders[index - 1].providerId);
                        widget.movieStore.didChange = true;
                      } else {
                        settingsStore.selectedWatchProvidersTVShows
                            .remove(watchProviders[index - 1].providerId);
                        widget.movieStore.didChange = true;
                      }
                    }
                  },
                  onTap2: (s) {
                    if (settingsStore.selectedContentType == 0) {
                      if (!settingsStore.selectedWatchProvidersMovies
                          .contains(watchProviders[index - 1].providerId)) {
                        settingsStore.selectedWatchProvidersMovies
                            .add(watchProviders[index - 1].providerId);
                      } else {
                        settingsStore.selectedWatchProvidersMovies
                            .remove(watchProviders[index - 1].providerId);
                      }
                    } else {
                      if (!settingsStore.selectedWatchProvidersTVShows
                          .contains(watchProviders[index - 1].providerId)) {
                        settingsStore.selectedWatchProvidersTVShows
                            .add(watchProviders[index - 1].providerId);
                      } else {
                        settingsStore.selectedWatchProvidersTVShows
                            .remove(watchProviders[index - 1].providerId);
                      }
                    }
                  },
                );
              });
        },
      ),
    );
  }
}
