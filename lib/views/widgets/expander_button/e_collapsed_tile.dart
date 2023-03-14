import 'package:bldrs_theme/bldrs_theme.dart';
import 'package:flutter/material.dart';
import 'package:scale/scale.dart';
import 'package:talktohumanity/views/widgets/talk_box.dart';
import 'package:talktohumanity/views/widgets/talk_text.dart';
import 'b_expanding_tile.dart';

class CollapsedTile extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const CollapsedTile({
    @required this.onTileTap,
    @required this.tileWidth,
    @required this.collapsedHeight,
    @required this.sideBox,
    @required this.child,
    @required this.firstHeadline,
    @required this.secondHeadline,
    @required this.arrowTurns,
    @required this.arrowColor,
    @required this.expandableHeightFactorAnimationValue,
    @required this.tileColor,
    @required this.corners,
    this.iconCorners,
    this.marginIsOn = true,
    this.searchText,
    this.onTileLongTap,
    this.onTileDoubleTap,
    Key key,
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final Function onTileTap;
  final double tileWidth;
  final double collapsedHeight;
  final Widget sideBox;
  final Widget child;
  final String firstHeadline;
  final String secondHeadline;
  final Animation<double> arrowTurns;
  final Color arrowColor;
  final double expandableHeightFactorAnimationValue;
  final Color tileColor;
  final double corners;
  final double iconCorners;
  final bool marginIsOn;
  final ValueNotifier<dynamic> searchText;
  final Function onTileLongTap;
  final Function onTileDoubleTap;
  /// --------------------------------------------------------------------------
  static const double collapsedGroupHeight = ((Ratioz.appBarCorner + Ratioz.appBarMargin) * 2) + Ratioz.appBarMargin;
  static const double arrowBoxSize = ExpandingTile.arrowBoxSize;
  static const double cornersValue = Ratioz.appBarCorner;
  static const Color collapsedColor = Colorz.white10;
  static const Color expandedColor = Colorz.blue80;
  // --------------------
  static Widget arrow({
    double collapsedHeight,
    Color arrowColor,
    bool arrowDown = true,
  }) {

    final double _arrowBoxSize = collapsedHeight ?? collapsedGroupHeight;

    return TalkBox(
      height: _arrowBoxSize,
      width: _arrowBoxSize,
      bubble: false,
      icon: arrowDown ? Iconz.arrowDown : Iconz.arrowUp,
      iconSizeFactor: 0.2,
      iconColor: arrowColor ?? Colorz.white255,
    );

  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    const double _titlePadding = Ratioz.appBarMargin;

    return Container(
      // key: const ValueKey<String>('CollapsedTile'),
      // height: collapsedHeight, // this block expansion
      width: tileWidth,
      margin: marginIsOn == true ?
      const EdgeInsets.symmetric(
          vertical: Ratioz.appBarPadding,
          horizontal: Ratioz.appBarMargin
      )
          :
      null,
      decoration: BoxDecoration(
        color: tileColor,
        borderRadius: Borderers.cornerAll(context, corners),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[

          /// COLLAPSED ZONE
          GestureDetector(
            key: const ValueKey<String>('CollapsedTile_collapsed_zone'),
            onTap: onTileTap,
            onLongPress: onTileLongTap,
            onDoubleTap: onTileDoubleTap,
            child: Container(
              width: tileWidth,
              color: Colorz.nothing,

              /// do no delete this,, it adjusts GestureDetector tapping area
              child: Row(
                children: <Widget>[

                  /// Icon
                  if (sideBox != null)
                    sideBox,

                  /// Tile title
                  Container(
                    width: ExpandingTile.calculateTitleBoxWidth(
                      collapsedHeight: collapsedHeight ?? CollapsedTile.collapsedGroupHeight,
                      tileWidth: tileWidth,
                    ),
                    height: collapsedHeight ?? CollapsedTile.collapsedGroupHeight,
                    padding: const EdgeInsets.symmetric(horizontal: _titlePadding),
                    // color: Colorz.bloodTest,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[

                        /// FIRST HEADLINE
                        TalkText(
                          text: firstHeadline,
                          centered: false,
                          maxLines: secondHeadline == null ? 2 : 1,
                          highlight: searchText,
                          textHeight: 25,
                        ),

                        /// SECOND HEADLINE
                        if (secondHeadline != null)
                          TalkText(
                            text: secondHeadline,
                            weight: FontWeight.w100,
                            italic: true,
                            textHeight: 20,
                            textColor: Colorz.white125,
                            maxLines: 2,
                            centered: false,
                            highlight: searchText,
                            font: BldrsThemeFonts.fontBldrsBodyFont,
                          ),

                      ],
                    ),
                  ),

                  /// Arrow
                  RotationTransition(
                    turns: arrowTurns,
                    child: arrow(
                      collapsedHeight: collapsedHeight,
                      arrowColor: arrowColor,
                    ),
                  ),

                ],
              ),
            ),
          ),

          /// EXPANDABLE ZONE
          ClipRRect(
            key: const ValueKey<String>('CollapsedTile_expandable_zone'),
            child: Align(
              heightFactor: expandableHeightFactorAnimationValue,
              child: child,
            ),
          ),

        ],
      ),
    );

  }
  // -----------------------------------------------------------------------------
}
