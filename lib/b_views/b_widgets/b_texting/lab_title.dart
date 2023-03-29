import 'package:flutter/material.dart';
import 'package:scale/scale.dart';
import 'package:talktohumanity/b_views/b_widgets/b_texting/talk_text.dart';

class LabTitle extends StatelessWidget {
  // -----------------------------------------------------------------------------
  const LabTitle({
    this.text,
    Key key
  }) : super(key: key);
  // -----------------------------------------------------------------------------
  final String text;
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return TalkText(
      boxWidth: Scale.screenShortestSide(context),
      text: text,
      isBold: true,
      textHeight: 30,
      centered: false,
      margins: 20,
      italic: true,
    );

  }
  // -----------------------------------------------------------------------------
}
