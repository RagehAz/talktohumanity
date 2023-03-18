import 'package:bldrs_theme/bldrs_theme.dart';
import 'package:bubbles/bubbles.dart';
import 'package:flutter/material.dart';
import 'package:layouts/layouts.dart';
import 'package:scale/scale.dart';
import 'package:super_image/super_image.dart';
import 'package:talktohumanity/services/helper_methods.dart';
import 'package:talktohumanity/views/widgets/basics/main_button.dart';

class BriefPostCreatorView extends StatelessWidget {
  // -----------------------------------------------------------------------------
  const BriefPostCreatorView({
    @required this.bodyController,
    @required this.onPublish,
    @required this.onSkip,
    Key key
  }) : super(key: key);
  // -----------------------------------------------------------------------------
  final TextEditingController bodyController;
  final Function onSkip;
  final Function onPublish;
  // -----------------------------------------------------------------------------
  static double getBubbleWidth(){
    final double _screenWidth = Scale.screenWidth(getContext());
    return _screenWidth - 20;
  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final double _screenWidth = Scale.screenWidth(context);
    final double _screenHeight = Scale.screenHeight(context);
    final double _bubbleWidth = BriefPostCreatorView.getBubbleWidth();

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

              /// POST BODY FIELD
              TextFieldBubble(
                bubbleHeaderVM: const BubbleHeaderVM(
                  headlineText: 'My Message',
                  headlineHeight: 18,
                  headlineColor: Colorz.white200
                ),
                bubbleWidth: _bubbleWidth,
                textController: bodyController,
                maxLines: 6,
                // maxLength: 10000,
                keyboardTextInputType: TextInputType.multiline,
                fieldTextFont: BldrsThemeFonts.fontBldrsBodyFont,
                hintText: '...',
                bulletPointsFont: BldrsThemeFonts.fontBldrsBodyFont,
                minLines: 6,
                fieldTextCentered: true,
                fieldTextHeight: 27,
              ),

              /// BUTTONS
              Container(
                width: _screenWidth,
                height: 50,
                margin: const EdgeInsets.only(
                  top: 5,
                ),
                padding: const EdgeInsets.only(
                  left: 10,
                  right: 10,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[

                    /// SKIP
                    MainButton(
                      text: "I'm not\nready",
                      onTap: onSkip,
                      color: Colorz.white20,
                      textColor: Colorz.white255,
                      smallText: true,
                    ),

                    /// PUBLISH
                    MainButton(
                      text: 'Next',
                      onTap: onPublish,
                      color: Colorz.yellow255,
                    ),

                  ],
                ),
              ),

              /// LIST PUSHER
              const KeyboardPusher(),

            ],
          ),
        ),

      ],
    );

  }
  // -----------------------------------------------------------------------------
}
