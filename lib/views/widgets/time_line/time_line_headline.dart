import 'package:bldrs_theme/bldrs_theme.dart';
import 'package:flutter/material.dart';
import 'package:talktohumanity/views/helpers/standards.dart';
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

    return Row(
      children: const <Widget>[

        /// SIDE MARGIN
        SizedBox(
          width: _spacings,
          height: _spacings,
        ),

        /// YEAR
        TalkText(
          text: '2023',
          centered: false,
          margins: EdgeInsets.only(
            bottom: _spacings,
            top: Standards.timelineHeadlineTopMargin,
          ),
          textHeight: Standards.timelineHeadlineHeight - _spacings,
          boxColor: Colorz.white20,
        ),

        /// MONTH
        TalkText(
          text: 'September',
          centered: false,
          margins: EdgeInsets.only(
            bottom: _spacings,
            top: Standards.timelineHeadlineTopMargin,
            left: _spacings,
          ),
          textHeight: Standards.timelineHeadlineHeight,
          italic: true,
          font: BldrsThemeFonts.fontBldrsBodyFont,
          weight: FontWeight.w100,
        ),
      ],
    );

  }
  // --------------------------------------------------------------------------
}
