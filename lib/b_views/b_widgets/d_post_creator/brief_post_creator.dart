import 'package:bldrs_theme/bldrs_theme.dart';
import 'package:flutter/material.dart';
import 'package:layouts/layouts.dart';
import 'package:scale/scale.dart';
import 'package:stringer/stringer.dart';
import 'package:super_image/super_image.dart';
import 'package:talktohumanity/b_views/b_widgets/a_buttons/main_button.dart';
import 'package:talktohumanity/b_views/b_widgets/b_texting/talk_text_field.dart';
import 'package:talktohumanity/d_helpers/helper_methods.dart';
import 'package:talktohumanity/d_helpers/talk_theme.dart';

class BriefPostCreatorView extends StatelessWidget {
  // -----------------------------------------------------------------------------
  const BriefPostCreatorView({
    @required this.bodyController,
    @required this.onPublish,
    @required this.onSkip,
    @required this.canErrorize,
    @required this.formKey,
    Key key
  }) : super(key: key);
  // -----------------------------------------------------------------------------
  final TextEditingController bodyController;
  final Function onSkip;
  final Function onPublish;
  final bool canErrorize;
  final GlobalKey<FormState> formKey;
  // -----------------------------------------------------------------------------
  static double getBubbleWidth(){
    final double _screenWidth = Scale.screenWidth(getContext());
    return _screenWidth - 20;
  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final double _shortest = Scale.screenShortestSide(context);

    return Stack(
      alignment: Alignment.center,
      children: <Widget>[

        /// BACKGROUND WORLD
        Opacity(
          opacity: 0.3,
          child: SuperImage(
            height: _shortest * 0.7,
            width: _shortest * 0.7,
            pic: TalkTheme.logo_night,
          ),
        ),

        /// BUBBLE
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[

            /// POST BODY FIELD
            Form(
              key: formKey,
              child: TalkTextField(
                bubbleWidth: _shortest * 0.8,
                headlineText: 'My Message to the world',
                bubbleColor: Colorz.nothing,
                textController: bodyController,
                minLines: 6,
                canErrorize: canErrorize,
                validator: (String text){

                  if (TextCheck.isEmpty(text) == true){
                    return 'Write your message here';
                  }
                  else {
                    return null;
                  }

                },
              ),
            ),

            /// BUTTONS
            Container(
              width: _shortest * 0.8,
              height: MainButton.height,
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
                    text: "I'm not ready\nfor this responsibility",
                    onTap: onSkip,
                    color: Colorz.white20,
                    textColor: Colorz.white255,
                    smallText: true,
                    width: _shortest * 0.4,
                  ),

                  /// PUBLISH
                  MainButton(
                    text: 'Next',
                    onTap: onPublish,
                  ),

                ],
              ),
            ),

            /// LIST PUSHER
            const KeyboardPusher(),

          ],
        ),

      ],
    );

  }
  // -----------------------------------------------------------------------------
}
