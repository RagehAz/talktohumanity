import 'package:bldrs_theme/bldrs_theme.dart';
import 'package:dialogs/dialogs.dart';
import 'package:flutter/material.dart';
import 'package:talktohumanity/d_helpers/helper_methods.dart';

class TalkDialog {
  // -----------------------------------------------------------------------------

  const TalkDialog();

  // -----------------------------------------------------------------------------
  /// TESTED : WORKS PERFECT
  static Future<void> centerDialog({
    String title,
    String body,
  }) async {

      final BuildContext context = getContext();

      await CenterDialog.showCenterDialog(
        context: context,
        bubble: CenterDialog.buildBubble(
          context: context,
          boolDialog: false,
          title: title,
          body: body,
          titleTextHeight: 30,
          bodyTextHeight: 25,

          // bodyColor: Colorz.black255,
          // titleColor: Colorz.black255,
          // boxColor: Colorz.white255,
          // buttons: CenterDialog.yesNoButtons(
          //   context: context,
          //   noText: 'Fuck no',
          //   yesText: 'Oh Yea',
          //   titleFont: BldrsThemeFonts.fontBldrsHeadlineFont,
          //   boolDialog: false,
          //   invertButtons: false,
          //   appIsLTR: true,
          //   textDirection: TextDirection.ltr,
          //   activeButtonColor: Colorz.black255,
          //   activeTextColor: Colorz.white255,
          //   // onOk: onOk,
          // ),
        ),
      );

    }
  // -----------------------------------------------------------------------------
  /// TESTED : WORKS PERFECT
  static Future<bool> boolDialog({
    String title,
    String body,
    bool invertButtons = false,
  }) async {
    final BuildContext context = getContext();

    final bool _result = await CenterDialog.showCenterDialog(
      context: context,
      bubble: CenterDialog.buildBubble(
        context: context,
        boolDialog: true,
        title: title,
        body: body,
        titleTextHeight: 30,
        bodyTextHeight: 25,
        titleFont: BldrsThemeFonts.fontBldrsHeadlineFont,
        bodyFont: BldrsThemeFonts.fontBldrsBodyFont,
        // bodyColor: Colorz.black255,
        // titleColor: Colorz.black255,
        // boxColor: Colorz.white255,
        buttons: CenterDialog.yesNoButtons(
          context: context,
          textFont: BldrsThemeFonts.fontBldrsHeadlineFont,
          boolDialog: true,
          invertButtons: invertButtons,
          // noText: 'Fuck no',
          // yesText: 'Oh Yea',
          // appIsLTR: true,
          // textDirection: TextDirection.ltr,
          // activeButtonColor: Colorz.black255,
          // activeTextColor: Colorz.white255,
          // onOk: onOk,
        ),
      ),
    );

    return _result;
  }
  // -----------------------------------------------------------------------------

}

Future<void> showTalkTopDialog({
  @required GlobalKey flushbarKey,
  @required String headline,
  String secondLine,
  Color dialogColor = Colorz.white255,
  int milliseconds = 5000,
}) async {

  await TopDialog.showTopDialog(
    flushbarKey: flushbarKey,
    context: getContext(),
    firstText: headline,
    color: dialogColor,
    firstFont: BldrsThemeFonts.fontBldrsHeadlineFont,
    secondFont: BldrsThemeFonts.fontBldrsBodyFont,
    milliseconds: milliseconds,
    secondText: secondLine,
    // appIsLTR: true,
    // textColor: Colorz.black255,
  );

}
