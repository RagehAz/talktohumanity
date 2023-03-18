part of bubbles;

class TextFieldBubbles extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const TextFieldBubbles({
    @required this.bubbleHeaderVM,
    @required this.bubbleWidth,
    this.formKey,
    this.hintText,
    this.counterIsOn = false,
    this.maxLines = 1,
    this.maxLength = 100,
    this.textController,
    this.keyboardTextInputType = TextInputType.text,
    this.onTextChanged,
    this.isObscured,
    this.isFormField,
    this.onSavedForForm,
    this.keyboardTextInputAction,
    this.initialText,
    this.validator,
    this.bulletPoints,
    this.bulletPointsFont,
    // this.loading = false,
    this.leadingIcon,
    this.leadingIconSizeFactor = 1,
    this.pasteFunction,
    this.fieldTextDirection,
    this.bubbleColor = const Color.fromARGB(10, 255, 255, 255),
    this.onBubbleTap,
    this.isLoading = false,
    this.canErrorize = false,
    this.columnChildren,
    this.onSubmitted,
    this.minLines = 1,
    this.autoFocus = false,
    this.focusNode,
    this.onFieldTap,
    this.autoValidate = true,
    this.pasteText = 'Paste',
    this.loadingColor = const Color.fromARGB(255, 255, 255, 255),
    this.obscuredActiveColor = const Color.fromARGB(255, 255, 255, 255),
    this.obscuredIcon = 'packages/bldrs_theme/lib/assets/icons/gi_views.svg',

    this.fieldTextHeight = 30,
    this.fieldTextColor = const Color.fromARGB(255, 255, 255, 255),
    this.fieldScrollController,
    this.cursorColor = const Color.fromARGB(255, 255, 255, 255),
    this.fieldTextCentered = false,
    this.fieldTextItalic = false,
    this.fieldScrollPadding = const EdgeInsets.symmetric(vertical: 50),
    this.fieldTextPadding = const EdgeInsets.all(10),
    this.focusedErrorBorderColor = const Color.fromARGB(125, 255, 255, 255),
    this.focusedBorderColor = const Color.fromARGB(125, 255, 255, 255),
    this.errorTextColor = const Color.fromARGB(125, 233, 0, 0),
    this.errorBorderColor = const Color.fromARGB(125, 233, 0, 0),
    this.enabledBorderColor = const Color.fromARGB(125, 255, 255, 255),
    this.fieldColor = const Color.fromARGB(10, 255, 255, 255),
    this.fieldTextWeight = FontWeight.w100,

    this.fieldLetterSpacing,
    this.fieldTextFont,
    this.fieldCorners = 12,
    this.fieldWordSpacing,

    this.isDisabled = false,
    Key key,
  }) : super(key: key);
  /// --------------------------------------------------------------------------

  final BubbleHeaderVM bubbleHeaderVM;
  final double bubbleWidth;
  final String hintText;
  final bool counterIsOn;
  final int maxLines;
  final int maxLength;
  final TextEditingController textController;
  final TextInputType keyboardTextInputType;
  final ValueChanged<String> onTextChanged;
  final ValueChanged<String> onSubmitted;
  final ValueNotifier<bool> isObscured;
  final bool isFormField;
  final ValueChanged<String> onSavedForForm;
  final TextInputAction keyboardTextInputAction;
  final String initialText;
  final String Function(String) validator;
  final List<String> bulletPoints;
  final String bulletPointsFont;
  // final bool loading;
  final dynamic leadingIcon;
  final double leadingIconSizeFactor;
  final Function pasteFunction;
  final TextDirection fieldTextDirection;
  final Color bubbleColor;
  final Function onBubbleTap;
  final bool isLoading;
  final bool canErrorize;
  final List<Widget> columnChildren;
  final int minLines;
  final bool autoFocus;
  final FocusNode focusNode;
  final Function onFieldTap;
  final GlobalKey formKey;
  final bool autoValidate;
  final String pasteText;
  final Color loadingColor;
  final Color obscuredActiveColor;
  final String obscuredIcon;

  final double fieldTextHeight;
  final Color fieldTextColor;
  final ScrollController fieldScrollController;
  final Color cursorColor;
  final bool fieldTextCentered;
  final bool fieldTextItalic;
  final EdgeInsets fieldScrollPadding;
  final EdgeInsets fieldTextPadding;
  final Color focusedErrorBorderColor;
  final Color focusedBorderColor;
  final Color errorTextColor;
  final Color errorBorderColor;
  final Color enabledBorderColor;
  final Color fieldColor;
  final FontWeight fieldTextWeight;

  final double fieldLetterSpacing;
  final String fieldTextFont;
  final dynamic fieldCorners;
  final double fieldWordSpacing;
  final bool isDisabled;

  /// --------------------------------------------------------------------------
  static const double pasteButtonWidth = 50;
  // -----------------------------------------------------------------------------

  /// VALIDATION

  // --------------------
  /// TESTED : WORKS PERFECT
  static String bakeValidator({
    @required String Function(String text) validator,
    @required String text,
    bool keepEmbeddedBubbleColor = false,
  }){

    if (validator == null){
      return null;
    }

    else {

      if (keepEmbeddedBubbleColor == true){
        return validator(text);
      }

      else {
        return _bakeValidatorMessage(validator(text));
      }

    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static String _bakeValidatorMessage(String message){
    String _output;

    if (message != null){
      _output = TextMod.removeTextBeforeFirstSpecialCharacter(message, 'Δ');
    }

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// VALIDATION

  // --------------------
  static double getFieldWidth({
    @required dynamic leadingIcon,
    @required bool showUnObscure,
    @required BuildContext context,
    @required double bubbleWidth,
    @required bool hasPasteButton,
    @required EdgeInsets textPadding,
    @required double textHeight,
  }){

    final double fieldHeight = SuperTextFieldController.getFieldHeight(
      context: context,
      minLines: 1,
      textPadding: textPadding,
      textHeight: textHeight,
      withBottomMargin: false,
      withCounter: false,
    );


    final double _leadingIconSize = leadingIcon == null ? 0 : fieldHeight;
    final double _leadingAndFieldSpacing = leadingIcon == null ? 0 : 5;
    final double _obscureBtSize = showUnObscure == false ? 0 : fieldHeight;
    final double _obscureBtSpacing = showUnObscure == false ? 0 : 5;
    final double _pasteButtonWidthAndSpacing = hasPasteButton == true ? pasteButtonWidth + 5 : 0;
    final double _bubbleClearWidth = Bubbles.clearWidth(context: context, bubbleWidthOverride: bubbleWidth);
    final double _fieldWidth = _bubbleClearWidth - _leadingIconSize
        - _leadingAndFieldSpacing - _obscureBtSize - _obscureBtSpacing - _pasteButtonWidthAndSpacing;

    return _fieldWidth;
  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    final double fieldHeight = SuperTextFieldController.getFieldHeight(
      context: context,
      minLines: 1,
      textHeight: fieldTextHeight,
      textPadding: fieldTextPadding,
      withBottomMargin: false,
      withCounter: false,
    );
    final double leadingIconSize = leadingIcon == null ? 0 : fieldHeight;
    final double obscureBtSize = isObscured == null ? 0 : fieldHeight;
    // --------------------
    final double _bubbleWidth = Bubbles.bubbleWidth(
        context: context,
        bubbleWidthOverride: bubbleWidth,
    );
    // --------------------
    final double fieldWidth = getFieldWidth(
      context: context,
      bubbleWidth: _bubbleWidth,
      leadingIcon: leadingIcon,
      showUnObscure: isObscured != null,
      hasPasteButton: pasteFunction != null,
      textPadding: fieldTextPadding,
      textHeight: fieldTextHeight,
    );
    // --------------------
    return Bubbles(
        bubbleColor: TileBubble.validatorBubbleColor(
          canErrorize: autoValidate == true || canErrorize == true,
          defaultColor: bubbleColor,
          validator: () => bakeValidator(
            validator: validator,
            text: textController?.text,
            keepEmbeddedBubbleColor: true,
          ),
        ),
        bubbleHeaderVM: bubbleHeaderVM.copyWith(
          headerWidth: _bubbleWidth - 20,
        ),
        width: _bubbleWidth,
        onBubbleTap: isDisabled == false ? null : onBubbleTap,
        columnChildren: <Widget>[

          /// BULLET POINTS
          if (bulletPoints != null && bulletPoints?.isNotEmpty == true)
            Disabler(
              isDisabled: isDisabled,
              child: BulletPoints(
                textHeight: fieldTextHeight * 0.8,
                appIsLTR: bubbleHeaderVM.appIsLTR,
                textDirection: bubbleHeaderVM.textDirection,
                boxWidth: _bubbleWidth,
                bulletPoints: bulletPoints,
                font: bulletPointsFont,
              ),
            ),

          /// TEXT FIELD ROW
          Disabler(
            isDisabled: isDisabled,
            child: Stack(
              alignment: Aligner.top(
                appIsLTR: bubbleHeaderVM.appIsLTR,
                inverse: true,
              ),
              children: <Widget>[

                /// TEXT FIELD
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[

                    /// LEADING ICON
                    if (leadingIcon != null)
                      SuperBox(
                        height: leadingIconSize,
                        width: leadingIconSize,
                        icon: leadingIcon,
                        iconSizeFactor: leadingIconSizeFactor,
                      ),

                    /// SPACER
                    if (leadingIcon != null)
                      const SizedBox(width: 5,),

                    /// TEXT FIELD
                    SuperTextField(
                      textHeight: fieldTextHeight,
                      textColor: fieldTextColor,
                      scrollController: fieldScrollController,
                      cursorColor: cursorColor,
                      centered: fieldTextCentered,
                      textItalic: fieldTextItalic,
                      scrollPadding: fieldScrollPadding,
                      textPadding: fieldTextPadding,
                      focusedErrorBorderColor: focusedErrorBorderColor,
                      focusedBorderColor: focusedBorderColor,
                      errorTextColor: errorTextColor,
                      errorBorderColor: errorBorderColor,
                      enabledBorderColor: enabledBorderColor,
                      fieldColor: fieldColor,
                      textWeight: fieldTextWeight,
                      // onEditingComplete: ,
                      appIsLTR: bubbleHeaderVM.appIsLTR,
                      letterSpacing: fieldLetterSpacing,
                      textFont: fieldTextFont,
                      corners: fieldCorners,
                      wordSpacing: fieldWordSpacing,
                      // package: ,
                      // margins: ,
                      // textShadows: [],
                      globalKey: formKey,
                      width: fieldWidth,
                      isFormField: isFormField,
                      textDirection: fieldTextDirection,
                      hintText: hintText,
                      counterIsOn: counterIsOn,
                      textInputType: keyboardTextInputType,
                      maxLines: maxLines,
                      maxLength: maxLength,
                      textController: textController,
                      onChanged: onTextChanged,
                      onSubmitted: onSubmitted,
                      onSavedForForm: onSavedForForm,
                      textInputAction: keyboardTextInputAction,
                      initialValue: initialText,
                      validator: validator,
                      focusNode: focusNode,
                      autofocus: autoFocus,
                      minLines: minLines,
                      onTap: onFieldTap,
                      isObscured: isObscured,
                      autoValidate: autoValidate,
                    ),

                    /// SPACER
                    if (isObscured != null)
                      const SizedBox(width: 5,),

                    /// OBSCURE BUTTON
                    if (isObscured != null)
                      ValueListenableBuilder(
                        valueListenable: isObscured,
                        builder: (_, bool obscured, Widget child){
                          return SuperBox(
                            height: obscureBtSize,
                            width: obscureBtSize,
                            color: obscured ?
                            const Color.fromARGB(10, 255, 255, 255)
                                :
                            obscuredActiveColor,
                            icon: obscuredIcon,
                            iconColor: obscured ?
                            const Color.fromARGB(20, 255, 255, 255)
                                    :
                            const Color.fromARGB(230, 0, 0, 0),
                            iconSizeFactor: 0.7,
                            bubble: false,
                            // corners: SuperVerse.superVerseLabelCornerValue(context, 3),
                            onTap: () {
                              if (isObscured != null) {
                                isObscured.value = !obscured;
                              }
                              },
                            textFont: bubbleHeaderVM.font,
                            textDirection: bubbleHeaderVM.textDirection,
                            appIsLTR: bubbleHeaderVM.appIsLTR,
                            // boxFunction: horusOnTapCancel== null ? (){} : horusOnTapCancel, // this prevents keyboard action from going to next field in the form
                          );
                          },
                      ),

                  ],
                ),

                /// LOADING INDICATOR
                if (isLoading == true)
                  Loading(
                    size: 35,
                    loading: isLoading,
                    color: loadingColor,
                  ),

                /// TASK : MOVE PASTE BUTTON TO BE INSIDE THE ROW ABOVE JUST LIKE CONTACTS BUBBLE
                if (pasteFunction != null)
                  SuperBox(
                    height: fieldHeight,
                    width: pasteButtonWidth,
                    text: pasteText,
                    textScaleFactor: 0.5,
                    textWeight: FontWeight.w100,
                    textItalic: true,
                    color: const Color.fromARGB(10, 255, 255, 255),
                    onTap: pasteFunction,
                    appIsLTR: bubbleHeaderVM.appIsLTR,
                    textDirection: bubbleHeaderVM.textDirection,
                    textFont: bubbleHeaderVM.font,
                    // package: bubbleHeaderVM.package,
                    letterSpacing: bubbleHeaderVM.letterSpacing,

                  ),

              ],
            ),
          ),

          /// CHILDREN
          if (columnChildren != null && columnChildren?.isNotEmpty == true)
          Disabler(
              isDisabled: isDisabled,
              child: Column(
                children: <Widget>[

                  ...columnChildren,

                ],
              ),
          ),

        ]
    );
    // --------------------
  }
  // -----------------------------------------------------------------------------
}
