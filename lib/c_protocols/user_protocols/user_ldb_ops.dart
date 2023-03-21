import 'package:flutter/material.dart';
import 'package:ldb/ldb.dart';
import 'package:mapper/mapper.dart';
import 'package:talktohumanity/a_models/user_model.dart';

class UserLDBOps {
  // -----------------------------------------------------------------------------

  const UserLDBOps();
  // -----------------------------------------------------------------------------
  static const String myUser = 'myUser';
  // -----------------------------------------------------------------------------

  /// CREATE

  // --------------------
  ///
  static Future<void> insertMyUser({
    @required UserModel userModel,
  }) async {

    if (userModel != null && userModel.id != null){

      await LDBOps.deleteAllMapsAtOnce(docName: myUser);

      await LDBOps.insertMap(
          docName: myUser,
          primaryKey: 'id',
          input: userModel.toMap(toJSON: true,),
      );

    }

  }
  // -----------------------------------------------------------------------------

  /// READ

  // --------------------
  ///
  static Future<UserModel> readMyUser() async {
    UserModel _output;

      final List<Map<String, dynamic>> _maps = await LDBOps.readAllMaps(
          docName: myUser,
      );

      if (Mapper.checkCanLoopList(_maps) == true){
        _output = UserModel.decipher(
            map: _maps.first,
            fromJSON: true,
        );
      }

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// DELETE

  // --------------------
  ///
  static Future<void> deleteMyUser() async {
    await LDBOps.deleteAllMapsAtOnce(docName: myUser);
  }
  // -----------------------------------------------------------------------------

  /*
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
   */
}
