import 'package:flutter/material.dart';
import 'package:scale/scale.dart';
import 'package:talktohumanity/b_views/b_widgets/a_buttons/talk_box.dart';
import 'package:talktohumanity/d_helpers/helper_methods.dart';
import 'package:talktohumanity/d_helpers/standards.dart';

class TimeLineMonthBullet extends StatelessWidget {
  // --------------------------------------------------------------------------
  const TimeLineMonthBullet({
    @required this.month,
    @required this.year,
    Key key
  }) : super(key: key);
  // --------------------------------------------------------------------------
  final int month;
  final int year;
  // --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    const double _spacings = 5;

    return Center(
      child: SizedBox(
        width: Scale.screenShortestSide(context),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[

            /// SIDE MARGIN
            const SizedBox(
              width: Standards.timelineSideMargin,
              height: _spacings,
            ),

            /// YEAR
            TalkBox(
              height: Standards.yearBulletHeight,
              width: Standards.timelineMinTileHeight + 40,
              text: '${getMonthName(month: month, shortForm: false,)} $year',
              // centered: false,
              margins: const EdgeInsets.only(
                bottom: Standards.timelineHeadlineTopMargin,
              ),
              bubble: false,
              textScaleFactor: 1.2,
              // color: Standards.timelineLineColor,
              // textColor: Colorz.black255,
              isBold: true,
              corners: Borderers.cornerOnly(
                appIsLTR: true,
                enBottomLeft: Standards.yearBulletCorner,
                enBottomRight: Standards.yearBulletCorner,
                enTopLeft: 0,
                enTopRight: Standards.yearBulletCorner,
              ),
            ),

            // /// MONTH
            // TalkText(
            //   text: getMonthName(month: month, shortForm: false,),
            //   centered: false,
            //   margins: const EdgeInsets.only(
            //     left: _spacings,
            //   ),
            //   textHeight: Standards.yearBulletHeight,
            //   italic: true,
            //   font: BldrsThemeFonts.fontBldrsBodyFont,
            //   weight: FontWeight.w100,
            // ),

          ],
        ),
      ),
    );

  }
  // --------------------------------------------------------------------------
}
