import 'package:bldrs_theme/bldrs_theme.dart';
import 'package:flutter/material.dart';
import 'package:talktohumanity/b_views/b_widgets/a_buttons/talk_box.dart';

class AuthButton extends StatelessWidget {
  // --------------------------------------------------------------------------
  const AuthButton({
    @required this.text,
    @required this.icon,
    @required this.onTap,
    this.iconSizeFactor = 0.5,
    Key key
  }) : super(key: key);
  // --------------------------------------------------------------------------
  final String text;
  final String icon;
  final double iconSizeFactor;
  final Function onTap;
  // --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return TalkBox(
      height: 50,
      width: 300,
      text: text,
      icon: icon,
      iconColor: Colorz.black255,
      iconSizeFactor: iconSizeFactor,
      textScaleFactor: 0.7 / iconSizeFactor,
      onTap: onTap,
      isBold: true,
      color: Colorz.white200,
      textCentered: false,
      margins: const EdgeInsets.only(bottom: 10),
    );

  }
  // --------------------------------------------------------------------------
}
