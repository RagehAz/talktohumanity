import 'package:animators/animators.dart';
import 'package:bldrs_theme/bldrs_theme.dart';
import 'package:flutter/material.dart';
import 'package:layouts/layouts.dart';
import 'package:numeric/numeric.dart';
import 'package:scale/scale.dart';
import 'package:segmented_circle_border/segmented_circle_border.dart';
import 'package:talktohumanity/a_models/post_model.dart';
import 'package:talktohumanity/c_protocols/post_ldb_ops.dart';
import 'package:talktohumanity/d_helpers/helper_methods.dart';
import 'package:talktohumanity/d_helpers/standards.dart';
import 'package:talktohumanity/b_views/b_widgets/a_buttons/talk_box.dart';
import 'package:talktohumanity/b_views/b_widgets/b_texting/talk_text.dart';
import 'package:talktohumanity/b_views/b_widgets/a_buttons/expander_button/b_expanding_tile.dart';
import 'package:talktohumanity/b_views/b_widgets/e_timeline/vertical_timeline_line.dart';

class TimelineTile extends StatelessWidget {
  // -----------------------------------------------------------------------------
  const TimelineTile({
    @required this.isFirst,
      @required this.post,
      @required this.isLast,
      @required this.onLike,
      @required this.onView,
      @required this.firstIsExpanded,
      @required this.onDoubleTap,
      Key key
  }) : super(key: key);
  // -----------------------------------------------------------------------------
  final bool isFirst;
  final PostModel post;
  final bool isLast;
  final Function onLike;
  final Function onView;
  final bool firstIsExpanded;
  final Function onDoubleTap;
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
      onTileDoubleTap: onDoubleTap,
      onTileTap: (bool expanded) {
        // blog('post : ${post.id} is expanded : $expanded');

        if (expanded == true && onView != null) {
          onView();
        }
      },
      maxHeight: Standards.getMaxTimelineTileHeight(),

      /// NAME - PIC - TITLE : TILE
      tileBox: _TimelineHeadline(
        post: post,
      ),

      /// SIDE BOX
      sideBox: _TimelineCornerBox(
        isFirst: isFirst,
        isLast: isLast,
        time: post.time,
      ),

      /// BODY
      child: _TimeLineBody(
        onView: onView,
        onLike: onLike,
        isLast: isLast,
        post: post,
      ),
    );
    // --------------------
  }
  // -----------------------------------------------------------------------------
}

class _TimelineHeadline extends StatelessWidget {
  // -----------------------------------------------------------------------------
  const _TimelineHeadline({
    @required this.post,
    Key key
  }) : super(key: key);
  // -----------------------------------------------------------------------------
  final PostModel post;
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
          TalkBox(
            width: Standards.timelinePicSize,
            height: Standards.timelinePicSize,
            corners: Standards.timelinePicSize * 0.5,
            icon: post.pic,
            isBold: true,
            margins: const EdgeInsets.only(
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
              children: <Widget>[

                /// FIRST HEADLINE
                TalkText(
                  text: post.name,
                  centered: false,
                  // maxLines: 1,
                  textHeight: 25,
                  isBold: true,
                ),

                /// SECOND HEADLINE
                TalkText(
                  text: post.bio,
                  isBold: false,
                  italic: true,
                  textHeight: 20,
                  textColor: Colorz.white125,
                  maxLines: 2,
                  centered: false,
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
  const _TimelineCornerBox(
      {@required this.isFirst, @required this.isLast, @required this.time, Key key})
      : super(key: key);

  // -----------------------------------------------------------------------------
  final bool isFirst;
  final bool isLast;
  final DateTime time;

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
                      BorderSide(
                          color: Standards.timelineLineColor,
                          width: Standards.timelineLineThickness),
                      BorderSide(color: Colorz.nothing, width: 0),
                    ]),
                child: Container(
                  width: Standards.timelineLineRadius * 2,
                  height: Standards.timelineLineRadius * 2,
                  color: Colorz.nothing,
                )),
          ),

          /// DAY
          Positioned(
            top: Standards.timelineDayTopMargin,
            left: Standards.timelineDayLeftMargin,
            child: TalkText(
              text: time.day.toString(),
              textHeight: 25,
              isBold: true,
              // boxColor: Colorz.bloodTest,
              centered: false,
              letterSpacing: 1,
            ),
          ),

          /// MONTH
          Positioned(
            top: Standards.timelineMonthTopMargin,
            left: Standards.timelineDayLeftMargin,
            child: TalkText(
              text: getMonthName(
                month: time.month,
                shortForm: true,
              ),
              textHeight: 17,
              isBold: false,
              // boxColor: Colorz.bloodTest,
              centered: false,
              letterSpacing: 1,
            ),
          ),

          // /// LAST POST DOT
          // if (isLast)
          // Container(
          //   width: Standards.timelineLastDotSize,
          //   height: Standards.timelineLastDotSize,
          //   margin: const EdgeInsets.only(
          //     top: Standards.timelineLastDotToMargin,
          //     left: Standards.timelineLastDotLeftMargin,
          //   ),
          //   decoration: const BoxDecoration(
          //     borderRadius: BorderRadius.all(Radius.circular(Standards.timelineLastDotSize/2)),
          //     color: Standards.timelineLineColor,
          //   ),
          // ),
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
    @required this.post,
    Key key
  }) : super(key: key);
  // -----------------------------------------------------------------------------
  final bool isLast;
  final Function onLike;
  final Function onView;
  final PostModel post;
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
          // isOn: true,
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

                        /// HEADLINE
                        TalkText(
                          text: post.headline,
                          textHeight: 35,
                          margins: 10,
                          maxLines: 2,
                          isBold: true,
                        ),

                        /// BODY
                        TalkText(
                          text: post.body,
                          maxLines: 50000,
                          isBold: false,
                          textHeight: 25,
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
                    TalkBox(
                      height: Standards.postButtonsHeight,
                      icon: Iconz.viewsIcon,
                      text: '${Numeric.formatNumToCounterCaliber(x: post.views)} views',
                      iconSizeFactor: 0.5,
                      textScaleFactor: 0.7 / 0.5,
                      bubble: false,
                      isBold: true,
                      color: Colorz.nothing,
                      textColor: Colorz.white255,
                    ),

                    /// LIKES
                    FutureBuilder(
                        future: PostLDBPOps.checkIsInserted(
                          post: post,
                          docName: PostLDBPOps.myLikes,
                        ),
                        initialData: false,
                        builder: (_, AsyncSnapshot<bool> snap) {
                          final bool _isLiked = snap.data;

                          final String _likesCount = Numeric.formatNumToCounterCaliber(
                              x: post.likes
                          );

                          return TalkBox(
                            height: Standards.postButtonsHeight,
                            icon: Iconz.save,
                            isBold: true,
                            text: '$_likesCount likes',
                            iconSizeFactor: 0.7,
                            // textScaleFactor: 0.7 / 0.7,
                            onTap: onLike,
                            color: _isLiked == true ? Colorz.white255 : Colorz.nothing,
                            textColor: _isLiked == true ? Colorz.black255 : Colorz.white255,
                            iconColor: _isLiked == true ? Colorz.black255 : Colorz.white255,
                          );
                        }
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