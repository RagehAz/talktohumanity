import 'package:animators/animators.dart';
import 'package:bldrs_theme/bldrs_theme.dart';
import 'package:flutter/material.dart';
import 'package:layouts/layouts.dart';
import 'package:scale/scale.dart';
import 'package:segmented_circle_border/segmented_circle_border.dart';
import 'package:talktohumanity/views/helpers/standards.dart';
import 'package:talktohumanity/views/widgets/expander_button/b_expanding_tile.dart';
import 'package:talktohumanity/views/widgets/basics/talk_box.dart';
import 'package:talktohumanity/views/widgets/basics/talk_text.dart';
import 'package:talktohumanity/views/widgets/time_line/vertical_timeline_line.dart';

class TimelineTile extends StatelessWidget {
  // -----------------------------------------------------------------------------
  const TimelineTile({
    @required this.isFirst,
    // @required this.postModel,
    @required this.isLast,
     @required this.onLike,
    @required this.onView,
    Key key
  }) : super(key: key);
  // -----------------------------------------------------------------------------
  final bool isFirst;
  // final PostModel postModel;
  final bool isLast;
  final Function onLike;
  final Function onView;
  // -----------------------------------------------------------------------------
  String _generateText() {
    String _output = '';
    for (int i = 0; i < 5000; i++) {
      _output = '$_output blah ';
    }
    return _output;
  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    final double _screenWidth = Scale.screenWidth(context);
    final double _screenHeight = Scale.screenHeight(context);
    // --------------------
    final double _maxTileHeight = _screenHeight - 150;
    // --------------------
    final double _tileBoxWidth = _screenWidth - Standards.timelineMinTileWidth;

    final double _postBubbleWidth = _tileBoxWidth - 20;

    const double _buttonsBoxHeight = 40;
    final double _bubbleHeight = _maxTileHeight - Standards.timelineMinTileHeight - 20 - _buttonsBoxHeight;
    // --------------------
    return ExpandingTile(
      // initiallyExpanded: false,
      // isCollapsable: true,
      // scrollable: true,
      // isDisabled: index.isOdd,
      width: _screenWidth,
      firstHeadline: 'Name',
      secondHeadline: 'title',
      // initialColor: Colorz.bloodTest,
      expansionColor: Colorz.white20,
      margin: EdgeInsets.zero,
      corners: 0,
      collapsedHeight: Standards.timelineMinTileHeight,
      maxHeight: _maxTileHeight,

      /// NAME - PIC - TITLE : TILE
      tileBox: SizedBox(
        width: _tileBoxWidth,
        height: Standards.timelineMinTileHeight,
        child: Row(
          // mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const TalkBox(
              width: Standards.timelinePicSize,
              height: Standards.timelinePicSize,
              corners: Standards.timelinePicSize * 0.5,
              icon: Iconz.dvRageh2,
              margins: EdgeInsets.only(
                top: (Standards.timelineSideMargin * 3) -
                    (Standards.timelinePicSize / 2) +
                    (Standards.timelineLineThickness * 0.5),
                left: Standards.timelineSideMargin,
              ),
            ),
            Container(
              width: _tileBoxWidth - Standards.timelinePicSize - Standards.timelineSideMargin,
              height: Standards.timelineMinTileHeight,
              padding: const EdgeInsets.only(
                left: 10,
                right: 10,
                top: 9,
              ),
              // color: Colorz.bloodTest,
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const <Widget>[
                  /// FIRST HEADLINE
                  TalkText(
                    text: 'Name',
                    centered: false,
                    // maxLines: 1,
                    textHeight: 25,
                  ),

                  /// SECOND HEADLINE
                  TalkText(
                    text: 'title',
                    weight: FontWeight.w100,
                    italic: true,
                    textHeight: 20,
                    textColor: Colorz.white125,
                    maxLines: 2,
                    centered: false,
                    font: BldrsThemeFonts.fontBldrsBodyFont,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),

      /// SIDE BOX
      sideBox: SizedBox(
        width: Standards.timelineMinTileWidth,
        height: Standards.timelineMinTileHeight,
        child: Stack(
          alignment: Alignment.topLeft,
          children: <Widget>[
            /// VERTICAL LINE
            VerticalLineLayer(
              height: Standards.timelineMinTileHeight,
              topPadding: isFirst ? Standards.timelineSideMargin * 3 + Standards.timelineLineRadius : 0,
            ),

            /// HORIZONTAL LINE
            Container(
              width: Standards.timelineMinTileWidth,
              height: Standards.timelineMinTileHeight,
              alignment: Alignment.topLeft,
              child: Container(
                width: Standards.timelineMinTileWidth -
                    Standards.timelineSideMargin -
                    Standards.timelineLineRadius,
                height: Standards.timelineLineThickness,
                color: Standards.timelineLineColor,
                margin: const EdgeInsets.only(
                  left: Standards.timelineSideMargin + (Standards.timelineLineRadius),
                  top: Standards.timelineSideMargin * 3,
                ),
              ),
            ),

            /// QUARTER CIRCLE
            Padding(
              padding: const EdgeInsets.only(
                left: Standards.timelineSideMargin,
                top: Standards.timelineSideMargin * 3,
              ),
              child: Material(
                  shape: SegmentedCircleBorder(
                      // offset: 0, // this rotates segments anticlockwise from top quadrant
                      numberOfSegments: 4,
                      sides: const <BorderSide>[
                        BorderSide(color: Colorz.nothing, width: 2),
                        BorderSide(color: Colorz.nothing, width: 2),
                        BorderSide(color: Standards.timelineLineColor, width: 2),
                        BorderSide(color: Colorz.nothing, width: 2),
                      ]),
                  child: Container(
                    width: Standards.timelineLineRadius * 2,
                    height: Standards.timelineLineRadius * 2,
                    color: Colorz.nothing,
                  )),
            ),

            /// DAY
            const Positioned(
              top: 7,
              left: Standards.timelineSideMargin +
                  Standards.timelineLineThickness +
                  Standards.timelineLineRadius,
              child: TalkText(
                text: '25',
                textHeight: 25,
                font: BldrsThemeFonts.fontBldrsHeadlineFont,
                // boxColor: Colorz.bloodTest,
                centered: false,
                letterSpacing: 1,
              ),
            ),

            /// MONTH
            const Positioned(
              top: Standards.timelineSideMargin * 3 + 3,
              left: Standards.timelineSideMargin +
                  Standards.timelineLineThickness +
                  Standards.timelineLineRadius,
              child: TalkText(
                text: 'Sept.',
                textHeight: 17,
                font: BldrsThemeFonts.fontBldrsBodyFont,
                // boxColor: Colorz.bloodTest,
                centered: false,
                letterSpacing: 1,
              ),
            ),

            /// LAST POST DOT
            if (isLast)
            Container(
              width: 10,
              height: 10,
              margin: const EdgeInsets.only(
                top: Standards.timelineMinTileHeight - 10,
                left: Standards.timelineSideMargin - (10 / 2) + 1,
              ),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(5)),
                color: Standards.timelineLineColor,
              ),
            ),

          ],
        ),
      ),

      /// POST
      child: Row(
        children: <Widget>[

          /// TIMELINE LINE
          VerticalLineLayer(
            height: _maxTileHeight - Standards.timelineMinTileHeight,
            isOn: !isLast,
          ),

          /// POST BUBBLE
          Padding(
            padding: const EdgeInsets.only(
              left: 10,
              bottom: 10,
            ),
            child: Column(
              children: <Widget>[
                /// BUBBLE
                Container(
                  height: _bubbleHeight,
                  width: _postBubbleWidth,
                  decoration: const BoxDecoration(
                    color: Colorz.white10,
                    borderRadius: Borderers.constantCornersAll20,
                  ),
                  child: ClipRRect(
                    borderRadius: Borderers.constantCornersAll20,
                    child: Scroller(
                      child: FloatingList(
                        width: _postBubbleWidth,
                        height: _bubbleHeight,
                        padding: const EdgeInsets.only(
                          top: 10,
                        ),
                        columnChildren: <Widget>[
                          const TalkText(
                            text: 'Headline',
                            textHeight: 35,
                            margins: 10,
                            maxLines: 2,
                          ),
                          TalkText(
                            text: _generateText(),
                            maxLines: 50000,
                            font: BldrsThemeFonts.fontBldrsBodyFont,
                            textHeight: 25,
                            weight: FontWeight.w200,
                            margins: 10,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                /// SPACER
                const SizedBox(
                  width: 10,
                  height: 10,
                ),

                /// BUTTONS BOX
                SizedBox(
                  width: _postBubbleWidth,
                  height: _buttonsBoxHeight,
                  // color: Colorz.yellow125,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      /// VIEWS
                      const TalkBox(
                        height: _buttonsBoxHeight,
                        icon: Iconz.viewsIcon,
                        text: '12.2M views',
                        iconSizeFactor: 0.5,
                        textScaleFactor: 0.7 / 0.5,
                        bubble: false,
                      ),

                      /// LIKES
                      TalkBox(
                        height: _buttonsBoxHeight,
                        icon: Iconz.save,
                        text: '1M Likes',
                        iconSizeFactor: 0.7,
                        // textScaleFactor: 0.7 / 0.7,
                        onTap: onLike,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),

    );
    // --------------------
  }
  // -----------------------------------------------------------------------------
}
