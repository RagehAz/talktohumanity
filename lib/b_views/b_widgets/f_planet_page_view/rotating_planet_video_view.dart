import 'package:flutter/material.dart';
import 'package:mediators/super_video_player/super_video_player.dart';
import 'package:scale/scale.dart';
import 'package:talktohumanity/c_services/helpers/talk_theme.dart';
import 'package:widget_fader/widget_fader.dart';

class RotatingPlanetVideo extends StatelessWidget {
  // --------------------------------------------------------------------------
  const RotatingPlanetVideo({
    Key key
  }) : super(key: key);
  // --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    final double _longSide = Scale.screenLongestSide(context);
    // --------------------
    return WidgetFader(
      fadeType: FadeType.fadeIn,
      duration: const Duration(seconds: 5),
      child: OverflowBox(
        maxWidth: _longSide,
        maxHeight: _longSide,
        child: SuperVideoPlayer(
          width: _longSide,
          aspectRatio: 1,
          autoPlay: true,
          asset: TalkTheme.earthLoop,
          loop: true,
        ),
      ),
    );
    // --------------------
  }
  // --------------------------------------------------------------------------
}