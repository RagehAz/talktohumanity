import 'package:bldrs_theme/bldrs_theme.dart';
import 'package:devicer/devicer.dart';
import 'package:dialogs/dialogs.dart';
import 'package:filers/filers.dart';
import 'package:flutter/material.dart';
import 'package:layouts/layouts.dart';
import 'package:night_sky/night_sky.dart';
import 'package:talktohumanity/b_views/b_widgets/a_buttons/auth_button.dart';
import 'package:talktohumanity/b_views/b_widgets/b_texting/talk_text_field.dart';
import 'package:talktohumanity/c_protocols/authing_protocols/auth_protocols.dart';
import 'package:talktohumanity/packages/lib/authing.dart';

class AuthScreen extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const AuthScreen({
    @required this.backButtonIsSkipButton,
    Key key
  }) : super(key: key);

  final bool backButtonIsSkipButton;
  /// --------------------------------------------------------------------------
  @override
  _AuthScreenState createState() => _AuthScreenState();
  /// --------------------------------------------------------------------------
}

class _AuthScreenState extends State<AuthScreen> {
  // -----------------------------------------------------------------------------
  final GlobalKey _flushbarKey = GlobalKey();
  // --------------------
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool _canErrorize = false;
  final ValueNotifier<bool> isObscured = ValueNotifier(true);
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


    final bool _success = await AuthProtocols.simpleGoogleSignIn(
      flushbarKey: _flushbarKey,
    );

    await _afterSignIn(
        success: _success,
    );

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  Future<void> _onFacebookTap() async {

    final bool _success = await AuthProtocols.simpleFacebookSignIn(
      flushbarKey: _flushbarKey,
    );

    await _afterSignIn(
        success: _success,
    );

  }
  // --------------------
  /// TASK : WRITE ME
  Future<void> _onAppleTap() async {

  }
  // --------------------
  ///
  Future<void> _afterSignIn({
    @required bool success,
  }) async {

    if (success == true) {

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
  // --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    return BasicLayout(
      body: Stack(
        children: <Widget>[

          const Sky(
            skyType: SkyType.blackStars,
            skyColor: Colorz.black255,
          ),

          FloatingList(
            columnChildren: <Widget>[

              TalkTextField(
                headlineText: 'E-mail',
                textController: emailController,
                canErrorize: _canErrorize,
                bubbleWidth: AuthButton.width,
                fieldTextCentered: false,
                bubbleColor: Colorz.white20,
              ),

              TalkTextField(
                headlineText: 'Password',
                textController: passwordController,
                canErrorize: _canErrorize,
                bubbleWidth: AuthButton.width,
                isObscured: isObscured,
                fieldTextCentered: false,
                bubbleColor: Colorz.white20,
              ),

              Container(
                width: AuthButton.width,
                height: AuthButton.height,
                color: Colorz.bloodTest,
              ),

              const DotSeparator(color: Colorz.white200),

              /// GOOGLE SIGN IN
              AuthButton(
                icon: Iconz.comGooglePlus,
                text: ' SignIn by Google',
                onTap: _onGoogleTap,
              ),

              /// APPLE SIGN IN
              if (DeviceChecker.deviceIsIOS() == true)
              AuthButton(
                icon: Iconz.comApple,
                text: ' SignIn by Apple',
                onTap: _onAppleTap,
              ),

              /// FACEBOOK SIGN IN
              AuthButton(
                icon: Iconz.comFacebookWhite,
                text: ' SignIn by Facebook',
                onTap: _onFacebookTap,
              ),

              const DotSeparator(color: Colorz.white200),

              /// GO BACK
              AuthButton(
                text: widget.backButtonIsSkipButton == true ? 'Skip' : 'Go Back',
                icon: widget.backButtonIsSkipButton == true ? Iconz.arrowRight : Iconz.arrowLeft,
                isInverted: widget.backButtonIsSkipButton,
                onTap: _onBack,
                iconSizeFactor: 0.3,
              ),

              const DotSeparator(color: Colorz.white200),

            ],
          ),

        ],
      ),
    );
    // --------------------
  }
  // --------------------------------------------------------------------------
}
