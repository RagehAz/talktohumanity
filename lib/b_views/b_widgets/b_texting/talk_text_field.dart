import 'package:bldrs_theme/bldrs_theme.dart';
import 'package:bubbles/bubbles.dart';
import 'package:flutter/material.dart';
import 'package:scale/scale.dart';
import 'package:talktohumanity/d_helpers/helper_methods.dart';

class TalkTextField extends StatelessWidget {
  // -----------------------------------------------------------------------------
  const TalkTextField({
    @required this.headlineText,
    @required this.textController,
    this.canErrorize,
    this.validator,
    this.maxLines = 6,
    this.minLines = 1,
    this.bubbleWidth,
    this.keyboardTextInputType = TextInputType.multiline,
    this.bubbleColor,
    this.fieldTextHeight = 27,
    this.isDisabled = false,
    this.hasSwitch = false,
    this.onSwitchTap,
    this.redDot = false,
    this.fieldScrollPadding,
    this.isObscured,
    this.fieldTextCentered = true,
    this.keyboardTextInputAction,
    Key key,
  }) : super(key: key);
  // -----------------------------------------------------------------------------
  final String headlineText;
  final TextEditingController textController;
  final double bubbleWidth;
  final int maxLines;
  final int minLines;
  final bool canErrorize;
  final TextInputType keyboardTextInputType;
  final Color bubbleColor;
  final double fieldTextHeight;
  final String Function(String) validator;
  final bool isDisabled;
  final bool hasSwitch;
  final void Function(bool) onSwitchTap;
  final bool redDot;
  final EdgeInsets fieldScrollPadding;
  final ValueNotifier<bool> isObscured;
  final bool fieldTextCentered;
  final TextInputAction keyboardTextInputAction;
  // -----------------------------------------------------------------------------
  static double getBubbleWidth(){
    final double _screenWidth = Scale.screenWidth(getContext());
    return _screenWidth - 20;
  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final double _bubbleWidth = bubbleWidth ?? getBubbleWidth();

    return TextFieldBubble(
      isFormField: true,
      bubbleHeaderVM: BubbleHeaderVM(
        headlineText: headlineText,
        headlineHeight: 25,
        headlineColor: isDisabled == true ? Colorz.white80 : Colorz.white200,
        switchValue: !isDisabled,
        hasSwitch: hasSwitch,
        onSwitchTap: onSwitchTap,
        switchTrackColor: Colorz.white80,
        switchDisabledColor: Colorz.black200,
        font: BldrsThemeFonts.fontBldrsBodyFont,
        switchDisabledTrackColor: Colorz.white20,
        redDot: redDot,
      ),
      bubbleWidth: _bubbleWidth,
      bubbleColor: bubbleColor ?? (isDisabled == true ? Colorz.nothing : Colorz.white10),
      textController: textController,
      maxLines: maxLines,
      // maxLength: 10000,
      keyboardTextInputType: keyboardTextInputType,
      keyboardTextInputAction: keyboardTextInputAction,
      fieldTextFont: BldrsThemeFonts.fontBldrsBodyFont,
      hintText: '...',
      bulletPointsFont: BldrsThemeFonts.fontBldrsBodyFont,
      minLines: minLines,
      fieldTextCentered: fieldTextCentered,
      fieldTextHeight: fieldTextHeight,
      autoValidate: canErrorize,
      canErrorize: canErrorize,
      validator: validator,
      fieldScrollPadding: fieldScrollPadding ?? EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      isObscured: isObscured,

    );
  }
}
