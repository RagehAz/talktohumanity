import 'package:super_fire/super_fire.dart';
import 'package:bldrs_theme/bldrs_theme.dart';
import 'package:devicer/devicer.dart';
import 'package:email_validator/email_validator.dart';
import 'package:filers/filers.dart';
import 'package:flutter/material.dart';
import 'package:layouts/layouts.dart';
import 'package:night_sky/night_sky.dart';
import 'package:scale/scale.dart';
import 'package:stringer/stringer.dart';
import 'package:super_box/super_box.dart';
import 'package:talktohumanity/b_views/a_screens/b_0_home_screen.dart';
import 'package:talktohumanity/b_views/b_widgets/a_buttons/auth_button.dart';
import 'package:talktohumanity/b_views/b_widgets/a_buttons/talk_box.dart';
import 'package:talktohumanity/b_views/b_widgets/b_texting/talk_text_field.dart';
import 'package:talktohumanity/c_services/helpers/standards.dart';
import 'package:talktohumanity/c_services/protocols/auth_protocols.dart';
import 'package:talktohumanity/c_services/providers/ui_provider.dart';
import 'package:widget_fader/widget_fader.dart';


class AuthView extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const AuthView({
    @required this.backButtonIsSkipButton,
    Key key
  }) : super(key: key);

  final bool backButtonIsSkipButton;
  /// --------------------------------------------------------------------------
  @override
  _AuthViewState createState() => _AuthViewState();
  /// --------------------------------------------------------------------------
}

