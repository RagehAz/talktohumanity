import 'package:bldrs_theme/bldrs_theme.dart';
import 'package:flutter/material.dart';
import 'package:scale/scale.dart';
import 'package:talktohumanity/c_services/helpers/helper_methods.dart';
import 'package:super_fire/super_fire.dart';

class Standards {
  // -----------------------------------------------------------------------------

  Standards();

  // -----------------------------------------------------------------------------
  static const String ragehID = '1zVOGp4iQXbTVsXydDNYkRMN8Iv1';
  // -----------------------------------------------------------------------------
  static const SocialKeys talkToHumanitySocialKeys = SocialKeys(

      /// GET FACEBOOK ID FROM FACEBOOK DEV DASHBOARD
      facebookAppID: '727816559045136',

      /// GET CLIENT_ID TAG FROM GoogleService-info.plist
      googleClientID: '569221317127-apg6rskk26v2mbkccslo2nqughb75h8r.apps.googleusercontent.com',
      supportApple: true,
      supportEmail: true);
  // -----------------------------------------------------------------------------
  static bool isRageh(){
    return Authing.getUserID() == ragehID;
  }
  // -----------------------------------------------------------------------------
  static const double timelineSideMargin = 10;
  static const double timelineLineThickness = 2;
  // --------------------
  static const double timelineMinTileHeight = 80;
  static const double timelineMinTileWidth = 50;
  static const Color timelineLineColor = Colorz.white255;
  static const double timelineLineRadius = 10;
  static const double timelinePicSize = 40;
  // --------------------
  static const Duration homeViewFadeDuration = Duration(seconds: 2);
  // --------------------
  static double getMaxTimelineTileHeight() {
    final double _screenHeight = Scale.screenHeightGross(getContext());
    return _screenHeight - 200;
  }
  // --------------------
  static double getTimelineUserBoxWidth(){
    final double _screenWidth = Scale.screenShortestSide(getContext());
    return _screenWidth - timelineMinTileWidth;
  }
  // --------------------
  static const double timelineHeadlineHeight = 30;
  static const double timelineHeadlineTopMargin = 30;
  // --------------------
  static const double yearBulletHeight = Standards.timelinePicSize * 0.5;
  static const double yearBulletCorner = yearBulletHeight * 0.35;

  static double getTimelineHeadlineHeightWithMargin(){
    return yearBulletHeight + timelineHeadlineTopMargin;
  }
  // --------------------
  static double getTimeLineTopMostMargin(){
    final double _screenHeight = Scale.screenHeightGross(getContext());

    return _screenHeight
        - getMaxTimelineTileHeight()
        - getTimelineHeadlineHeightWithMargin()
        - timelineMinTileHeight;
  }
  // --------------------
  static double getTimelinePostBubbleWidth(){
    final double _tileUserBoxWidth = getTimelineUserBoxWidth();
    return _tileUserBoxWidth - postBubbleTotalMargins;
  }
  // --------------------
  static const double postBubbleMargin = 10;
  static const double postBubbleTotalMargins = postBubbleMargin * 2;
  static const double postButtonsHeight = 40;
  // --------------------
  static double getPostBubbleHeight(){
    final double _maxTileHeight = getMaxTimelineTileHeight();
    return  _maxTileHeight
          - timelineMinTileHeight
          - postBubbleTotalMargins
          - postButtonsHeight;
  }
  // --------------------
  static const double postUserPicTopMargin =  timelineHorizontalLineTopMargin
                                            - (timelinePicSize / 2)
                                            + (timelineLineThickness * 0.5);
  // --------------------
  static double getPostUserNameAndTitleBoxWidth(){
    final double _tileUserBoxWidth = getTimelineUserBoxWidth();
    return _tileUserBoxWidth - timelinePicSize - timelineSideMargin;
  }
  // --------------------
  static double getTimelineVerticalLineTopPadding({
    @required bool isFirst,
  }) {

    if (isFirst == true) {
      return timelineHorizontalLineTopMargin + timelineLineRadius;
    }

    else {
      return 0;
    }

  }
  // --------------------
  static double timelineHorizontalLineWidth = timelineMinTileWidth
                                            - timelineSideMargin
                                            - timelineLineRadius;
  // --------------------
  static const double timelineHorizontalLineLeftMargin = timelineSideMargin
                                                        + timelineLineRadius;
  // --------------------
  static const timelineHorizontalLineTopMargin = timelineSideMargin * 3;
  // --------------------
  static const double timelineDayLeftMargin = timelineSideMargin
                                            + timelineLineThickness
                                            + timelineLineRadius;
  // --------------------
  static const double timelineDayTopMargin = 7;
  // --------------------
  static const double timelineMonthTopMargin = Standards.timelineHorizontalLineTopMargin + 3;
  // --------------------
  static const double timelineLastDotSize = 10;
  static const double timelineLastDotToMargin = timelineMinTileHeight - timelineLastDotSize;
  static const double timelineLastDotLeftMargin = timelineSideMargin
                                                - (timelineLastDotSize / 2)
                                                + (timelineLineThickness / 2);
  // --------------------
  static double getTimelineBodyHeight(){
    final double _maxTileHeight = getMaxTimelineTileHeight();
    return _maxTileHeight - Standards.timelineMinTileHeight;
  }
  // -----------------------------------------------------------------------------
}
