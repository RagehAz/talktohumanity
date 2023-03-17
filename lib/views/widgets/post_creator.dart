import 'package:bldrs_theme/bldrs_theme.dart';
import 'package:bubbles/bubbles.dart';
import 'package:flutter/material.dart';
import 'package:scale/scale.dart';
import 'package:super_image/super_image.dart';
import 'package:talktohumanity/views/widgets/basics/talk_box.dart';

class PostCreatorView extends StatelessWidget {
  // -----------------------------------------------------------------------------
  const PostCreatorView({
    @required this.titleController,
    @required this.bodyController,
    @required this.onPublish,
    @required this.onSkip,
    Key key
  }) : super(key: key);
  // -----------------------------------------------------------------------------
  final TextEditingController titleController;
  final TextEditingController bodyController;
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
                    headlineText: 'Title',
                    headlineHeight: 18,
                    headlineColor: Colorz.white200,
                ),
                bubbleWidth: _bubbleWidth,
                textController: titleController,
                maxLines: 2,
                // maxLength: 10000,
                keyboardTextInputType: TextInputType.multiline,
                fieldTextFont: BldrsThemeFonts.fontBldrsHeadlineFont,
                hintText: '...',
                bulletPointsFont: BldrsThemeFonts.fontBldrsBodyFont,
                minLines: 2,
                fieldTextCentered: true,
                fieldTextHeight: 37,
              ),

              /// TEST FIELD
              TextFieldBubble(
                bubbleHeaderVM: const BubbleHeaderVM(
                  headlineText: 'Body',
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
                    TalkBox(
                      width: 100,
                      height: 50,
                      textScaleFactor: 0.7,
                      text: "I'm not\nready",
                      onTap: onSkip,
                      textMaxLines: 2,
                      color: Colorz.white20,
                      textFont: BldrsThemeFonts.fontBldrsBodyFont,
                      textItalic: true,
                    ),

                    /// PUBLISH
                    TalkBox(
                      width: 100,
                      height: 50,
                      textScaleFactor: 0.8,
                      text: 'Publish',
                      onTap: onPublish,
                      color: Colorz.yellow255,
                      textColor: Colorz.black255,
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
