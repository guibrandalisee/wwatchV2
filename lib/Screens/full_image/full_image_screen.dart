import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wwatch/Shared/Themes/app_colors.dart';
import 'package:wwatch/Shared/models/movie_images_model.dart';
import 'package:wwatch/stores/style_store.dart';

class FullImageScreen extends StatefulWidget {
  final String? imgPath;
  final List<MovieImage>? imgs;
  final int? posterIndex;

  FullImageScreen({
    Key? key,
    this.imgPath,
    this.imgs,
    this.posterIndex,
  }) : super(key: key);

  @override
  State<FullImageScreen> createState() =>
      _FullImageScreenState(posterIndex ?? 0);
}

class _FullImageScreenState extends State<FullImageScreen> {
  final int index2;
  final StyleStore styleStore = GetIt.I<StyleStore>();
  int? indexAux;

  _FullImageScreenState(this.index2) {
    indexAux = index2 + 1;
  }

  @override
  Widget build(BuildContext context) {
    if (widget.imgPath != null)
      return Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppBar(
          backgroundColor: styleStore.primaryColor,
          iconTheme: IconThemeData(color: AppColors.logo),
        ),
        body: Padding(
          padding: EdgeInsets.all(16),
          child: Center(
            child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                ),
                clipBehavior: Clip.antiAlias,
                child: CachedNetworkImage(
                  imageUrl: widget.imgPath!,
                )),
          ),
        ),
      );
    else if (widget.imgs != null)
      return Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppBar(
          backgroundColor: styleStore.primaryColor,
          iconTheme: IconThemeData(color: AppColors.logo),
        ),
        body: Center(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: Container(
                    alignment: Alignment.center,
                    height: 30,
                    width: 80,
                    decoration: BoxDecoration(
                      color: AppColors.shape,
                      borderRadius: BorderRadius.circular(32),
                      border:
                          Border.all(color: styleStore.primaryColor!, width: 2),
                    ),
                    child: Text(
                      '$indexAux / ${widget.imgs!.length}',
                      style: GoogleFonts.getFont('Kodchasan',
                          color: AppColors.text,
                          fontSize: 12,
                          fontWeight: FontWeight.w300),
                    )),
              ),
              Container(
                child: CarouselSlider.builder(
                  itemCount: widget.imgs!.length,
                  itemBuilder: (context, index, realIdx) {
                    return ClipRRect(
                        borderRadius: BorderRadius.circular(0),
                        child: CachedNetworkImage(
                          imageUrl:
                              'https://image.tmdb.org/t/p/w500${widget.imgs![index].filePath}',
                          fit: BoxFit.cover,
                          filterQuality: FilterQuality.medium,
                        ));
                  },
                  options: CarouselOptions(
                      initialPage: widget.posterIndex!,
                      scrollPhysics: BouncingScrollPhysics(),
                      enableInfiniteScroll: false,
                      scrollDirection: Axis.horizontal,
                      aspectRatio: 9 / 16,
                      autoPlay: false,
                      enlargeCenterPage: false,
                      viewportFraction: 1,
                      onPageChanged: (index, _) {
                        setState(() {
                          indexAux = index + 1;
                        });
                      }),
                ),
              ),
            ],
          ),
        ),
      );
    else
      return Container();
  }
}
