import 'package:bldrs_theme/bldrs_theme.dart';
import 'package:flutter/material.dart';
import 'package:scale/scale.dart';
import 'package:super_image/super_image.dart';
import 'package:talktohumanity/b_views/b_widgets/b_texting/talk_text.dart';
import 'package:talktohumanity/d_helpers/talk_theme.dart';

class PlanetPageView extends StatelessWidget {
  // --------------------------------------------------------------------------
  const PlanetPageView({
    @required this.text,
    @required this.icon,
    @required this.onTap,
    this.onLongPress,
    Key key
  }) : super(key: key);
  // --------------------------------------------------------------------------
  final String text;
  final String icon;
  final Function onLongPress;
  final Function onTap;
  // --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final double _screenWidth = Scale.screenWidth(context);
    final double _screenHeight = Scale.screenHeight(context);

    return GestureDetector(
      onTap: onTap,
      onLongPress: onLongPress,
      child: Container(
        width: _screenWidth,
        height: _screenHeight,
        color: Colorz.black200,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[

            SuperImage(
              height: 100,
              width: 100,
              pic: icon,
            ),

            const SizedBox(
              width: 10,
              height: 20,
            ),

            TalkText(
              boxWidth: _screenWidth * 0.7,
              textHeight: 30,
              text: text,
              font: TalkTheme.talkFont,
              // italic: true,
              margins: 10,
              maxLines: 15,
            ),

          ],
        ),
      ),
    );
  }
  // --------------------------------------------------------------------------
}
