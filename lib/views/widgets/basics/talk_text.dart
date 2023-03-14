import 'package:bldrs_theme/bldrs_theme.dart';
import 'package:flutter/material.dart';
import 'package:super_text/super_text.dart';

class TalkText extends StatelessWidget {
  // --------------------------------------------------------------------------
  const TalkText({
    /// TEXT
    @required this.text,
    this.highlight,
    /// SCALES
    this.boxWidth,
    this.boxHeight,
    this.textHeight = 50,
    this.maxLines = 1,
    this.margins,
    this.lineThickness = 0.5,
    /// SPACING
    this.wordSpacing,
    this.letterSpacing,
    /// COLORS
    this.textColor = const Color.fromARGB(255, 255, 255, 255),
    this.boxColor,
    this.highlightColor = const Color.fromARGB(100, 255, 0, 0),
    this.lineColor,
    /// WEIGHT
    this.weight,
    /// STYLE
    this.font,
    this.italic = false,
    this.shadows,
    this.line,
    this.lineStyle = TextDecorationStyle.solid,
    /// DOTS
    this.leadingDot = false,
    this.redDot = false,
    /// DIRECTION
    this.centered = true,
    this.textDirection,
    this.appIsLTR = false,
    /// GESTURES
    this.onTap,
    this.onDoubleTap,

    this.package,
    /// KEY
    Key key,
  }) : super(key: key);
  // --------------------------------------------------------------------------
  /// TEXT
  final String text;
  final ValueNotifier<dynamic> highlight;
  /// SCALES
  final double boxWidth;
  final double boxHeight;
  final double textHeight;
  final int maxLines;
  final dynamic margins;
  final double lineThickness;
  /// SPACING
  final double wordSpacing;
  final double letterSpacing;
  /// COLORS
  final Color textColor;
  final Color boxColor;
  final Color highlightColor;
  final Color lineColor;
  /// WEIGHT
  final FontWeight weight;
  /// STYLE
  final String font;
  final bool italic;
  final List<Shadow> shadows;
  final TextDecoration line;
  final TextDecorationStyle lineStyle;
  /// DOTS
  final bool leadingDot;
  final bool redDot;
  /// DIRECTION
  final bool centered;
  final TextDirection textDirection;
  final bool appIsLTR;
  /// GESTURES
  final Function onTap;
  final Function onDoubleTap;
  final String package;
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return SuperText(
      text: text,
      highlight: highlight,
      boxWidth: boxWidth,
      boxHeight: boxHeight,
      textHeight: textHeight,
      maxLines: maxLines,
      margins: margins,
      lineThickness: lineThickness,
      wordSpacing: wordSpacing,
      letterSpacing: letterSpacing,
      textColor: textColor,
      boxColor: boxColor,
      highlightColor: highlightColor,
      lineColor: lineColor,
      weight: weight,
      font: font ?? BldrsThemeFonts.fontBldrsHeadlineFont,
      italic: italic,
      shadows: shadows,
      line: line,
      lineStyle: lineStyle,
      leadingDot: leadingDot,
      redDot: redDot,
      centered: centered,
      textDirection: textDirection ?? TextDirection.ltr,
      appIsLTR: appIsLTR ?? true,
      onTap: onTap,
      onDoubleTap: onDoubleTap,
      package: package,
    );

  }
  // --------------------------------------------------------------------------
}
