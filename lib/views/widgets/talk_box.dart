import 'package:bldrs_theme/bldrs_theme.dart';
import 'package:flutter/material.dart';
import 'package:super_box/super_box.dart';

class TalkBox extends StatelessWidget {
  // --------------------------------------------------------------------------
  const TalkBox({
    @required this.height,
    this.width,
    this.icon,
    this.iconSizeFactor = 1,
    this.color = const Color.fromARGB(0, 255, 255, 255),
    this.corners,
    this.iconColor,
    this.text,
    this.textColor = const Color.fromARGB(255, 255, 255, 255),
    this.textWeight = FontWeight.w400,
    this.textScaleFactor = 1,
    this.textShadow,
    this.textItalic = false,
    this.textMaxLines = 1,
    this.secondTextMaxLines = 10,
    this.onTap,
    this.margins,
    this.greyscale = false,
    this.iconRounded = true,
    this.bubble = true,
    this.secondText,
    this.textCentered = true,
    this.subChild,
    this.childAlignment = Alignment.center,
    this.opacity = 1,
    this.isDisabled = false,
    this.splashColor = const Color.fromARGB(10, 255, 255, 255),
    this.onTapDown,
    this.onTapUp,
    this.onTapCancel,
    this.textDirection = TextDirection.ltr,
    this.blur,
    this.secondTextColor = const Color.fromARGB(255, 255, 255, 255),
    this.redDot = false,
    this.secondTextScaleFactor = 1,
    this.loading = false,
    this.iconBackgroundColor,
    this.onDisabledTap,
    this.textHighlight,
    this.textHighlightColor = const Color.fromARGB(100, 255, 0, 0),
    this.onLongTap,
    this.onDoubleTap,
    this.appIsLTR = true,
    this.package,
    this.textFont,
    this.letterSpacing,
    Key key,
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final dynamic icon;
  /// works as textSizeFactor as well
  final double iconSizeFactor;
  final Color color;
  final double width;
  final double height;
  final dynamic corners;
  final Color iconColor;
  final String text;
  final Color textColor;
  final FontWeight textWeight;
  final double textScaleFactor;
  final bool textShadow;
  final bool textItalic;
  final int textMaxLines;
  final int secondTextMaxLines;
  final Function onTap;
  final dynamic margins;
  final bool greyscale;
  final bool iconRounded;
  final bool bubble;
  final String secondText;
  final bool textCentered;
  final Widget subChild;
  final Alignment childAlignment;
  final double opacity;
  final bool isDisabled;
  final Color splashColor;
  final Function onTapDown;
  final Function onTapUp;
  final Function onTapCancel;
  final TextDirection textDirection;
  final double blur;
  final Color secondTextColor;
  final bool redDot;
  final double secondTextScaleFactor;
  final bool loading;
  final Color iconBackgroundColor;
  final Function onDisabledTap;
  final ValueNotifier<dynamic> textHighlight;
  final Color textHighlightColor;
  final Function onLongTap;
  final Function onDoubleTap;
  final bool appIsLTR;
  final String package;
  final String textFont;
  final double letterSpacing;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return SuperBox(
      height: height,
      width: width,
      icon: icon,
      iconSizeFactor: iconSizeFactor,
      color: color,
      corners: corners,
      iconColor: iconColor,
      text: text,
      textColor: textColor,
      textWeight: textWeight,
      textScaleFactor: textScaleFactor,
      textShadow: textShadow,
      textItalic: textItalic,
      textMaxLines: textMaxLines,
      secondTextMaxLines: secondTextMaxLines,
      onTap: onTap,
      margins: margins,
      greyscale: greyscale,
      iconRounded: iconRounded,
      bubble: bubble,
      secondText: secondText,
      textCentered: textCentered,
      childAlignment: childAlignment,
      opacity: opacity,
      isDisabled: isDisabled,
      splashColor: splashColor,
      onTapDown: onTapDown,
      onTapUp: onTapUp,
      onTapCancel: onTapCancel,
      textDirection: textDirection ?? TextDirection.ltr,
      blur: blur,
      secondTextColor: secondTextColor,
      redDot: redDot,
      secondTextScaleFactor: secondTextScaleFactor,
      loading: loading,
      iconBackgroundColor: iconBackgroundColor,
      onDisabledTap: onDisabledTap,
      textHighlight: textHighlight,
      textHighlightColor: textHighlightColor,
      onLongTap: onLongTap,
      onDoubleTap: onDoubleTap,
      appIsLTR: appIsLTR ?? true,
      package: package,
      textFont: textFont ?? BldrsThemeFonts.fontBldrsHeadlineFont,
      letterSpacing: letterSpacing,
      subChild: subChild,
    );

  }
  // --------------------------------------------------------------------------
}