class _AuthViewState extends State<AuthView> {
  // -----------------------------------------------------------------------------
  final GlobalKey _flushbarKey = GlobalKey();
  // --------------------
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _canErrorize = false;
  final ValueNotifier<bool> isObscured = ValueNotifier(true);
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
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
  Future<void> _onEmailSignIn() async {

    FocusManager.instance.primaryFocus?.unfocus();
    final bool _canSign = await _preEmailSignCheckUps();

    await _triggerLoading(setTo: true);

    if (_canSign == true) {

      final bool _success = await AuthProtocols.simpleEmailSignin(
        email: _emailController.text,
        password: _passwordController.text,
        flushbarKey: _flushbarKey,
      );

      await _afterSignIn(
        success: _success,
      );

    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  Future<void> _onEmailSignUp() async {

    FocusManager.instance.primaryFocus?.unfocus();
    final bool _canSign = await _preEmailSignCheckUps();

    if (_canSign == true) {

    await _triggerLoading(setTo: true);

      final bool _success = await AuthProtocols.simpleEmailSignUp(
        email: _emailController.text,
        password: _passwordController.text,
        flushbarKey: _flushbarKey,
      );

      await _afterSignIn(
        success: _success,
      );

    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  Future<bool> _preEmailSignCheckUps() async {

    setState(() {
      _canErrorize = true;
    });

    final bool _isValid = _formKey.currentState.validate();

    if (_isValid == true){
      return true;
    }
    else {
      return false;
    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  Future<void> _onAuthSuccess(AuthModel authModel) async {

                              FocusManager.instance.primaryFocus?.unfocus();

                              AuthModel.blogAuthModel(authModel: authModel);

                              final bool _success = await AuthProtocols.onReceiveAuthModel(
                                flushbarKey: _flushbarKey,
                                authModel: authModel,
                              );

                              await _afterSignIn(
                                success: _success,
                              );
                            }
  // --------------------
  /// TESTED : WORKS PERFECT
  Future<void> _onAuthError(String error) async {
    blog('error : $error');
    await AuthProtocols.showAuthFailureDialog(
      flushbarKey: _flushbarKey,
      error: error,
    );
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  Future<void> _afterSignIn({
    @required bool success,
  }) async {

    await _triggerLoading(setTo: false);

    if (success == true) {

      // await TopDialog.closeTopDialog(
      //   flushbarKey: _flushbarKey,
      // );

      UiProvider.proSetHomeView(view: HomeScreenView.creator, notify: true);


    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  Future<void> _onBack() async {
    UiProvider.goBack();
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  void _onAuthLoadingChanged(bool loading){
    _triggerLoading(setTo: loading);
  }
  // --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    final double _screenHeight = Scale.screenHeightGross(context);

    final List<SignInMethod> methods = [
      if (DeviceChecker.deviceIsIOS() == true) SignInMethod.apple,
      SignInMethod.google,
      SignInMethod.facebook
    ];

    // --------------------
    return WidgetFader(
      fadeType: FadeType.fadeIn,
      duration: Standards.homeViewFadeDuration,
      child: Container(
        height: _screenHeight,
        color: Colorz.black125,
        child: Stack(
            children: <Widget>[

              /// SKY
              ValueListenableBuilder(
                valueListenable: _loading,
                builder: (_, bool loading, Widget child) {
                  return WidgetFader(
                    fadeType: loading == true ? FadeType.stillAtMax : FadeType.repeatAndReverse,
                    child: Sky(
                      skyType: SkyType.blackStars,
                      skyColor: loading == true ? Colorz.white20 : Colorz.black255,
                    ),
                  );
                }
              ),

              Form(
                key: _formKey,
                child: FloatingList(
                  columnChildren: <Widget>[

                    const DotSeparator(color: Colorz.yellow200),

                    /// EMAIL
                    TalkTextField(
                      headlineText: 'E-mail',
                      textController: _emailController,
                      canErrorize: _canErrorize,
                      bubbleWidth: AuthButton.width,
                      fieldTextCentered: false,
                      bubbleColor: Colorz.white20,
                      validator: (String text) {
                        String _output;

                        if (_canErrorize == true) {
                          if (TextCheck.isEmpty(text) == true) {
                            _output = 'Enter your E-mail';
                          } else {
                            if (EmailValidator.validate(text) == false) {
                              _output = 'Email format is not correct';
                            }
                          }
                        }

                        return _output;
                      },
                      keyboardTextInputAction: TextInputAction.next,
                      keyboardTextInputType: TextInputType.emailAddress,
                    ),

                    /// PASSWORD
                    TalkTextField(
                      headlineText: 'Password',
                      textController: _passwordController,
                      canErrorize: _canErrorize,
                      bubbleWidth: AuthButton.width,
                      isObscured: isObscured,
                      fieldTextCentered: false,
                      bubbleColor: Colorz.white20,
                      keyboardTextInputType: TextInputType.text,
                      validator: (String text) {
                        String _output;

                        if (_canErrorize == true) {
                          if (text.isEmpty == true) {
                            _output = 'Enter your password';
                          } else if (text.length < 6) {
                            _output = 'Password should atleast be 6 characters long';
                          }
                        }

                        return _output;
                      },
                    ),

                    /// EMAIL SIGN IN BUTTONS
                    SizedBox(
                      width: AuthButton.width,
                      height: AuthButton.height,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[

                          // /// FORGOT PASSWORD
                          // SizedBox(
                          //   height: 20,
                          //   child: TalkText(
                          //     text: 'Forgot password',
                          //     textHeight: 20,
                          //     boxColor: Colorz.white20,
                          //     isBold: false,
                          //     centered: false,
                          //     onTap: _onForgetPassword,
                          //   ),
                          // ),

                          /// EXPANDER
                          const Expander(),

                          /// REGISTER
                          TalkBox(
                            height: AuthButton.height,
                            text: 'Register',
                            isBold: true,
                            textScaleFactor: 0.7,
                            color: AuthButton.color,
                            onTap: _onEmailSignUp,
                          ),

                          const SizedBox(
                            width: 5,
                            height: 5,
                          ),

                          /// SIGN IN
                          TalkBox(
                            height: AuthButton.height,
                            text: 'SignIn',
                            isBold: true,
                            textScaleFactor: 0.7,
                            color: AuthButton.color,
                            onTap: _onEmailSignIn,
                          ),

                        ],
                      ),
                    ),

                    const SeparatorLine(width: AuthButton.width, withMargins: true, thickness: 2,),

                  /// SOCIAL AUTH BUTTONS
                  SizedBox(
                    width: AuthButton.width,
                    height: SocialAuthButton.standardSize,
                    child: Row(
                      children: <Widget>[

                        ...List.generate(methods.length, (index) {
                          return SocialAuthButton(
                            signInMethod: methods[index],
                            socialKeys: Standards.talkToHumanitySocialKeys,
                            onSuccess: _onAuthSuccess,
                            onError: _onAuthError,
                            onAuthLoadingChanged: _onAuthLoadingChanged,
                            manualAuthing: DeviceChecker.deviceIsAndroid(),
                          );
                        }),

                      ],
                    ),
                  ),

                  const SeparatorLine(width: AuthButton.width, withMargins: true, thickness: 2,),

                    /// GO BACK
                    AuthButton(
                      text: widget.backButtonIsSkipButton == true ? 'Skip' : 'Go Back',
                      icon: widget.backButtonIsSkipButton == true ? Iconz.arrowRight : Iconz.arrowLeft,
                      isInverted: widget.backButtonIsSkipButton,
                      onTap: _onBack,
                      iconSizeFactor: 0.3,
                    ),

                    const DotSeparator(color: Colorz.yellow200),

                  ],
                ),
              ),

              /// LOADING LAYER
              ValueListenableBuilder(
                  valueListenable: _loading,
                  child: Container(
                    width: Scale.screenWidth(context),
                    height: _screenHeight,
                    color: Colorz.black50,
                    child: const Loading(loading: true),
                  ),
                  builder: (_, bool loading, Widget child){

                    if (loading == true){
                      return child;
                    }
                    else {
                      return const SizedBox();
                    }

                  }
              ),

            ],
          ),
      ),
    );
    // --------------------
  }
  // --------------------------------------------------------------------------
}
