import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_icons/line_icons.dart';
import 'package:wwatch/Shared/Themes/app_colors.dart';
import 'package:wwatch/stores/movie_store.dart';
import 'package:wwatch/stores/style_store.dart';

class ContentFilter extends StatelessWidget {
  final FocusNode focusNode;
  final MovieStore movieStore;
  ContentFilter({Key? key, required this.focusNode, required this.movieStore})
      : super(key: key);
  final StyleStore styleStore = GetIt.I<StyleStore>();
  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    controller.text = movieStore.searchString;
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: EdgeInsets.symmetric(
              vertical: 8,
              horizontal: 16,
            ),
            decoration: BoxDecoration(
              color: AppColors.shape,
              borderRadius: BorderRadius.circular(4),
            ),
            child: TextField(
              controller: controller,
              onSubmitted: (_) {
                movieStore.search();
              },
              textInputAction: TextInputAction.search,
              onChanged: movieStore.setSearch,
              focusNode: focusNode,
              style: GoogleFonts.getFont('Mitr',
                  color: AppColors.text,
                  fontSize: 16,
                  fontWeight: FontWeight.w100),
              decoration: InputDecoration(
                isDense: true,
                border: InputBorder.none,
                hintText: "Search",
                hintStyle: GoogleFonts.getFont('Mitr',
                    color: AppColors.text,
                    fontSize: 16,
                    fontWeight: FontWeight.w100),
                suffix: GestureDetector(
                  onTap: movieStore.search,
                  child: Icon(
                    LineIcons.search,
                    color: AppColors.text,
                    size: 18,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 8,
          ),
          Observer(
            builder: (_) {
              return Container(
                height: 48,
                decoration: BoxDecoration(
                    color: AppColors.shape,
                    borderRadius: BorderRadius.circular(4)),
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Container(
                        height: 56,
                        child: TextButton(
                          onPressed: () {
                            movieStore.setSelectedContentType(0);
                          },
                          child: Text(
                            "Movies",
                            style: GoogleFonts.getFont('Mitr',
                                color: AppColors.text,
                                fontSize: 16,
                                fontWeight: FontWeight.w100),
                          ),
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                                movieStore.selectedContentType == 0
                                    ? styleStore.primaryColor
                                    : Colors.transparent),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: 1,
                      height: 36,
                      color: AppColors.text,
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(
                        height: 56,
                        child: TextButton(
                          onPressed: () {
                            movieStore.setSelectedContentType(1);
                          },
                          child: Text(
                            "TV Shows",
                            style: GoogleFonts.getFont('Mitr',
                                color: AppColors.text,
                                fontSize: 16,
                                fontWeight: FontWeight.w100),
                          ),
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                                movieStore.selectedContentType == 1
                                    ? styleStore.primaryColor
                                    : Colors.transparent),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
          SizedBox(
            height: 8,
          ),
          Observer(builder: (_) {
            List<String> items = ['Genres', 'Comedy'];
            List<String> items2 = ['Popularity', 'Release Date'];
            if (movieStore.searchString.isEmpty)
              return Row(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                          color: AppColors.shape,
                          borderRadius: BorderRadius.circular(4)),
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: SizedBox(
                        width: 340,
                        child: DropdownButton<String>(
                            dropdownColor: AppColors.background,
                            icon: Icon(
                              Icons.keyboard_arrow_down_outlined,
                              color: AppColors.text,
                            ),
                            isExpanded: true,
                            style: GoogleFonts.getFont('Mitr',
                                color: AppColors.text,
                                fontSize: 16,
                                fontWeight: FontWeight.w100),
                            underline: Container(),
                            value: 'Popularity',
                            onChanged: (text) {},
                            iconSize: 16,
                            elevation: 16,
                            //TODO change this to a variable in a Store
                            items: items2.map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList()),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                          color: AppColors.shape,
                          borderRadius: BorderRadius.circular(4)),
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: SizedBox(
                        width: 340,
                        child: DropdownButton<String>(
                            dropdownColor: AppColors.background,
                            icon: Icon(
                              Icons.keyboard_arrow_down_outlined,
                              color: AppColors.text,
                            ),
                            isExpanded: true,
                            style: GoogleFonts.getFont('Mitr',
                                color: AppColors.text,
                                fontSize: 16,
                                fontWeight: FontWeight.w100),
                            underline: Container(),
                            value: 'Genres',
                            onChanged: (text) {},
                            iconSize: 16,
                            elevation: 16,
                            //TODO change this to a variable in a Store
                            items: items.map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList()),
                      ),
                    ),
                  ),
                ],
              );
            return Container();
          })
        ],
      ),
    );
  }
}
