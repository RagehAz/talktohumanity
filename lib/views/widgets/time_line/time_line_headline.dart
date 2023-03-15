import 'package:bldrs_theme/bldrs_theme.dart';
import 'package:flutter/material.dart';
import 'package:scale/scale.dart';
import 'package:talktohumanity/views/helpers/standards.dart';
import 'package:talktohumanity/views/widgets/basics/talk_box.dart';
import 'package:talktohumanity/views/widgets/basics/talk_text.dart';

class TimeLineHeadline extends StatelessWidget {
  // --------------------------------------------------------------------------
  const TimeLineHeadline({
    Key key
  }) : super(key: key);
  // --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    const double _spacings = 5;
    const double _yearBulletHeight = Standards.timelinePicSize * 0.5;
    const double _yearBulletCorner = _yearBulletHeight * 0.35;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[

        /// SIDE MARGIN
        const SizedBox(
          width: Standards.timelineSideMargin,
          height: _spacings,
        ),

        /// YEAR
        TalkBox(
          height: _yearBulletHeight,
          text: '2023',
          // centered: false,
          margins: const EdgeInsets.only(
            bottom: Standards.timelineHeadlineTopMargin,
          ),
          bubble: false,
          textScaleFactor: 1.2,
          color: Standards.timelineLineColor,
          textColor: Colorz.black255,
          corners: Borderers.cornerOnly(
            appIsLTR: true,
            enBottomLeft: _yearBulletCorner,
            enBottomRight: _yearBulletCorner,
            enTopLeft: 0,
            enTopRight: _yearBulletCorner,
          ),
        ),

        /// MONTH
        const TalkText(
          text: 'September',
          centered: false,
          margins: EdgeInsets.only(
            left: _spacings,
          ),
          textHeight: _yearBulletHeight,
          italic: true,
          font: BldrsThemeFonts.fontBldrsBodyFont,
          weight: FontWeight.w100,
        ),

      ],
    );

  }
  // --------------------------------------------------------------------------
}
