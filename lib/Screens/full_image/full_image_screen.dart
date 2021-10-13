import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:pinch_zoom_image_last/pinch_zoom_image_last.dart';
import 'package:wwatch/Shared/Themes/app_colors.dart';
import 'package:wwatch/stores/style_store.dart';

class FullImageScreen extends StatelessWidget {
  final String? imgPath;

  final StyleStore styleStore = GetIt.I<StyleStore>();

  FullImageScreen({Key? key, this.imgPath}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: styleStore.primaryColor,
        iconTheme: IconThemeData(color: AppColors.logo),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Center(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: PinchZoomImage(
                  image: CachedNetworkImage(
                    imageUrl: 'https://image.tmdb.org/t/p/original${imgPath!}',
                  ),
                )),
          ),
        ),
      ),
    );
  }
}
