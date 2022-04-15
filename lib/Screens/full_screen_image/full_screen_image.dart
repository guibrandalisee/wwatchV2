import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:photo_view/photo_view.dart';
import 'package:wwatch/Shared/Themes/app_colors.dart';
import 'package:wwatch/stores/settings_store.dart';
import 'package:wwatch/stores/style_store.dart';

class FullScreenImage extends StatelessWidget {
  FullScreenImage({
    Key? key,
    required this.path,
  }) : super(key: key);
  final String path;
  final StyleStore styleStore = GetIt.I<StyleStore>();
  final SettingsStore settingsStore = GetIt.I<SettingsStore>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        title: Hero(
          tag: "logo",
          child: SizedBox(
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
        ),
        actions: [],
      ),
      body: Container(
        child: PhotoView(
          minScale: PhotoViewComputedScale.contained,
          maxScale: PhotoViewComputedScale.contained * 100,
          loadingBuilder: (_, imageChunkEvent) {
            return Center(
              child: (imageChunkEvent != null &&
                      imageChunkEvent.expectedTotalBytes != null)
                  ? CircularProgressIndicator(
                      color: styleStore.primaryColor,
                      value: imageChunkEvent.cumulativeBytesLoaded /
                          imageChunkEvent.expectedTotalBytes!,
                    )
                  : CircularProgressIndicator(
                      color: styleStore.primaryColor,
                    ),
            );
          },
          imageProvider: NetworkImage(path),
        ),
      ),
    );
  }
}
