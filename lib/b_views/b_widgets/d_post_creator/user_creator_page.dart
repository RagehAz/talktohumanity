import 'dart:typed_data';

import 'package:bldrs_theme/bldrs_theme.dart';
import 'package:bubbles/bubbles.dart';
import 'package:flutter/material.dart';
import 'package:layouts/layouts.dart';
import 'package:scale/scale.dart';
import 'package:stringer/stringer.dart';
import 'package:super_box/super_box.dart';
import 'package:super_text_field/super_text_field.dart';
import 'package:talktohumanity/b_views/a_screens/b_0_home_screen.dart';
import 'package:talktohumanity/b_views/b_widgets/a_buttons/talk_box.dart';
import 'package:talktohumanity/b_views/b_widgets/b_texting/talk_text.dart';
import 'package:talktohumanity/b_views/b_widgets/b_texting/talk_text_field.dart';
import 'package:talktohumanity/c_services/providers/ui_provider.dart';

class UserCreatorView extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const UserCreatorView({
    @required this.nameController,
    @required this.bioController,
    @required this.emailController,
    @required this.imageBytes,
    @required this.onPickImage,
    @required this.onPublish,
    @required this.onSlideBack,
    @required this.canErrorize,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController bioController;
  final Uint8List imageBytes;
  final Function onPickImage;
  final Function onPublish;
  final Function onSlideBack;
  final bool canErrorize;
  // --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    final double _bubbleWidth = TalkTextField.getBubbleWidth();
    final double _imageSize = SuperTextFieldController.getFieldHeight(
        context: context,
        minLines: 1,
        textHeight: 27,
        withBottomMargin: true,
        withCounter: false,
        textPadding: const EdgeInsets.all(10),
    );
    const double _imageBubbleWidth = 130;
    // --------------------
    final double _screenWidth = Scale.screenWidth(context);
    final double _screenHeight = Scale.screenHeightGross(context);
    final double _shortest = Scale.screenShortestSide(context);
    // --------------------
    return MaxBounceNavigator(
      onNavigate: onSlideBack,
      child: Center(
        child: Container(
          width: _screenWidth,
          height: Scale.superScreenHeightWithoutSafeArea(context),
          alignment: Alignment.center,
          child: FloatingList(
            height: _screenHeight + MediaQuery.of(context).viewInsets.bottom,
            width: _shortest,
            columnChildren: <Widget>[

              const DotSeparator(bottomMarginIsOn: false),

              const TalkText(
                text: 'Add more info about you',
                textHeight: 40,
                isBold: true,
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

                      /// IMAGE FIELD
                      Bubble(
                        width: _imageBubbleWidth,
                        bubbleHeaderVM: const BubbleHeaderVM(
                          headlineText: 'Picture',
                          headlineHeight: 25,
                          headlineColor: Colorz.white200,
                          redDot: true,
                          font: BldrsThemeFonts.fontBldrsBodyFont,
                        ),
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
                          SuperValidator(
                            width: _imageBubbleWidth,
                            focusNode: FocusNode(),
                            font: null,
                            validator: (){
                              if (imageBytes == null){
                                return 'Add Image';
                              }
                              else {
                                return null;
                              }
                              },
                            autoValidate: canErrorize,
                            textHeight: 15,
                          ),
                        ],
                      ),

                      /// NAME FIELD
                      TalkTextField(
                        headlineText: 'Name',
                        redDot: true,
                        bubbleWidth: _bubbleWidth - _imageBubbleWidth - 10,
                        textController: nameController,
                        canErrorize: canErrorize,
                        validator: (String text){
                          if (TextCheck.isEmpty(text) == true){
                            return 'Add your name';
                          }
                          else {
                            return null;
                          }
                          },
                        maxLines: 1,
                      ),

                    ],
                  ),
                ),
              ),

              /// EMAIL FIELD
              TalkTextField(
                headlineText: 'E-mail',
                redDot: true,
                textController: emailController,
                canErrorize: canErrorize,
                validator: (String text) {

                  if (TextCheck.isEmpty(text) == true) {
                    return 'Add your Email';
                  }

                  else {
                    return null;
                  }

                },
                // maxLines: 1,
                // minLines: 1,
              ),

              /// BIO FIELD
              TalkTextField(
                headlineText: 'Biography',
                redDot: true,
                textController: bioController,
                maxLines: 7,
                minLines: 3,
                fieldScrollPadding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom + 100,
                ),
                canErrorize: canErrorize,
                validator: (String text) {
                  if (TextCheck.isEmpty(text) == true) {
                    return 'Add your Bio, Job title or occupation';
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
                    onTap: () => UiProvider.proSetHomeView(view: HomeScreenView.posts, notify: true),
                  ),

                    /// PUBLISH
                    TalkBox(
                      width: 100,
                      height: 50,
                      textScaleFactor: 0.8,
                      text: 'Publish',
                      onTap: onPublish,
                      isBold: true,

                    ),

                  ],
                ),
              ),

              /// LIST PUSHER
              const KeyboardPusher(
                // initialHeight: 0,
                sizingFactor: 1,
              ),

            ],
          ),
        ),
      ),
    );

    // --------------------
  }
  // --------------------------------------------------------------------------
}
