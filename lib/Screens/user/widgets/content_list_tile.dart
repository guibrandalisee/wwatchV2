import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_icons/line_icons.dart';
import 'package:wwatch/stores/style_store.dart';

class ContentListTile extends StatelessWidget {
  ContentListTile(
      {Key? key, required this.title, required this.icon, required this.onTap})
      : super(key: key);
  final StyleStore styleStore = GetIt.I<StyleStore>();
  final String title;
  final IconData icon;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: styleStore.shapeColor,
      ),
      padding: EdgeInsets.all(8),
      height: 60,
      child: InkWell(
        onTap: onTap,
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  SizedBox(
                    width: 8,
                  ),
                  Icon(
                    icon,
                    color: styleStore.primaryColor,
                    size: 32,
                  ),
                  SizedBox(
                    width: 16,
                  ),
                  Text(
                    title,
                    style: GoogleFonts.mitr(
                        color: styleStore.textColor,
                        fontSize: 20,
                        fontWeight: FontWeight.w200),
                  ),
                ],
              ),
              Icon(
                LineIcons.angleRight,
                color: styleStore.textColor,
                size: 28,
              )
            ],
          ),
        ),
      ),
    );
  }
}
