import 'dart:typed_data';
import 'package:filers/filers.dart';
import 'package:flutter/material.dart';
import 'package:talktohumanity/a_models/user_model.dart';
import 'package:talktohumanity/b_views/b_widgets/c_dialogs/talk_dialogs.dart';
import 'package:talktohumanity/c_services/protocols/timing_protocols.dart';
import 'package:talktohumanity/c_services/protocols/user_image_protocols.dart';
import 'package:talktohumanity/c_services/protocols/user_protocols/user_protocols.dart';
import 'package:super_fire/super_fire.dart';

class AuthProtocols {
  // -----------------------------------------------------------------------------

  const AuthProtocols();

  // -----------------------------------------------------------------------------

  /// ANONYMOUS

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<bool> simpleAnonymousSignIn({
    GlobalKey flushbarKey,
  }) async {
    bool _success = false;

    if (Authing.getUserID() == null){

      /// SIGN ANONYMOUS USER
      final AuthModel _authModel = await Authing.anonymousSignin(
        onError: (String error) => showAuthFailureDialog(
          error: error,
          flushbarKey: flushbarKey,
        ),
      );

      /// COMPOSE ANONYMOUS USER
      _success = await _composeUserByAuthModel(
        authModel: _authModel,
      );

    }

    return _success;
  }
  // -----------------------------------------------------------------------------

