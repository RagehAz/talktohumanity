import 'package:flutter/material.dart';
import 'package:talktohumanity/d_helpers/standards.dart';

class VerticalLineLayer extends StatelessWidget {
  // --------------------------------------------------------------------------
  const VerticalLineLayer({
    @required this.height,
    this.topPadding = 0,
    this.isOn = true,
    Key key
  }) : super(key: key);
  // --------------------------------------------------------------------------
  final double height;
  final double topPadding;
  final bool isOn;
  // --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return Container(
      height: height,
      width: Standards.timelineMinTileWidth,
      alignment: Alignment.bottomLeft,
      child: isOn == false ? const SizedBox() : Container(
        width: Standards.timelineLineThickness,
        height: height - topPadding,
        color: Standards.timelineLineColor,
        margin: const EdgeInsets.only(
            left: Standards.timelineSideMargin,
        ),
      ),
    );

  }
  // --------------------------------------------------------------------------
}
