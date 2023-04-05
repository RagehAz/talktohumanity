import 'package:bldrs_theme/bldrs_theme.dart';
import 'package:flutter/material.dart';
import 'package:talktohumanity/b_views/b_widgets/b_texting/talk_text.dart';

class DataStripWithHeadline extends StatelessWidget {
  // --------------------------------------------------------------------------
  const DataStripWithHeadline({
    @required this.dataKey,
    @required this.dataValue,
    Key key
  }) : super(key: key);
  // --------------------------------------------------------------------------
  final String dataKey;
  final dynamic dataValue;
  // --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {


    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[

        TalkText(
          text: dataKey,
          textHeight: 20,
          centered: false,
          boxColor: Colorz.bloodTest,
          isBold: true,
        ),

        TalkText(
          text: dataValue.toString(),
          textHeight: 20,
          centered: false,
          isBold: false,
          margins: const EdgeInsets.only(bottom: 7),
          maxLines: 3,
          // boxWidth: 300,
        ),

      ],
    );

  }
  // --------------------------------------------------------------------------
}
