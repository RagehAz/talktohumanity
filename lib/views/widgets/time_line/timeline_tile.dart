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
    @required this.firstIsExpanded,
    Key key
  }) : super(key: key);
  // -----------------------------------------------------------------------------
  final bool isFirst;
  // final PostModel postModel;
  final bool isLast;
  final Function onLike;
  final Function onView;
  final bool firstIsExpanded;
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    return ExpandingTile(
      initiallyExpanded: isFirst && firstIsExpanded,
      // isCollapsable: true,
      // scrollable: true
      // isDisabled: index.isOdd,
      width: Scale.screenWidth(context),
      // initialColor: Colorz.bloodTest,
      expansionColor: Colorz.white20,
      margin: EdgeInsets.zero,
      corners: 0,
      collapsedHeight: Standards.timelineMinTileHeight,
      maxHeight: Standards.getMaxTimelineTileHeight(),

      /// NAME - PIC - TITLE : TILE
      tileBox: const _TimelineHeadline(

      ),

      /// SIDE BOX
      sideBox: _TimelineCornerBox(
        isFirst: isFirst,
        isLast: isLast,
      ),

      /// BODY
      child: _TimeLineBody(
        onView: onView,
        onLike: onLike,
        isLast: isLast,
      ),

    );
    // --------------------
  }
  // -----------------------------------------------------------------------------
}

class _TimelineHeadline extends StatelessWidget {
  // -----------------------------------------------------------------------------
  const _TimelineHeadline({
    Key key
  }) : super(key: key);
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    final double _tileUserBoxWidth = Standards.getTimelineUserBoxWidth();
    // --------------------
    return SizedBox(
        width: _tileUserBoxWidth,
        height: Standards.timelineMinTileHeight,
        child: Row(
          // mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[

            /// USER PIC
            const TalkBox(
              width: Standards.timelinePicSize,
              height: Standards.timelinePicSize,
              corners: Standards.timelinePicSize * 0.5,
              icon: Iconz.dvRageh2,
              margins: EdgeInsets.only(
                top: Standards.postUserPicTopMargin,
                left: Standards.timelineSideMargin,
              ),
            ),

            /// NAME AND TITLE
            Container(
              width: Standards.getPostUserNameAndTitleBoxWidth(),
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
      );
    // --------------------
  }
  // -----------------------------------------------------------------------------
}

class _TimelineCornerBox extends StatelessWidget {
  // -----------------------------------------------------------------------------
  const _TimelineCornerBox({
    @required this.isFirst,
    @required this.isLast,
    Key key
  }) : super(key: key);
  // -----------------------------------------------------------------------------
  final bool isFirst;
  final bool isLast;
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return SizedBox(
        width: Standards.timelineMinTileWidth,
        height: Standards.timelineMinTileHeight,
        child: Stack(
          alignment: Alignment.topLeft,
          children: <Widget>[

            /// VERTICAL LINE
            VerticalLineLayer(
              height: Standards.timelineMinTileHeight,
              topPadding: Standards.getTimelineVerticalLineTopPadding(
                  isFirst: isFirst,
              ),
            ),

            /// HORIZONTAL LINE
            Container(
              width: Standards.timelineMinTileWidth,
              height: Standards.timelineMinTileHeight,
              alignment: Alignment.topLeft,
              child: Container(
                width: Standards.timelineHorizontalLineWidth,
                height: Standards.timelineLineThickness,
                color: Standards.timelineLineColor,
                margin: const EdgeInsets.only(
                  left: Standards.timelineHorizontalLineLeftMargin,
                  top: Standards.timelineHorizontalLineTopMargin,
                ),
              ),
            ),

            /// QUARTER CIRCLE
            Padding(
              padding: const EdgeInsets.only(
                left: Standards.timelineSideMargin,
                top: Standards.timelineHorizontalLineTopMargin,
              ),
              child: Material(
                  shape: SegmentedCircleBorder(
                      // offset: 0, // this rotates segments anticlockwise from top quadrant
                      numberOfSegments: 4,
                      sides: const <BorderSide>[
                        BorderSide(color: Colorz.nothing, width: 0),
                        BorderSide(color: Colorz.nothing, width: 0),
                        BorderSide(color: Standards.timelineLineColor, width: Standards.timelineLineThickness),
                        BorderSide(color: Colorz.nothing, width: 0),
                      ]),
                  child: Container(
                    width: Standards.timelineLineRadius * 2,
                    height: Standards.timelineLineRadius * 2,
                    color: Colorz.nothing,
                  ))
              ,
            ),

            /// DAY
            const Positioned(
              top: Standards.timelineDayTopMargin,
              left: Standards.timelineDayLeftMargin,
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
              top: Standards.timelineMonthTopMargin,
              left: Standards.timelineDayLeftMargin,
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
              width: Standards.timelineLastDotSize,
              height: Standards.timelineLastDotSize,
              margin: const EdgeInsets.only(
                top: Standards.timelineLastDotToMargin,
                left: Standards.timelineLastDotLeftMargin,
              ),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(Standards.timelineLastDotSize/2)),
                color: Standards.timelineLineColor,
              ),
            ),

          ],
        ),
      );

  }
  // -----------------------------------------------------------------------------
}

class _TimeLineBody extends StatelessWidget {
  // -----------------------------------------------------------------------------
  const _TimeLineBody({
    @required this.isLast,
    @required this.onLike,
    @required this.onView,
    Key key
  }) : super(key: key);
  // -----------------------------------------------------------------------------
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
    final double _postBubbleWidth = Standards.getTimelinePostBubbleWidth();
    final double _bubbleHeight = Standards.getPostBubbleHeight();
    // --------------------
    return Row(
        children: <Widget>[

          /// TIMELINE LINE
          VerticalLineLayer(
            height: Standards.getTimelineBodyHeight(),
            isOn: !isLast,
          ),

          /// POST BUBBLE
          Padding(
            padding: const EdgeInsets.only(
              left: Standards.postBubbleMargin,
              bottom: Standards.postBubbleMargin,
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
                  height: Standards.postButtonsHeight,
                  // color: Colorz.yellow125,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[

                      /// VIEWS
                      const TalkBox(
                        height: Standards.postButtonsHeight,
                        icon: Iconz.viewsIcon,
                        text: '12.2M views',
                        iconSizeFactor: 0.5,
                        textScaleFactor: 0.7 / 0.5,
                        bubble: false,
                      ),

                      /// LIKES
                      TalkBox(
                        height: Standards.postButtonsHeight,
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
      );
    // --------------------
  }
  // -----------------------------------------------------------------------------
}
