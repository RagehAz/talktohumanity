import 'package:bldrs_theme/bldrs_theme.dart';
import 'package:flutter/material.dart';
import 'package:talktohumanity/b_views/b_widgets/a_buttons/talk_box.dart';
import 'package:talktohumanity/d_helpers/talk_theme.dart';

class MainButton extends StatelessWidget {
  // --------------------------------------------------------------------------
  const MainButton({
    @required this.text,
    this.width = 100,
    this.onTap,
    this.color = Colorz.white255,
    this.textColor = Colorz.black255,
    this.smallText = false,
    Key key
  }) : super(key: key);
  // --------------------------------------------------------------------------
  final String text;
  final double width;
  final Function onTap;
  final Color color;
  final Color textColor;
  final bool smallText;
  // --------------------------------------------------------------------------
  static const double height = 50;
  // --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return TalkBox(
      width: width,
      height: height,
      textScaleFactor: smallText == true ? 0.6 : 0.8,
      text: text,
      onTap: onTap,
      color: color,
      textColor: textColor,
      textFont: TalkTheme.talkFont,
      textWeight: FontWeight.w600,
      // textItalic: true,
      textMaxLines: 2,
    );

  }
  // --------------------------------------------------------------------------
}
