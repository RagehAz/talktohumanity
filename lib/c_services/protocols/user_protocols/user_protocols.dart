import 'package:flutter/material.dart';
import 'package:talktohumanity/a_models/user_model.dart';
import 'package:talktohumanity/c_services/protocols/user_protocols/user_fire_ops.dart';
import 'package:talktohumanity/c_services/protocols/user_protocols/user_ldb_ops.dart';

class UserProtocols {
  // -----------------------------------------------------------------------------

  const UserProtocols();

  // -----------------------------------------------------------------------------

  /// USE CASES

  // --------------------
  ///
  // -----------------------------------------------------------------------------

  /// OVERRIDES

  // --------------------
  ///
  static Future<UserModel> composeUser({
    @required UserModel userModel,
  }) async {
    UserModel _output;
    if (userModel != null){

      final UserModel _uploaded = await UserFireOps.create(
        userModel: userModel,
      );

      await UserLDBOps.insert(
        userModel: _uploaded,
      );

      _output = _uploaded;

    }

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// OVERRIDES

  // --------------------
  ///
  static Future<UserModel> fetchUser({
    @required String userID,
  }) async {

    UserModel _userModel = await UserLDBOps.readMyUser(
      userID: userID,
    );

    if (_userModel == null){

      _userModel = await UserFireOps.read(userID: userID);

      if (_userModel != null){
        await UserLDBOps.insert(userModel: _userModel);
      }

    }

    return _userModel;
  }
  // -----------------------------------------------------------------------------

  /// OVERRIDES

  // --------------------
  ///
  static Future<void> renovateUser({
    @required UserModel newUser,
    @required UserModel oldUser,
  }) async {

    final bool _identical = UserModel.checkUsersAreIdentical(
        user1: newUser,
        user2: oldUser,
      );

    if (newUser != null && _identical == false){

      /// ID HAS CHANGED
      if (oldUser != null && oldUser.id != newUser.id){
        await _recreateUser(
          oldUser: oldUser,
          newUser: newUser,
        );
      }

      /// ID IS THE SAME
      else {
        await _updateUser(
          oldUser: oldUser,
          newUser: newUser,
        );
      }

    }

  }
  // --------------------
  ///
  static Future<void> _recreateUser({
    @required UserModel oldUser,
    @required UserModel newUser,
  }) async {

    if (newUser != null){

      await wipeUser(userID: oldUser.id);

      await composeUser(userModel: newUser);

    }

  }
  // --------------------
  ///
  static Future<void> _updateUser({
    @required UserModel oldUser,
    @required UserModel newUser,
  }) async {

    await Future.wait(<Future>[

      /// FIRE
      UserFireOps.update(newUser: newUser, oldUser: oldUser),

      /// LDB
      UserLDBOps.insert(
        userModel: newUser,
      ),

    ]);

  }
  // -----------------------------------------------------------------------------

  /// OVERRIDES

  // --------------------
  ///
  static Future<void> wipeUser({
    @required String userID,
  }) async {

    if (userID != null){

      await Future.wait(<Future>[

        /// FIRE
        UserFireOps.delete(userID: userID),

        /// LDB
        UserLDBOps.deleteMyUser(userID: userID),

      ]);

    }

  }
  // -----------------------------------------------------------------------------
}
