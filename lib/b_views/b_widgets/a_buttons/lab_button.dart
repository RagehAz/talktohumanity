import 'package:bldrs_theme/bldrs_theme.dart';
import 'package:flutter/material.dart';
import 'package:scale/scale.dart';
import 'package:talktohumanity/b_views/b_widgets/a_buttons/talk_box.dart';

class LabButton extends StatelessWidget {
  // --------------------------------------------------------------------------
  const LabButton({
    @required this.text,
    @required this.onTap,
    this.isOk = false,
    Key key
  }) : super(key: key);
  // --------------------------------------------------------------------------
  final String text;
  final Function onTap;
  final bool isOk;
  // --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return TalkBox(
      height: 30,
      margins: const EdgeInsets.only(bottom: 5),
      width: Scale.screenShortestSide(context) - 40,
      text: text,
      isBold: true,
      onTap: onTap,
      color: isOk == true ? Colorz.green125 : Colorz.white20,
      textCentered: false,
      textColor: Colorz.white255,
    );

  }
  // --------------------------------------------------------------------------
}
