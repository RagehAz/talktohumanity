

import 'package:flutter/material.dart';
import 'package:ldb/ldb.dart';
import 'package:talktohumanity/a_models/user_model.dart';

class UserLDBOps {
  // -----------------------------------------------------------------------------

  const UserLDBOps();
  // -----------------------------------------------------------------------------
  static const String usersColl = 'usersColl';
  // -----------------------------------------------------------------------------

  /// CREATE

  // --------------------
  ///
  static Future<void> insert({
    @required UserModel userModel,
  }) async {

    if (userModel != null && userModel.id != null){

      await LDBOps.insertMap(
          docName: usersColl,
          primaryKey: 'id',
          input: userModel.toMap(toJSON: true,),
      );

    }

  }
  // -----------------------------------------------------------------------------

  /// READ

  // --------------------
  ///
  static Future<UserModel> read({
    @required String userID,
  }) async {
    UserModel _output;

    if (userID != null){

      final Map<String, dynamic> _map = await LDBOps.readMap(
          docName: usersColl,
          id: userID,
          primaryKey: 'id',
      );

      _output = UserModel.decipher(
          map: _map,
          fromJSON: true,
      );

    }

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// DELETE

  // --------------------
  ///
  static Future<void> delete({
    @required String userID,
  }) async {
    if (userID != null) {
      await LDBOps.deleteMap(
        objectID: userID,
        docName: usersColl,
        primaryKey: 'id',
      );
    }
  }
  // -----------------------------------------------------------------------------
}
