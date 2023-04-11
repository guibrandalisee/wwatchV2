import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wwatch/Shared/Themes/app_colors.dart';
import 'package:wwatch/main.dart';
import 'package:wwatch/stores/settings_store.dart';
import 'package:wwatch/stores/style_store.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final StyleStore styleStore = GetIt.I<StyleStore>();
    final SettingsStore settingsStore = GetIt.I<SettingsStore>();
    return Scaffold(
      backgroundColor: styleStore.backgroundColor,
      body: CustomScrollView(physics: BouncingScrollPhysics(), slivers: [
        SliverAppBar(
            leading: Container(
              decoration: BoxDecoration(
                  color: settingsStore.brightness == CustomBrightness.amoled
                      ? styleStore.backgroundColor
                      : styleStore.primaryColor,
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(16),
                  )),
              child: IconButton(
                color: settingsStore.brightness != CustomBrightness.amoled
                    ? AppColors.textOnPrimaries[styleStore.colorIndex!]
                    : styleStore.primaryColor,
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
            backgroundColor: settingsStore.brightness == CustomBrightness.amoled
                ? styleStore.backgroundColor
                : styleStore.primaryColor,
            expandedHeight: 256,
            pinned: true,
            flexibleSpace: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                bool _collapsed = constraints.biggest.height ==
                    MediaQuery.of(context).padding.top + kToolbarHeight;
                return FlexibleSpaceBar(
                  expandedTitleScale: 2,
                  background: Container(color: styleStore.backgroundColor),
                  centerTitle: true,
                  title: Text(
                    AppLocalizations.of(context)!.about.toUpperCase(),
                    textAlign: TextAlign.center,
                    style: GoogleFonts.getFont('Mitr',
                        color: _collapsed
                            ? settingsStore.brightness !=
                                    CustomBrightness.amoled
                                ? AppColors
                                    .textOnPrimaries[styleStore.colorIndex!]
                                : styleStore.primaryColor
                            : styleStore.textColor,
                        fontWeight: FontWeight.w300,
                        height: 1),
                  ),
                );
              },
            )),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                SizedBox(
                  height: 32,
                ),
                SizedBox(
                  width: double.infinity,
                  child: Text(
                    AppLocalizations.of(context)!.madeBy,
                    style: GoogleFonts.getFont('Mitr',
                        color: styleStore.textColor,
                        fontSize: 18,
                        fontWeight: FontWeight.w300),
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                Container(
                  decoration: BoxDecoration(
                      color: styleStore.shapeColor,
                      borderRadius: BorderRadius.circular(16)),
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  height: 96,
                  child: Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: styleStore.primaryColor,
                        radius: 36,
                        child: Image.asset(
                          "assets/images/me.png",
                          filterQuality: FilterQuality.medium,
                          cacheHeight: 200,
                          cacheWidth: 200,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Guilherme Brandalise",
                              style: GoogleFonts.getFont('Mitr',
                                  color: styleStore.textColor,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w300),
                            ),
                            const SizedBox(
                              height: 4,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              height: 28,
                              width: 72,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 4, vertical: 4),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        launchInBrowser(
                                            "https://github.com/guibrandalisee");
                                      },
                                      child: Ink(
                                        child: Image.asset(
                                          "assets/images/GitHubLogo.png",
                                          filterQuality: FilterQuality.medium,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      width: 2,
                                      height: 18,
                                      color: styleStore.textColor,
                                    ),
                                    InkWell(
                                      onTap: () {
                                        launchInBrowser(
                                            "https://www.linkedin.com/in/guibrandalisee/");
                                      },
                                      child: Ink(
                                        child: Image.asset(
                                          "assets/images/LinkedInLogo.png",
                                          filterQuality: FilterQuality.medium,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                // const SizedBox(
                //   height: 16,
                // ),

                // Container(
                //   decoration: BoxDecoration(
                //       color: styleStore.shapeColor,
                //       borderRadius: BorderRadius.circular(16)),
                //   padding: const EdgeInsets.symmetric(horizontal: 16),
                //   height: 96,
                //   child: Row(
                //     children: [
                //       Container(
                //         width: 120,
                //         decoration: BoxDecoration(
                //           boxShadow: [
                //             if (settingsStore.brightness ==
                //                 CustomBrightness.light)
                //               BoxShadow(
                //                 color: Colors.black.withOpacity(0.4),
                //               ),
                //           ],
                //           borderRadius: BorderRadius.circular(16),
                //         ),
                //         child: Image.asset(
                //           "assets/images/logo.png",
                //           fit: BoxFit.contain,
                //           filterQuality: FilterQuality.medium,
                //           cacheHeight: 90,
                //           cacheWidth: 240,
                //         ),
                //       ),
                //       Padding(
                //         padding: const EdgeInsets.symmetric(
                //             horizontal: 8, vertical: 16),
                //         child: Column(
                //           crossAxisAlignment: CrossAxisAlignment.start,
                //           children: [
                //             Text(
                //               "G22 Technologies",
                //               style: GoogleFonts.getFont('Mitr',
                //                   color: styleStore.textColor,
                //                   fontSize: 18,
                //                   fontWeight: FontWeight.w300),
                //             ),
                //             const SizedBox(
                //               height: 4,
                //             ),
                //             Container(
                //               decoration: BoxDecoration(
                //                 color: Colors.white,
                //                 borderRadius: BorderRadius.circular(8),
                //               ),
                //               height: 28,
                //               width: 56,
                //               child: Image.asset(
                //                 "assets/images/GooglePlayLogo.png",
                //                 fit: BoxFit.contain,
                //                 filterQuality: FilterQuality.medium,
                //                 cacheHeight: 84,
                //                 cacheWidth: 168,
                //               ),
                //             ),
                //           ],
                //         ),
                //       )
                //     ],
                //   ),
                // ),
                // const SizedBox(
                //   height: 32,
                // ),
                // SizedBox(
                //   width: double.infinity,
                //   child: Text(
                //     AppLocalizations.of(context)!.buyCoffe,
                //     style: GoogleFonts.getFont('Mitr',
                //         color: styleStore.textColor,
                //         fontSize: 18,
                //         fontWeight: FontWeight.w300),
                //   ),
                // ),
                // const SizedBox(
                //   height: 8,
                // ),
                // Container(
                //   height: 56,
                //   width: 340,
                //   decoration: BoxDecoration(
                //     borderRadius: BorderRadius.circular(16),
                //     color: styleStore.shapeColor,
                //   ),
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                //     children: [
                //       InkWell(
                //         onTap: () {
                //           launchInBrowser("https://www.google.com");
                //         },
                //         child: Ink(
                //           child: SizedBox(
                //             width: 120,
                //             child: Image.asset(
                //               "assets/images/PayPalLogo.png",
                //               fit: BoxFit.fitHeight,
                //               filterQuality: FilterQuality.medium,
                //             ),
                //           ),
                //         ),
                //       ),
                //       Container(
                //         width: 3,
                //         height: 36,
                //         decoration: BoxDecoration(
                //             color: styleStore.textColor,
                //             borderRadius: BorderRadius.circular(16)),
                //       ),
                //       InkWell(
                //         onTap: () {
                //           launchInBrowser("https://www.google.com");
                //         },
                //         child: Ink(
                //           child: SizedBox(
                //               width: 120,
                //               child: Image.asset(
                //                 "assets/images/PatreonLogo.png",
                //                 filterQuality: FilterQuality.medium,
                //               )),
                //         ),
                //       ),
                //     ],
                //   ),
                // ),
                const SizedBox(
                  height: 32,
                ),
                SizedBox(
                  width: double.infinity,
                  child: Text(
                    AppLocalizations.of(context)!.askReview,
                    style: GoogleFonts.getFont(
                      'Mitr',
                      color: styleStore.textColor,
                      fontSize: 18,
                      fontWeight: FontWeight.w300,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  height: 64,
                  width: 125,
                  child: Image.asset(
                    "assets/images/GooglePlayLogo.png",
                    fit: BoxFit.contain,
                    filterQuality: FilterQuality.medium,
                    cacheHeight: 128,
                    cacheWidth: 250,
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                SizedBox(
                  width: double.infinity,
                  child: Text(
                    AppLocalizations.of(context)!.canImprove,
                    style: GoogleFonts.getFont(
                      'Mitr',
                      color: styleStore.textColor,
                      fontSize: 18,
                      fontWeight: FontWeight.w300,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(
                  height: 56,
                ),
                Divider(
                  color: styleStore.textColor,
                  endIndent: 16,
                  indent: 16,
                ),
                const SizedBox(
                  height: 32,
                ),
                SizedBox(
                  width: double.infinity,
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                        text: AppLocalizations.of(context)!.appMade,
                        style: GoogleFonts.getFont(
                          'Mitr',
                          color: styleStore.textColor,
                          fontSize: 18,
                          fontWeight: FontWeight.w300,
                        ),
                        children: [
                          TextSpan(
                            text: "The Movie DB API",
                            style: GoogleFonts.getFont(
                              'Mitr',
                              color: styleStore.primaryColor,
                              fontSize: 18,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        ]),
                  ),
                ),
                const SizedBox(
                  height: 32,
                ),
                SizedBox(
                  height: 56,
                  child: Image.asset("assets/images/MovieDB.png"),
                ),
                const SizedBox(
                  height: 32,
                ),
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(styleStore.primaryColor),
                    fixedSize: MaterialStateProperty.all(
                      Size.fromWidth(280),
                    ),
                  ),
                  onPressed: () {
                    launchInBrowser('https://www.themoviedb.org/');
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    child: Text(
                      AppLocalizations.of(context)!.goToWebSite,
                      style: GoogleFonts.getFont(
                        'Mitr',
                        color:
                            AppColors.textOnPrimaries[styleStore.colorIndex!],
                        fontSize: 20,
                        fontWeight: FontWeight.w200,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 32,
                ),
                SizedBox(
                  width: double.infinity,
                  child: Text(
                    AppLocalizations.of(context)!.disclaimer.toUpperCase(),
                    style: GoogleFonts.getFont(
                      'Mitr',
                      color: styleStore.textColor,
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                SizedBox(
                  width: double.infinity,
                  child: Text(
                    AppLocalizations.of(context)!.disclaimerText,
                    style: GoogleFonts.getFont(
                      'Mitr',
                      color: styleStore.textColor,
                      fontSize: 18,
                      fontWeight: FontWeight.w100,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(
                  height: 64,
                ),
              ],
            ),
          ),
        )
      ]),
    );
  }
}
