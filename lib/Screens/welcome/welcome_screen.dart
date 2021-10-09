import 'package:animated_card/animated_card.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wwatch/Screens/home/home_screen.dart';
import 'package:wwatch/Shared/Themes/app_colors.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.background,
      child: SafeArea(
        bottom: false,
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
              Color(0xff282828),
              Color(0xff121212),
            ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
          ),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Container(
                      height: 140,
                      width: 140,
                      child: Hero(
                        tag: "logo",
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(45),
                          child: Image.asset(
                            "assets/icon.png",
                            filterQuality: FilterQuality.medium,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Text(
                  "WELCOME",
                  style: GoogleFonts.getFont('Kodchasan',
                      color: AppColors.text,
                      fontSize: 48,
                      fontWeight: FontWeight.w300),
                ),
                Text(
                  "what are you looking for",
                  style: GoogleFonts.getFont('Kodchasan',
                      color: AppColors.text,
                      fontSize: 24,
                      fontWeight: FontWeight.w300),
                ),
                InkWell(
                  borderRadius: BorderRadius.circular(16),
                  onTap: () {},
                  child: SizedBox(
                    width: 340,
                    child: AnimatedCard(
                      direction: AnimatedCardDirection.left,
                      child: Ink(
                          width: 340,
                          height: 125,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                                colors: [Color(0xff134E5E), Color(0xff71B280)],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 8, horizontal: 16),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Text(
                                  "Movies",
                                  style: GoogleFonts.getFont('Mitr',
                                      color: AppColors.text,
                                      fontSize: 48,
                                      fontWeight: FontWeight.w500),
                                ),
                                Column(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Icon(
                                      Icons.arrow_forward_ios_rounded,
                                      size: 36,
                                      color: AppColors.text,
                                    )
                                  ],
                                ),
                              ],
                            ),
                          )),
                    ),
                  ),
                ),
                InkWell(
                  borderRadius: BorderRadius.circular(16),
                  onTap: () {},
                  child: SizedBox(
                    width: 340,
                    child: AnimatedCard(
                      direction: AnimatedCardDirection.right,
                      child: Ink(
                        width: 340,
                        height: 125,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                              colors: [Color(0xff89216B), Color(0xffCE546D)],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 8, horizontal: 16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Text(
                                "TV Shows",
                                style: GoogleFonts.getFont('Mitr',
                                    color: AppColors.text,
                                    fontSize: 48,
                                    fontWeight: FontWeight.w500),
                              ),
                              Column(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Icon(
                                    Icons.arrow_forward_ios_rounded,
                                    size: 36,
                                    color: AppColors.text,
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                InkWell(
                  borderRadius: BorderRadius.circular(4),
                  onTap: () {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => HomeScreen()));
                  },
                  child: Ink(
                    padding: EdgeInsets.all(4),
                    child: Text(
                      "Just take me to Home Screen",
                      style: GoogleFonts.getFont('Mitr',
                          color: Colors.blue[300],
                          fontSize: 14,
                          fontWeight: FontWeight.w200),
                    ),
                  ),
                ),
                InkWell(
                  borderRadius: BorderRadius.circular(16),
                  onTap: () {
                    //Url launcher to go to MovieDB website
                  },
                  child: SizedBox(
                    width: 256,
                    child: AnimatedCard(
                      duration: Duration(milliseconds: 200),
                      direction: AnimatedCardDirection.bottom,
                      child: Ink(
                        padding: EdgeInsets.symmetric(horizontal: 8),
                        decoration: BoxDecoration(
                          color: Color(0xff1B1B1B),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        height: 64,
                        width: 256,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "POWERED BY",
                              style: GoogleFonts.getFont('Kodchasan',
                                  color: AppColors.text,
                                  fontSize: 24,
                                  fontWeight: FontWeight.w300),
                            ),
                            Container(
                              height: 56,
                              width: 56,
                              child: Image.asset(
                                "assets/images/MovieDB.png",
                                fit: BoxFit.contain,
                                filterQuality: FilterQuality.medium,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
