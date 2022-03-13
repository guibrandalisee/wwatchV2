import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:line_icons/line_icons.dart';
import 'package:wwatch/Shared/Themes/app_colors.dart';
import 'package:wwatch/Shared/models/cast_and_crew_model.dart';
import 'package:wwatch/main.dart';
import 'package:wwatch/stores/style_store.dart';

class PersonSocialMediaWidget extends StatelessWidget {
  PersonSocialMediaWidget({Key? key, required this.externalIds})
      : super(key: key);
  final PersonExternalIds externalIds;
  final StyleStore styleStore = GetIt.I<StyleStore>();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Divider(
          color: AppColors.divider,
          thickness: 1,
          endIndent: 24,
          indent: 24,
        ),
        SizedBox(
          height: 8,
        ),
        Container(
          padding: const EdgeInsets.all(16),
          width: double.infinity,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              if (externalIds.instagramId != null &&
                  externalIds.instagramId != '')
                GestureDetector(
                    onTap: Feedback.wrapForTap(() {
                      launchInBrowser(
                          'https://www.instagram.com/${externalIds.instagramId}');
                    }, context),
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                      child: Icon(
                        LineIcons.instagram,
                        color: styleStore.textColor,
                        size: 48,
                      ),
                    )),
              if (externalIds.twitterId != null && externalIds.twitterId != '')
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                  child: GestureDetector(
                      onTap: Feedback.wrapForTap(() {
                        launchInBrowser(
                            'https://twitter.com/${externalIds.twitterId}');
                      }, context),
                      child: Icon(
                        LineIcons.twitter,
                        color: styleStore.textColor,
                        size: 48,
                      )),
                ),
              if (externalIds.facebookId != null &&
                  externalIds.facebookId != '')
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                  child: GestureDetector(
                      onTap: Feedback.wrapForTap(() {
                        launchInBrowser(
                            'https://facebook.com/${externalIds.facebookId}');
                      }, context),
                      child: Icon(
                        LineIcons.facebook,
                        color: styleStore.textColor,
                        size: 48,
                      )),
                ),
            ],
          ),
        ),
      ],
    );
  }
}
