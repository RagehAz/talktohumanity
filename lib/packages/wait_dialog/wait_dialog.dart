import 'dart:async';

import 'package:layouts/layouts.dart';
import 'package:bldrs_theme/bldrs_theme.dart';
import 'package:flutter/material.dart';
import 'package:scale/scale.dart';
import 'package:super_box/super_box.dart';
import 'package:talktohumanity/d_helpers/helper_methods.dart';
import 'package:talktohumanity/b_views/b_widgets/b_texting/talk_text.dart';
import 'package:widget_fader/widget_fader.dart';

void pushWaitDialog({
  @required BuildContext context,
  @required String text,
  bool canManuallyGoBack = false,
}){
  WaitDialog.showUnawaitedWaitDialog(
    context: context,
    text: text,
    canManuallyGoBack: canManuallyGoBack,
  );
}

void closeWaitDialog(BuildContext context){
  unawaited(WaitDialog.closeWaitDialog(context));
}

class WaitDialog extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const WaitDialog({
    this.canManuallyGoBack = false,
    this.loadingText,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final bool canManuallyGoBack;
  final String loadingText;
  // -----------------------------------------------------------------------------
  /// TESTED : WORKS PERFECT
  static void showUnawaitedWaitDialog({
    @required BuildContext context,
    @required String text,
    bool canManuallyGoBack = false,
  }) {

    unawaited(_showWaitDialog(
      context: context,
      loadingText: text,
      canManuallyGoBack: canManuallyGoBack,
    ));

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> _showWaitDialog({
    @required BuildContext context,
    @required String loadingText,
    bool canManuallyGoBack = false,
  }) async {

    await showDialog(
      context: context,
      builder: (BuildContext ctx) => WaitDialog(
        canManuallyGoBack: canManuallyGoBack,
        loadingText: loadingText,
      ),
    );
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> closeWaitDialog(BuildContext context) async {
    final BuildContext _context = getContext();
    await Nav.goBack(
      context: _context,
      invoker: 'closeWaitDialog',
    );
  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    final double _screenHeight = Scale.screenHeight(context);
    final double _screenWidth = Scale.screenWidth(context);
    // --------------------
    return WillPopScope(
      onWillPop: () async {
        return !canManuallyGoBack;
      },
      child: Scaffold(
        backgroundColor: Colorz.black125,
        body: Stack(
          children: <Widget>[

            SizedBox(
              width: _screenWidth,
              height: _screenHeight,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[

                  const WidgetFader(
                    fadeType: FadeType.repeatAndReverse,
                    duration: Duration(seconds: 1),
                    child: TalkText(
                      text: 'Loading',
                      textHeight: 40,
                      italic: true,
                      font: BldrsThemeFonts.fontBldrsHeadlineFont,
                      margins: 20,
                    ),
                  ),

                  if (loadingText != null)
                    WidgetFader(
                      fadeType: FadeType.repeatAndReverse,
                      duration: const Duration(milliseconds: 850),
                      curve: Curves.easeInBack,
                      child: SizedBox(
                        width: _screenWidth * 0.8,
                        child: TalkText(
                          text: loadingText,
                          // textHeight: 50,
                          italic: true,
                          maxLines: 5,
                          margins: 10,
                        ),
                      ),
                    ),

                  const Loading(
                    loading: true,
                    color: Colorz.white200,
                  ),

                ],
              ),
            ),


          ],
        ),
      ),
    );
    // --------------------
  }
// -----------------------------------------------------------------------------
}
