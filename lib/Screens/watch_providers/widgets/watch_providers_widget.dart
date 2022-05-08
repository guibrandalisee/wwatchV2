import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:wwatch/Shared/Themes/app_colors.dart';
import 'package:wwatch/stores/settings_store.dart';
import 'package:wwatch/stores/style_store.dart';

class WatchProvidersWidget extends StatelessWidget {
  WatchProvidersWidget({
    Key? key,
    required this.index,
    required this.onTap,
    required this.onTap2,
  }) : super(key: key);
  final int index;
  final StyleStore styleStore = GetIt.I<StyleStore>();
  final SettingsStore settingsStore = GetIt.I<SettingsStore>();
  final VoidCallback onTap;
  final void Function(bool?) onTap2;
  @override
  Widget build(BuildContext context) {
    return Observer(builder: (context) {
      return Column(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
            child: InkWell(
              borderRadius: BorderRadius.circular(5),
              onTap: onTap,
              child: Ink(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: styleStore.shapeColor,
                ),
                padding: const EdgeInsets.all(12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          clipBehavior: Clip.antiAlias,
                          height: 32,
                          child: CachedNetworkImage(
                              imageUrl:
                                  'https://image.tmdb.org/t/p/w154/${settingsStore.avaliableWatchProviders[index].logoPath}'),
                        ),
                        SizedBox(
                          width: 16,
                        ),
                        Text(
                          settingsStore
                              .avaliableWatchProviders[index].providerName,
                          style: GoogleFonts.getFont('Mitr',
                              color: styleStore.textColor,
                              fontSize: 16,
                              fontWeight: FontWeight.w200),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                      ],
                    ),
                    if (settingsStore.selectedContentType == 0)
                      Checkbox(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                          activeColor: styleStore.primaryColor,
                          checkColor:
                              AppColors.textOnPrimaries[styleStore.colorIndex!],
                          fillColor: settingsStore.selectedWatchProvidersMovies
                                  .contains(settingsStore
                                      .avaliableWatchProviders[index]
                                      .providerId)
                              ? null
                              : MaterialStateProperty.all(styleStore.textColor),
                          value: settingsStore.selectedWatchProvidersMovies
                              .contains(settingsStore
                                  .avaliableWatchProviders[index].providerId),
                          onChanged: onTap2)
                    else if (settingsStore.selectedContentType == 1)
                      Checkbox(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                          activeColor: styleStore.primaryColor,
                          checkColor:
                              AppColors.textOnPrimaries[styleStore.colorIndex!],
                          fillColor: settingsStore.selectedWatchProvidersTVShows
                                  .contains(settingsStore
                                      .avaliableWatchProviders[index]
                                      .providerId)
                              ? null
                              : MaterialStateProperty.all(styleStore.textColor),
                          value: settingsStore.selectedWatchProvidersTVShows
                              .contains(settingsStore
                                  .avaliableWatchProviders[index].providerId),
                          onChanged: onTap2)
                  ],
                ),
              ),
            ),
          ),
        ],
      );
    });
  }
}
