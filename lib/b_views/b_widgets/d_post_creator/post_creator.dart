import 'package:bldrs_theme/bldrs_theme.dart';
import 'package:bubbles/bubbles.dart';
// import 'package:bubbles/bubbles.dart';
import 'package:flutter/material.dart';
import 'package:layouts/layouts.dart';
import 'package:scale/scale.dart';
import 'package:stringer/stringer.dart';
import 'package:super_image/super_image.dart';
import 'package:talktohumanity/d_helpers/helper_methods.dart';
import 'package:talktohumanity/b_views/b_widgets/a_buttons/talk_box.dart';

class PostCreatorView extends StatelessWidget {
  // -----------------------------------------------------------------------------
  const PostCreatorView({
    @required this.titleController,
    @required this.bodyController,
    @required this.onPublish,
    @required this.onSkip,
    @required this.canErrorize,
    @required this.onSwitchTitle,
    @required this.titleIsOn,
    Key key
  }) : super(key: key);
  // -----------------------------------------------------------------------------
  final TextEditingController titleController;
  final TextEditingController bodyController;
  final Function onSkip;
  final Function onPublish;
  final bool canErrorize;
  final bool titleIsOn;
  final Function(bool isOn) onSwitchTitle;
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
    final double _bubbleWidth = PostCreatorView.getBubbleWidth();

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
          alignment: Alignment.topCenter,
          child: FloatingList(
            physics: const NeverScrollableScrollPhysics(),
            mainAxisAlignment: MainAxisAlignment.start,
            columnChildren: <Widget>[

              // const SizedBox(
              //   height: 10,
              // ),

              /// POST TITLE FIELD
              TextFieldBubble(
                bubbleHeaderVM: BubbleHeaderVM(
                  headlineText: 'Title',
                  headlineHeight: 18,
                  headlineColor: titleIsOn == true ? Colorz.white200 : Colorz.white80,
                  switchValue: titleIsOn,
                  hasSwitch: true,
                  onSwitchTap: onSwitchTitle,
                  switchTrackColor: Colorz.white80,
                  switchDisabledColor: Colorz.black200,
                  // switchActiveColor: Colorz.white255,
                  // appIsLTR: true,
                  // textDirection: TextDirection.ltr,
                  font: BldrsThemeFonts.fontBldrsBodyFont,
                  switchDisabledTrackColor: Colorz.white20,
                ),
                bubbleWidth: _bubbleWidth,
                textController: titleController,
                bubbleColor: titleIsOn == true ? Colorz.white10 : Colorz.nothing,
                maxLines: 2,
                // maxLength: 10000,
                keyboardTextInputType: TextInputType.multiline,
                fieldTextFont: BldrsThemeFonts.fontBldrsHeadlineFont,
                hintText: '...',
                bulletPointsFont: BldrsThemeFonts.fontBldrsBodyFont,
                // minLines: 1,
                fieldTextCentered: true,
                fieldTextHeight: 37,
                isDisabled: !titleIsOn,
              ),

              /// POST BODY FIELD
              TextFieldBubble(
                isFormField: true,
                bubbleHeaderVM: BubbleHeaderVM(
                  headlineText: titleIsOn ? 'Message' : 'Body',
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
                autoValidate: canErrorize,
                canErrorize: canErrorize,
                validator: (String text){

                  if (TextCheck.isEmpty(text) == true){
                    return 'Write your message to the world';
                  }
                  else {
                    return null;
                  }

                },
              ),

              /// BUTTONS
              Container(
                width: _screenWidth,
                height: 50,
                margin: const EdgeInsets.only(top: 5,),
                padding: const EdgeInsets.only(left: 10, right: 10,),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[

                    /// PUBLISH
                    TalkBox(
                      width: 100,
                      height: 50,
                      textScaleFactor: 0.8,
                      text: 'Next',
                      // color: Colorz.white255,
                      // textColor: Colorz.black255,
                      isBold: true,
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
