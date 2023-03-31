import 'package:bldrs_theme/bldrs_theme.dart';
import 'package:flutter/material.dart';
import 'package:scale/scale.dart';
import 'package:super_box/super_box.dart';

class SmallButton extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const SmallButton({
    @required this.verse,
    @required this.onTap,
    this.width = 80,
    Key key,
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final String verse;
  final Function onTap;
  final double width;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final double _buttonWidth = width ?? Scale.getUniformRowItemWidth(
      context: context,
      numberOfItems: 4,
      boxWidth: Scale.screenWidth(context) - 20,
    );

    return SuperBox(
      height: 50,
      width: _buttonWidth,
      color: Colorz.black255,
      margins: const EdgeInsets.symmetric(horizontal: 1),
      text: verse?.toUpperCase(),
      textScaleFactor: 0.6,
      textWeight: FontWeight.w600,
      textMaxLines: 2,
      onTap: onTap,
      textItalic: true,
      textFont: BldrsThemeFonts.fontBldrsHeadlineFont,
    );
  }
  /// --------------------------------------------------------------------------
  // @override
  // void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  //   super.debugFillProperties(properties);
  //   properties.add(StringProperty('verse', verse));
  //   properties.add(DiagnosticsProperty<Function>('onTap', onTap));
  // }
  /// --------------------------------------------------------------------------
}
