import 'dart:typed_data';

import 'package:filers/filers.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:talktohumanity/a_models/user_model.dart';
import 'package:talktohumanity/b_views/b_widgets/c_dialogs/talk_dialogs.dart';
import 'package:talktohumanity/c_protocols/image_protocols/user_image_protocols.dart';
import 'package:talktohumanity/c_protocols/timing_protocols/timing_protocols.dart';
import 'package:talktohumanity/c_protocols/user_protocols/user_protocols.dart';
import 'package:talktohumanity/packages/lib/authing.dart';

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
      final UserCredential _cred = await Authing.anonymousSignin(
        onError: (String error) => showAuthFailureDialog(
          error: error,
          flushbarKey: flushbarKey,
        ),
      );

      /// COMPOSE ANONYMOUS USER
      _success = await _composeUserByNewCredential(
        cred: _cred,
      );

    }

    return _success;
  }
  // -----------------------------------------------------------------------------

  /// GOOGLE

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<bool> simpleGoogleSignIn({
    GlobalKey flushbarKey,
  }) async {
    bool _success = false;

    final bool _timeIsCorrect = await TimingProtocols.checkDeviceTime();

    if (_timeIsCorrect == true){

      final UserCredential _cred = await GoogleAuthing.emailSignIn(
        onError: (String error) => showAuthFailureDialog(
          error: error,
          flushbarKey: flushbarKey,
        ),
      );

      _success = await _composeUserByNewCredential(
        cred: _cred,
      );

      await showAuthSuccessDialog(
        success: _success,
        flushbarKey: flushbarKey,
        userName: _cred?.user?.displayName,
      );

    }

    return _success;
  }
  // -----------------------------------------------------------------------------

  /// FACEBOOK

  // --------------------
  ///
  static Future<bool> simpleFacebookSignIn({
    GlobalKey flushbarKey,
  }) async {
    bool _success = false;

    final bool _timeIsCorrect = await TimingProtocols.checkDeviceTime();

    if (_timeIsCorrect == true){

      final UserCredential _cred = await FacebookAuthing.signIn(
        onError: (String error) => showAuthFailureDialog(
          error: error,
          flushbarKey: flushbarKey,
        ),
        // passFacebookAuthCredential: (FacebookAuthCredential cred) => FacebookAuthing.blogFacebookAuthCredential(facebookAuthCredential: cred),
        // passLoginResult: (LoginResult result) => FacebookAuthing.blogLoginResult(loginResult: result),
      );

      _success = await _composeUserByNewCredential(
        cred: _cred,
      );

      await showAuthSuccessDialog(
        success: _success,
        flushbarKey: flushbarKey,
        userName: _cred?.user?.displayName,
      );

    }

    return _success;
  }
  // -----------------------------------------------------------------------------

  /// HANDLERS

  // --------------------
  ///
  static Future<bool> _composeUserByNewCredential({
    @required UserCredential cred,
  }) async {
    bool _success = false;
    final UserModel _userModel = await UserProtocols.fetchUser(userID: cred?.user?.uid);

    if (_userModel != null) {
      final String _imageURL = await _stealUserImage(
        cred: cred,
      );
      final UserModel _userModel = await UserModel.createUserModelFromCredential(
        cred: cred,
        imageOverride: _imageURL,
      );

      /// COMPOSE ANONYMOUS USER
      await UserProtocols.composeUser(userModel: _userModel);
      _success = true;
    }

    return _success;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<String> _stealUserImage({
    @required UserCredential cred,
  }) async {
    String _newURL;

    blog('1 steal user Image : start');
    if (cred != null && cred.user?.uid != null) {

      final String _thirdPartyURL = Authing.getUserImageURLFromCredential(cred);

      if (_thirdPartyURL != null) {

        final Uint8List _bytes = await UserImageProtocols.downloadUserPic(
          imageURL: _thirdPartyURL,
        );

        blog('2 steal user Image : _bytes : ${_bytes.length} bytes');

        if (_bytes != null) {
          _newURL = await UserImageProtocols.uploadBytesAndGetURL(
            userID: cred.user?.uid,
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
        secondLine: error,
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

    if (userName != null && flushbarKey != null && success == true){

      await TalkDialog.topDialog(
        flushbarKey: flushbarKey,
        headline: 'Successfully signed in',
        milliseconds: 10000,
        secondLine: 'Welcome $userName',
      );

    }

  }
  // -----------------------------------------------------------------------------
}
