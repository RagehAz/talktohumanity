import 'dart:typed_data';
import 'package:bldrs_theme/bldrs_theme.dart';
import 'package:bubbles/bubbles.dart';
import 'package:flutter/material.dart';
import 'package:layouts/layouts.dart';
import 'package:scale/scale.dart';
import 'package:super_box/super_box.dart';
import 'package:super_text_field/super_text_field.dart';
import 'package:talktohumanity/views/widgets/basics/talk_box.dart';
import 'package:talktohumanity/views/widgets/basics/talk_text.dart';
import 'package:talktohumanity/views/widgets/post_creators/post_creator.dart';

class UserCreatorView extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const UserCreatorView({
    @required this.nameController,
    @required this.bioController,
    @required this.emailController,
    @required this.imageBytes,
    @required this.onPickImage,
    @required this.onPublish,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController bioController;
  final Uint8List imageBytes;
  final Function onPickImage;
  final Function onPublish;
  // --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    final double _bubbleWidth = PostCreatorView.getBubbleWidth();
    const double _fieldTextHeight = 35;
    final double _imageSize = SuperTextFieldController.getFieldHeight(
        context: context,
        minLines: 1,
        textHeight: _fieldTextHeight,
        withBottomMargin: true,
        withCounter: false,
        textPadding: const EdgeInsets.all(10),
    );
    const double _imageBubbleWidth = 110;
    // --------------------
    final double _screenWidth = Scale.screenWidth(context);
    // --------------------
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[

        const DotSeparator(bottomMarginIsOn: false),

        const TalkText(
          text: 'Add more info about you',
          textHeight: 40,
        ),

        const DotSeparator(),

        /// IMAGE + NAME
        Center(
          child: SizedBox(
            width: _bubbleWidth,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                // const SizedBox(
                //   width: 5,
                //   height: 5,
                // ),

                Bubble(
                  bubbleColor: Colorz.white20,
                  width: _imageBubbleWidth,
                  bubbleHeaderVM: const BubbleHeaderVM(
                      headlineText: 'Picture',
                      headlineHeight: 18,
                      headlineColor: Colorz.white200,
                      redDot: true),
                  childrenCentered: true,
                  columnChildren: <Widget>[
                    /// USER IMAGE
                    SuperBox(
                      width: _imageSize,
                      height: _imageSize,
                      icon: imageBytes,
                      onTap: onPickImage,
                      corners: _imageSize / 2,
                      margins: const EdgeInsets.only(bottom: 10),
                    ),
                  ],
                ),

                /// NAME FIELD
                TextFieldBubble(
                  bubbleColor: Colorz.white20,
                  bubbleHeaderVM: const BubbleHeaderVM(
                      headlineText: 'Name',
                      headlineHeight: 18,
                      headlineColor: Colorz.white200,
                      redDot: true),
                  bubbleWidth: _bubbleWidth - _imageBubbleWidth - 10,
                  textController: nameController,
                  // maxLength: 10000,
                  keyboardTextInputType: TextInputType.multiline,
                  fieldTextFont: BldrsThemeFonts.fontBldrsHeadlineFont,
                  hintText: '...',
                  bulletPointsFont: BldrsThemeFonts.fontBldrsBodyFont,
                  fieldTextCentered: true,
                  fieldTextHeight: _fieldTextHeight,
                  // maxLines: 1,
                  // minLines: 1,
                ),
              ],
            ),
          ),
        ),

        /// EMAIL FIELD
        TextFieldBubble(
          bubbleColor: Colorz.white20,
          bubbleHeaderVM: const BubbleHeaderVM(
              headlineText: 'E-mail',
              headlineHeight: 18,
              headlineColor: Colorz.white200,
              redDot: true),
          bubbleWidth: _bubbleWidth,
          textController: emailController,
          // maxLength: 10000,
          keyboardTextInputType: TextInputType.multiline,
          hintText: '...',
          fieldTextCentered: true,
          fieldTextFont: BldrsThemeFonts.fontBldrsBodyFont,
          fieldTextHeight: 25,
          // maxLines: 1,
          // minLines: 1,
        ),

        /// BIO FIELD
        TextFieldBubble(
          bubbleColor: Colorz.white20,
          bubbleHeaderVM: const BubbleHeaderVM(
              headlineText: 'Biography',
              headlineHeight: 18,
              headlineColor: Colorz.white200,
              redDot: true),
          bubbleWidth: _bubbleWidth,
          textController: bioController,
          maxLines: 7,
          // maxLength: 10000,
          keyboardTextInputType: TextInputType.multiline,
          hintText: '...',
          minLines: 3,
          fieldTextCentered: true,
          fieldTextFont: BldrsThemeFonts.fontBldrsBodyFont,
          fieldTextHeight: 25,
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
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
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

        /// LIST PUSHER
        const KeyboardPusher(),

      ],
    );
    // --------------------
  }
  // --------------------------------------------------------------------------
}
