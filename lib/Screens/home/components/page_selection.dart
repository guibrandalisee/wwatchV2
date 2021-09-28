import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wwatch/Shared/Themes/app_colors.dart';

class PageSelection extends StatelessWidget {
  const PageSelection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 16,
        ),
        Center(
          child: InkWell(
            borderRadius: BorderRadius.circular(16),
            onTap: () {},
            child: SizedBox(
              width: 340,
              child: Ink(
                  width: 340,
                  height: 75,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                        colors: [Color(0xff134E5E), Color(0xff71B280)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Text(
                          "Movies",
                          style: GoogleFonts.getFont('Mitr',
                              color: AppColors.text,
                              fontSize: 36,
                              fontWeight: FontWeight.w500),
                        ),
                        Icon(
                          Icons.arrow_forward_ios_rounded,
                          size: 36,
                          color: AppColors.text,
                        ),
                      ],
                    ),
                  )),
            ),
          ),
        ),
        SizedBox(
          height: 16,
        ),
        Center(
          child: InkWell(
            borderRadius: BorderRadius.circular(16),
            onTap: () {},
            child: SizedBox(
              width: 340,
              child: Ink(
                width: 340,
                height: 75,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: [Color(0xff89216B), Color(0xffCE546D)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Text(
                        "TV Shows",
                        style: GoogleFonts.getFont('Mitr',
                            color: AppColors.text,
                            fontSize: 36,
                            fontWeight: FontWeight.w500),
                      ),
                      Icon(
                        Icons.arrow_forward_ios_rounded,
                        size: 36,
                        color: AppColors.text,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
