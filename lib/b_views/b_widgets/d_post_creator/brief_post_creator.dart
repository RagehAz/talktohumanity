import 'package:bldrs_theme/bldrs_theme.dart';
import 'package:bubbles/bubbles.dart';
import 'package:flutter/material.dart';
import 'package:layouts/layouts.dart';
import 'package:scale/scale.dart';
import 'package:stringer/stringer.dart';
import 'package:super_image/super_image.dart';
import 'package:talktohumanity/d_helpers/helper_methods.dart';
import 'package:talktohumanity/b_views/b_widgets/a_buttons/main_button.dart';
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

    final double _screenWidth = Scale.screenWidth(context);
    final double _screenHeight = Scale.screenHeight(context);
    final double _bubbleWidth = BriefPostCreatorView.getBubbleWidth();

    return Stack(
      alignment: Alignment.center,
      children: <Widget>[

        /// BACKGROUND WORLD
        Opacity(
          opacity: 1,
          child: SuperImage(
            height: _screenWidth * 1.2,
            width: _screenWidth * 1.2,
            pic: TalkTheme.logo_night,
          ),
        ),

        /// BUBBLE
        SizedBox(
          width: _screenWidth,
          height: _screenHeight,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[

              /// POST BODY FIELD
              Form(
                key: formKey,
                child: TextFieldBubble(
                  isFormField: true,
                  bubbleHeaderVM: const BubbleHeaderVM(
                    headlineText: 'My Message to the world',
                    headlineHeight: 18,
                    headlineColor: Colorz.white200
                  ),
                  bubbleWidth: _bubbleWidth,
                  bubbleColor: Colorz.nothing,
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
                  canErrorize: canErrorize,
                  autoValidate: canErrorize,
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
                      text: "I'm not ready\nfor this responsibility",
                      onTap: onSkip,
                      color: Colorz.white20,
                      textColor: Colorz.white255,
                      smallText: true,
                      width: 170,
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
        ),

      ],
    );

  }
  // -----------------------------------------------------------------------------
}
