

import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:talktohumanity/a_models/user_model.dart';
import 'package:talktohumanity/c_protocols/image_protocols/user_image_protocols.dart';
import 'package:talktohumanity/c_protocols/user_protocols/user_ldb_ops.dart';
import 'package:talktohumanity/c_protocols/user_protocols/user_protocols.dart';
import 'package:talktohumanity/packages/lib/authing.dart';

class AuthProtocols {
  // -----------------------------------------------------------------------------

 const AuthProtocols();

 // -----------------------------------------------------------------------------

 ///

 // --------------------
 ///
  static Future<void> anonymousUserSignIn() async {

    /// WHEN FIREBASE USER ID IS PRESENT -> NO NEED TO SIGN IN
    if (Authing.getUserID() == null){

      /// SIGN ANONYMOUS USER
      final UserCredential _cred = await Authing.anonymousSignin();

      final UserModel _userModel = await UserLDBOps.readMyUser();

      /// WHEN NO LDB USER FOUND
      if (_userModel == null){
        await _composeAnonymousUser(
          cred: _cred,
        );
      }

      /// WHEN LDB USER FOUND
      else {

        await _changeAnonymousUserID(
          oldUser: _userModel,
          credential: _cred,
        );

      }

    }

  }
 // --------------------
  ///
  static Future<void> _composeAnonymousUser({
    @required UserCredential cred,
  }) async {

    if (cred != null) {

      final String _newImageURL = await _stealUserImage(
        user: cred.user,
      );

      final UserModel _userModel = await UserModel.createAnonymousUserFromCredential(
        credential: cred,
        imageURL: _newImageURL,
      );

      /// COMPOSE ANONYMOUS USER
      await UserProtocols.composeUser(userModel: _userModel);

    }

  }

  // --------------------
  ///
  static Future<String> _stealUserImage({
    @required User user,
  }) async {
    String _newURL;

    if (user != null && user.uid != null) {
      final Uint8List _bytes = await UserImageProtocols.downloadUserPic(
        user: user,
      );

      if (_bytes != null) {
        _newURL = await UserImageProtocols.uploadBytesAndGetURL(
          userID: user.uid,
          bytes: _bytes,
        );
      }

    }

    return _newURL;
  }
  // --------------------
 ///
  static Future<void> _changeAnonymousUserID({
    @required UserCredential credential,
    @required UserModel oldUser,
  }) async {

    if (credential != null && oldUser != null) {

      /// NOTE : ANONYMOUS USER NEVER HAD AN IMAGE

      /// MODEL NEW USER
      final UserModel _newUser = oldUser.copyWith(
        id: credential.user?.uid,
      );

      /// RENOVATE USER
      await UserProtocols.renovateUser(
          newUser: _newUser,
          oldUser: oldUser,
      );

      /// DELETE OLD FIREBASE USER
      await Authing.deleteFirebaseUser(
        userID: oldUser.id,
      );

    }

  }
  // -----------------------------------------------------------------------------

  /// FIREBASE AUTH

  // --------------------

  // -----------------------------------------------------------------------------

  /// FIREBASE AUTH

  // --------------------

  // -----------------------------------------------------------------------------
}
