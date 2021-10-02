import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_icons/line_icons.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

import 'package:wwatch/Shared/Themes/app_colors.dart';
import 'package:wwatch/Shared/models/movie_model.dart';

class TrailersWidget extends StatefulWidget {
  final CompleteMovie movie;
  TrailersWidget({
    Key? key,
    required this.movie,
  }) : super(key: key);

  @override
  State<TrailersWidget> createState() => _TrailersWidgetState();
}

class _TrailersWidgetState extends State<TrailersWidget> {
  CarouselController carouselController = CarouselController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 16,
        ),
        Divider(
          color: AppColors.divider,
          thickness: 1,
          endIndent: 24,
          indent: 24,
        ),
        SizedBox(
          height: 16,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                splashRadius: 20,
                onPressed: () {
                  carouselController.previousPage();
                },
                icon: Icon(LineIcons.arrowLeft, color: Colors.white),
              ),
              Text(
                'Movie Trailers',
                style: GoogleFonts.getFont('Mitr',
                    color: AppColors.text,
                    fontSize: 22,
                    fontWeight: FontWeight.w400),
              ),
              IconButton(
                splashRadius: 20,
                onPressed: () {
                  carouselController.nextPage();
                },
                icon: Icon(LineIcons.arrowRight, color: Colors.white),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 16,
        ),
        CarouselSlider.builder(
            carouselController: carouselController,
            itemCount: widget.movie.videos?.length,
            itemBuilder: (context, index, realIdx) {
              YoutubePlayerController _controller = YoutubePlayerController(
                initialVideoId: widget.movie.videos![index].key,
                params: YoutubePlayerParams(
                  showControls: true,
                  showFullscreenButton: true,
                ),
              );
              return YoutubePlayerIFrame(
                controller: _controller,
              );
            },
            options: CarouselOptions(
                scrollPhysics: NeverScrollableScrollPhysics(),
                enableInfiniteScroll: false,
                scrollDirection: Axis.horizontal,
                aspectRatio: 16 / 9,
                autoPlay: false,
                enlargeCenterPage: true))
      ],
    );
  }
}
