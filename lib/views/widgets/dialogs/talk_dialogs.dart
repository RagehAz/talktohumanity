import 'package:bldrs_theme/bldrs_theme.dart';
import 'package:dialogs/dialogs.dart';
import 'package:flutter/material.dart';
import 'package:talktohumanity/services/helper_methods.dart';

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
          titleTextHeight: 12,
          bodyTextHeight: 18,
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
