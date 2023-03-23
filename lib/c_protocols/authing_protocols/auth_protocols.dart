import 'dart:typed_data';
import 'package:filers/filers.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:talktohumanity/a_models/user_model.dart';
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
  static Future<void> simpleAnonymousSignIn() async {

    if (Authing.getUserID() == null){

      /// SIGN ANONYMOUS USER
      final UserCredential _cred = await Authing.anonymousSignin();

      final UserModel _userModel = await UserModel.createUserModelFromCredential(
        credential: _cred,
        signInMethod: 'anonymous',
      );

      /// COMPOSE ANONYMOUS USER
      await UserProtocols.composeUser(userModel: _userModel);

    }
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> simpleGoogleSignIn() async {

    final bool _timeIsCorrect = await TimingProtocols.checkDeviceTime();

    if (_timeIsCorrect == true){

      final UserCredential _cred = await GoogleAuthing.emailSignIn();

      final UserModel _userModel = await UserProtocols.fetchUser(userID: _cred?.user?.uid);

      if (_userModel != null) {
        final String _imageURL = await _stealUserImage(
          user: _cred?.user,
        );
        final UserModel _userModel = await UserModel.createUserModelFromCredential(
          credential: _cred,
          signInMethod: 'google',
          imageURL: _imageURL,
        );
        /// COMPOSE ANONYMOUS USER
        await UserProtocols.composeUser(userModel: _userModel);
      }

    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<String> _stealUserImage({
    @required User user,
  }) async {
    String _newURL;

    blog('1 steal user Image : start');
    if (user != null && user.uid != null) {
      final Uint8List _bytes = await UserImageProtocols.downloadUserPic(
        user: user,
      );

      blog('2 steal user Image : _bytes : ${_bytes.length} bytes');

      if (_bytes != null) {
        _newURL = await UserImageProtocols.uploadBytesAndGetURL(
          userID: user.uid,
          bytes: _bytes,
        );
        blog('3 steal user Image : _newURL : $_newURL');
      }
    }

    return _newURL;
  }
  // -----------------------------------------------------------------------------
}
