import 'package:bldrs_theme/bldrs_theme.dart';
import 'package:filers/filers.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:layouts/layouts.dart';
import 'package:talktohumanity/authenticator/authenticator.dart';
import 'package:talktohumanity/dialogs/dialogs.dart';
import 'package:talktohumanity/services/helper_methods.dart';
import 'package:talktohumanity/services/navigation/nav.dart';
import 'package:talktohumanity/views/widgets/basics/talk_box.dart';
import 'package:talktohumanity/views/widgets/layouts/basic_layout.dart';

class AuthScreen extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const AuthScreen({
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  @override
  _AuthScreenState createState() => _AuthScreenState();
  /// --------------------------------------------------------------------------
}

class _AuthScreenState extends State<AuthScreen> {
  // -----------------------------------------------------------------------------
  final GlobalKey _flushbarKey = GlobalKey();
  // -----------------------------------------------------------------------------
  /// --- LOADING
  final ValueNotifier<bool> _loading = ValueNotifier(false);
  // --------------------
  Future<void> _triggerLoading({@required bool setTo}) async {
    setNotifier(
      notifier: _loading,
      mounted: mounted,
      value: setTo,
    );
  }
  // -----------------------------------------------------------------------------
  @override
  void initState() {
    super.initState();
  }
  // --------------------
  bool _isInit = true;
  @override
  void didChangeDependencies() {
    if (_isInit && mounted) {

      _triggerLoading(setTo: true).then((_) async {

        /// FUCK

        await _triggerLoading(setTo: false);
      });

      _isInit = false;
    }
    super.didChangeDependencies();
  }
  // --------------------
  @override
  void dispose() {
    _loading.dispose();
    super.dispose();
  }
  // --------------------------------------------------------------------------
  /// TESTED : WORKS PERFECT
  Future<void> _onBack() async {

    await Nav.goBack(
      context: context,
      passedData: false,
      invoker: 'AuthScreen : onBack',
    );

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  Future<void> _onGoogleTap() async {

    String _error;

    final UserCredential _credential = await GoogleAuthing.emailSignIn(
      onError: (String error) => _error = error,
    );

    if (_credential == null || _error != null){
      await _onAuthError(_error);
    }

    else {

      await TopDialog.closeTopDialog(
          flushbarKey: _flushbarKey,
      );

      await Nav.goBack(
        context: context,
        passedData: true,
        invoker: 'AuthScreen : signed in : userID : ${Authing.getUserID()}',
      );

    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  Future<void> _onAuthError(String error) async {
    await showTalkTopDialog(
      flushbarKey: _flushbarKey,
      headline: 'Sing in failed',
      milliseconds: 50000,
      secondLine: error,
    );
  }
  // --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    return BasicLayout(
      body: FloatingList(
        columnChildren: <Widget>[


          TalkBox(
            height: 50,
            width: 50,
            icon: Iconz.comGooglePlus,
            onTap: _onGoogleTap,
          ),

          TalkBox(
            height: 50,
            text: 'Go Back',
            icon: Iconz.arrowLeft,
            onTap: _onBack,
          ),

        ],
      ),
    );
    // --------------------
  }
  // --------------------------------------------------------------------------
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
