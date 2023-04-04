import 'package:bldrs_theme/bldrs_theme.dart';
import 'package:flutter/material.dart';
import 'package:layouts/layouts.dart';
import 'package:scale/scale.dart';
import 'package:stringer/stringer.dart';
import 'package:talktohumanity/b_views/b_widgets/a_buttons/talk_box.dart';
import 'package:talktohumanity/b_views/b_widgets/b_texting/talk_text_field.dart';

class PostCreatorView extends StatelessWidget {
  // -----------------------------------------------------------------------------
  const PostCreatorView({
    @required this.titleController,
    @required this.bodyController,
    @required this.onPublish,
    @required this.onBack,
    @required this.canErrorize,
    @required this.onSwitchTitle,
    @required this.titleIsOn,
    Key key
  }) : super(key: key);
  // -----------------------------------------------------------------------------
  final TextEditingController titleController;
  final TextEditingController bodyController;
  final Function onBack;
  final Function onPublish;
  final bool canErrorize;
  final bool titleIsOn;
  final Function(bool isOn) onSwitchTitle;
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final double _shortest = Scale.screenShortestSide(context);
    final double _screenHeight = Scale.screenHeight(context);

    return Container(
      width: _shortest,
      height: _screenHeight,
      alignment: Alignment.topCenter,
      child: FloatingList(
        // physics: const BouncingScrollPhysics(),
        mainAxisAlignment: MainAxisAlignment.start,
        columnChildren: <Widget>[

          // const SizedBox(
          //   height: 10,
          // ),

          /// POST TITLE FIELD
          TalkTextField(
            headlineText: 'Message Title',
            textController: titleController,
            hasSwitch: true,
            onSwitchTap: onSwitchTitle,
            fieldTextHeight: 37,
            isDisabled: !titleIsOn,
          ),

          /// POST BODY FIELD
          TalkTextField(
            headlineText: 'Message',
            textController: bodyController,
            minLines: 6,
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
            width: _shortest,
            height: 50,
            margin: const EdgeInsets.only(top: 5,),
            padding: const EdgeInsets.only(left: 10, right: 10,),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                /// GO BACK
                TalkBox(
                  // width: 200,
                  height: 50,
                  text: 'Back',
                  color: Colorz.white10,
                  textColor: Colorz.white255,
                  icon: Iconz.arrowLeft,
                  iconSizeFactor: 0.3,
                  textScaleFactor: 0.6 / 0.3,
                  iconColor: Colorz.white255,
                  // textColor: Colorz.black255,
                  isBold: true,
                  textCentered: false,
                  onTap: onBack,
                ),
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
        );

  }
  // -----------------------------------------------------------------------------
}
