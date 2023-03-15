import 'package:bldrs_theme/bldrs_theme.dart';
import 'package:bubbles/bubbles.dart';
import 'package:flutter/material.dart';
import 'package:scale/scale.dart';
import 'package:super_image/super_image.dart';
import 'package:talktohumanity/views/widgets/basics/talk_box.dart';

class PostCreatorView extends StatelessWidget {
  // -----------------------------------------------------------------------------
  const PostCreatorView({
    @required this.controller,
    @required this.onPublish,
    @required this.onSkip,
    Key key
  }) : super(key: key);
  // -----------------------------------------------------------------------------
  final TextEditingController controller;
  final Function onSkip;
  final Function onPublish;
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final double _screenWidth = Scale.screenWidth(context);
    final double _screenHeight = Scale.screenHeight(context);
    final double _bubbleWidth = _screenWidth - 20;

    return Stack(
      alignment: Alignment.center,
      children: <Widget>[

        /// BACKGROUND WORLD
        Opacity(
          opacity: 0.3,
          child: SuperImage(
            height: _screenWidth * 1.2,
            width: _screenWidth * 1.2,
            pic: Iconz.contAfrica,
          ),
        ),

        /// BUBBLE
        Container(
          width: _screenWidth,
          height: _screenHeight,
          color: Colorz.black200,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              /// TEST FIELD
              TextFieldBubble(
                bubbleHeaderVM: const BubbleHeaderVM(
                  headlineText: 'A message to the world',
                ),
                bubbleWidth: _bubbleWidth,
                textController: controller,
                maxLines: 1000,
                maxLength: 10000,
                keyboardTextInputType: TextInputType.multiline,
                bulletPoints: const [
                  'You can say absolutely anything',
                ],
                fieldTextFont: BldrsThemeFonts.fontBldrsBodyFont,
                hintText: '...',
                bulletPointsFont: BldrsThemeFonts.fontBldrsBodyFont,
                counterIsOn: true,
                minLines: 10,
              ),

              /// BUTTONS
              SizedBox(
                width: _screenWidth,
                height: 100,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    /// SKIP
                    TalkBox(
                      height: 60,
                      text: 'Skip',
                      margins: 10,
                      onTap: onPublish,
                    ),

                    /// PUBLISH
                    TalkBox(
                      height: 60,
                      text: 'Publish',
                      margins: 10,
                      onTap: onSkip,
                    ),

                  ],
                ),
              ),
            ],
          ),
        ),

      ],
    );
  }
  // -----------------------------------------------------------------------------
}
