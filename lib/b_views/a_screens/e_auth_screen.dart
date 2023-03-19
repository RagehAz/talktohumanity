import 'package:bldrs_theme/bldrs_theme.dart';
import 'package:dialogs/dialogs.dart';
import 'package:filers/filers.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:layouts/layouts.dart';
import 'package:talktohumanity/packages/authing/authing.dart';
import 'package:talktohumanity/b_views/b_widgets/a_buttons/talk_box.dart';
import 'package:talktohumanity/b_views/b_widgets/c_dialogs/talk_dialogs.dart';

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

    if (_credential == null || _error != null) {
      await showTalkTopDialog(
        flushbarKey: _flushbarKey,
        headline: 'Sing in failed',
        milliseconds: 50000,
        secondLine: _error,
      );
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
  // /// TESTED : WORKS PERFECT
  // Future<void> _onAuthError(String error) async {
  //
  // }
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
            isBold: false,
          ),

          TalkBox(
            height: 50,
            text: 'Go Back',
            icon: Iconz.arrowLeft,
            onTap: _onBack,
            isBold: false,
          ),

        ],
      ),
    );
    // --------------------
  }
  // --------------------------------------------------------------------------
}