  /// EMAIL

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<bool> simpleEmailSignin({
    @required String email,
    @required String password,
    @required GlobalKey flushbarKey,
  }) async {
    bool _success = false;

    if (email != null && password != null) {

      final bool _timeIsCorrect = await TimingProtocols.checkDeviceTime();

      if (_timeIsCorrect == true) {

        final AuthModel _authModel = await EmailAuthing.signIn(
          email: email,
          password: password,
          onError: (String error) => showAuthFailureDialog(
            error: error,
            flushbarKey: flushbarKey,
          ),
        );

        _success = await _composeUserByAuthModel(
          authModel: _authModel,
        );

        await showAuthSuccessDialog(
          success: _success,
          flushbarKey: flushbarKey,
          userName: _authModel?.name,
        );
      }
    }

    return _success;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<bool> simpleEmailSignUp({
    @required String email,
    @required String password,
    @required GlobalKey flushbarKey,
  }) async {
    bool _success = false;

    if (email != null && password != null) {
      final bool _timeIsCorrect = await TimingProtocols.checkDeviceTime();

      if (_timeIsCorrect == true) {
        final AuthModel _authModel = await EmailAuthing.register(
          email: email,
          password: password,
          onError: (String error) => showAuthFailureDialog(
            error: error,
            flushbarKey: flushbarKey,
          ),
        );

        _success = await _composeUserByAuthModel(
          authModel: _authModel,
        );

        await showAuthSuccessDialog(
          success: _success,
          flushbarKey: flushbarKey,
          userName: _authModel?.name,
        );
      }
    }

    return _success;
  }
  // -----------------------------------------------------------------------------
  /*
  /// GOOGLE

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<bool> simpleGoogleSignIn({
    @required GlobalKey flushbarKey,
  }) async {
    bool _success = false;

    final bool _timeIsCorrect = await TimingProtocols.checkDeviceTime();

    if (_timeIsCorrect == true){

      final AuthModel _authModel = await GoogleAuthing.emailSignIn(
        onError: (String error) => showAuthFailureDialog(
          error: error,
          flushbarKey: flushbarKey,
        ),
      );

      _success = await _composeUserByAuthModel(
        authModel: _authModel,
      );

      await showAuthSuccessDialog(
        success: _success,
        flushbarKey: flushbarKey,
        userName: _authModel?.name,
      );

    }

    return _success;
  }
  // -----------------------------------------------------------------------------

  /// APPLE

  // --------------------
  ///
  static Future<bool> simpleAppleSignIn({
    @required GlobalKey flushbarKey,
  }) async {
    bool _success = false;

    final bool _timeIsCorrect = await TimingProtocols.checkDeviceTime();

    if (_timeIsCorrect == true){

      final AuthModel _authModel = await AppleAuthing.signInByApple(
        onError: (String error) => showAuthFailureDialog(
          error: error,
          flushbarKey: flushbarKey,
        ),
      );

      _success = await _composeUserByAuthModel(
        authModel: _authModel,
      );

      await showAuthSuccessDialog(
        success: _success,
        flushbarKey: flushbarKey,
        userName: _authModel?.name,
      );

    }

    return _success;
  }
  // -----------------------------------------------------------------------------

  /// FACEBOOK

  // --------------------
  ///
  static Future<bool> simpleFacebookSignIn({
    @required GlobalKey flushbarKey,
  }) async {
    bool _success = false;

    final bool _timeIsCorrect = await TimingProtocols.checkDeviceTime();

    if (_timeIsCorrect == true){

      final AuthModel _authModel = await FacebookAuthing.signIn(
        onError: (String error) => showAuthFailureDialog(
          error: error,
          flushbarKey: flushbarKey,
        ),
      );

      _success = await _composeUserByAuthModel(
        authModel: _authModel,
      );

      await showAuthSuccessDialog(
        success: _success,
        flushbarKey: flushbarKey,
        userName: _authModel?.name,
      );

    }

    return _success;
  }
   */
  // --------------------
  ///
  static Future<bool> onReceiveAuthModel({
    @required AuthModel authModel,
    @required GlobalKey flushbarKey,
  }) async {
    bool _success = false;

    if (authModel != null) {

      _success = await _composeUserByAuthModel(
        authModel: authModel,
      );

      await showAuthSuccessDialog(
        success: _success,
        flushbarKey: flushbarKey,
        userName: authModel?.name,
      );

    }

    return _success;
  }
  // -----------------------------------------------------------------------------

  /// HANDLERS

  // --------------------
  ///
  static Future<bool> _composeUserByAuthModel({
    @required AuthModel authModel,
  }) async {
    bool _success = false;

    if (authModel != null) {

      final UserModel _userModel = await UserProtocols.fetchUser(userID: authModel?.id);

      if (_userModel == null) {

        final String _imageURL = await _stealUserImage(
          authModel: authModel,
        );
        final UserModel _userModel = await UserModel.createUserModelFromAuthModel(
          authModel: authModel,
          imageOverride: _imageURL,
        );

        /// COMPOSE ANONYMOUS USER
        await UserProtocols.composeUser(userModel: _userModel);
        _success = true;
      }
      else {
        _success = true;
      }

    }

    return _success;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<String> _stealUserImage({
    @required AuthModel authModel,
  }) async {
    String _newURL;

    blog('1 steal user Image : start');
    if (authModel != null && authModel.id != null) {

      final String _thirdPartyURL = authModel.imageURL;

      if (_thirdPartyURL != null) {

        final Uint8List _bytes = await UserImageProtocols.downloadUserPic(
          imageURL: _thirdPartyURL,
        );

        blog('2 steal user Image : _bytes : ${_bytes.length} bytes');

        if (_bytes != null) {
          _newURL = await UserImageProtocols.uploadBytesAndGetURL(
            userID: authModel.id,
            bytes: _bytes,
          );
          blog('3 steal user Image : _newURL : $_newURL');
        }

      }
    }

    return _newURL;
  }
  // -----------------------------------------------------------------------------

  /// AUTH DIALOGS

  // --------------------
  ///
  static Future<void> showAuthFailureDialog({
    @required String error,
    @required GlobalKey flushbarKey,
  }) async {

    if (error != null){

      await TalkDialog.topDialog(
        flushbarKey: flushbarKey,
        headline: 'Sing in failed',
        milliseconds: 10000,
        secondLine: AuthError.getErrorReply(error: error),
      );
    }

  }
  // --------------------
  ///
  static Future<void> showAuthSuccessDialog({
    @required bool success,
    @required String userName,
    @required GlobalKey flushbarKey,
  }) async {

    if (flushbarKey != null && success == true){

      await TalkDialog.topDialog(
        flushbarKey: flushbarKey,
        headline: 'Successfully signed in',
        milliseconds: 10000,
        secondLine: 'Welcome ${userName ?? '...'}',
      );

    }

  }
  // -----------------------------------------------------------------------------
}
