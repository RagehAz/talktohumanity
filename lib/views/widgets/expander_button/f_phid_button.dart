import 'package:bldrs_theme/bldrs_theme.dart';
import 'package:flutter/material.dart';
import 'package:talktohumanity/views/widgets/expander_button/a_chain_button_box.dart';
import 'package:talktohumanity/views/widgets/basics/talk_box.dart';

class PhidButton extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const PhidButton({
    @required this.phid,
    this.width,
    this.onPhidTap,
    this.color = Colorz.white20,
    this.level = 1,
    this.isDisabled = false,
    this.xIsOn = false,
    this.margins,
    this.searchText,
    this.inverseAlignment,
    this.secondLine,
    this.onPhidDoubleTap,
    this.onPhidLongTap,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final double width;
  final Color color;
  final String phid; // phrase id
  final int level;
  final bool isDisabled;
  final bool xIsOn;
  final dynamic margins;
  final ValueNotifier<dynamic> searchText;
  final bool inverseAlignment;
  final String secondLine;
  final Function onPhidTap;
  final Function onPhidDoubleTap;
  final Function onPhidLongTap;
  /// --------------------------------------------------------------------------
  static double getHeight(){
    return ChainButtonBox.sonHeight();
  }

  // --------------------
  /// TESTED : WORKS PERFECT
  double _getVerseScaleFactor(){
    double _scaleFactor;

    if (xIsOn == true){
      _scaleFactor = 1.7;
    }
    else {
      _scaleFactor = 0.65;
    }

    return _scaleFactor;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  double _getIconScaleFactor(){
    double _scaleFactor;

    if (xIsOn == true){
      _scaleFactor = 0.4;
    }
    else {
      _scaleFactor = 1;
    }

    return _scaleFactor;
  }
  // --------------------
  @override
  Widget build(BuildContext context) {

    return ChainButtonBox(
      key: const ValueKey<String>('PhidButton'),
      boxWidth: width,
      inverseAlignment: inverseAlignment,
      child: TalkBox(
        height: getHeight(),
        width: width,
        color: color,
        text: phid,
        margins: margins,
        // secondLine: TextGenerator.bzTypeSingleStringer(context, _bz.bzType),
        icon: Iconz.dvDonaldDuck,
        iconSizeFactor: _getIconScaleFactor(),
        textScaleFactor: _getVerseScaleFactor(),
        textCentered: false,
        textMaxLines: secondLine == null ? 2 : 1,
        bubble: false,
        textShadow: false,
        textItalic: true,
        textHighlight: searchText,
        secondText: secondLine,
        secondTextMaxLines: 1,
        onTap: onPhidTap,
        onDoubleTap: onPhidDoubleTap,
        onLongTap: onPhidLongTap,
      ),
    );

  }
// -----------------------------------------------------------------------------
}
