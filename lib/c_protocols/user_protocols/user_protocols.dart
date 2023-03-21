import 'package:flutter/material.dart';
import 'package:talktohumanity/a_models/user_model.dart';
import 'package:talktohumanity/c_protocols/user_protocols/user_fire_ops.dart';
import 'package:talktohumanity/c_protocols/user_protocols/user_ldb_ops.dart';

class UserProtocols {
  // -----------------------------------------------------------------------------

  const UserProtocols();

  // -----------------------------------------------------------------------------

  /// USE CASES

  // --------------------
  ///
  Future<void> changeUserID({
    @required String newID,
    @required String oldID,
  }) async {

    if (oldID != null && newID != null){

      final UserModel _oldUser = await fetchUser(userID: oldID);

      if (_oldUser != null){

        await UserLDBOps.deleteMyUser();

        final UserModel _uploaded = await composeUser(
            userModel: _oldUser.copyWith(
              id: newID,
            )
        );

        if (_uploaded != null){

          await UserFireOps.delete(userID: oldID);

        }

      }

    }

  }
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

      await UserLDBOps.insertMyUser(
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

    UserModel _userModel = await UserLDBOps.readMyUser();

    if (_userModel == null){

      _userModel = await UserFireOps.read(userID: userID);

      if (_userModel != null){
        await UserLDBOps.insertMyUser(userModel: _userModel);
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

    if (newUser != null){
      final bool _identical = UserModel.checkUsersAreIdentical(
        user1: newUser,
        user2: oldUser,
      );

      if (_identical == false) {
        await Future.wait(<Future>[

          /// FIRE
          UserFireOps.update(newUser: newUser, oldUser: oldUser),

          /// LDB
          UserLDBOps.insertMyUser(userModel: newUser,),

        ]);
      }
    }

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
        UserLDBOps.deleteMyUser(),

      ]);

    }

  }
  // -----------------------------------------------------------------------------
}
