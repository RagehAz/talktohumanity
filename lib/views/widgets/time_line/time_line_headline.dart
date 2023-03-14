import 'package:bldrs_theme/bldrs_theme.dart';
import 'package:flutter/material.dart';
import 'package:talktohumanity/views/widgets/basics/talk_text.dart';

class TimeLineHeadline extends StatelessWidget {
  // --------------------------------------------------------------------------
  const TimeLineHeadline({
    Key key
  }) : super(key: key);
  // --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return Row(
      children: const <Widget>[

        /// SIDE MARGIN
        SizedBox(
          width: 5,
          height: 5,
        ),

        /// YEAR
        TalkText(
          text: '2023',
          centered: false,
          margins: EdgeInsets.only(
            bottom: 5,
            top: 30,
          ),
          textHeight: 30,
          boxColor: Colorz.white20,
        ),

        /// MONTH
        TalkText(
          text: 'September',
          centered: false,
          margins: EdgeInsets.only(
            bottom: 5,
            top: 30,
            left: 5,
          ),
          textHeight: 35,
          italic: true,
          font: BldrsThemeFonts.fontBldrsBodyFont,
          weight: FontWeight.w100,
        ),
      ],
    );

  }
  // --------------------------------------------------------------------------
}
