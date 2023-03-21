import 'package:fire/fire.dart';
import 'package:flutter/material.dart';
import 'package:mapper/mapper.dart';
import 'package:talktohumanity/a_models/user_model.dart';

class UserFireOps {
  // -----------------------------------------------------------------------------

  const UserFireOps();

  // -----------------------------------------------------------------------------
  static const String usersColl = 'usersColl';
  // -----------------------------------------------------------------------------

  /// CREATE

  // --------------------
  ///
  static Future<UserModel> create({
    @required UserModel userModel,
  }) async {

    UserModel _output;

    if (userModel != null){

      /// CREATE RANDOM ID
      if (userModel.id == null) {
        await Fire.createDoc(
            collName: usersColl,
            input: userModel.toMap(toJSON: false),
            addDocID: true,
            onFinish: (ref) {
              _output = userModel.copyWith(
                id: ref.id,
              );
            });
      }

      /// USER ID IS PRE-DEFINED
      else {
        await Fire.createNamedDoc(
          collName: usersColl,
          input: userModel.toMap(toJSON: false),
          docName: userModel.id,
        );
        _output = userModel;
      }

    }

    return _output;
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

      final Map<String, dynamic> map = await Fire.readDoc(
          collName: usersColl,
          docName: userID,
      );

      _output = UserModel.decipher(
          map: map,
          fromJSON: false,
      );

    }

    return _output;
  }
  // --------------------
  ///
  static Future<UserModel> findUserByDevice({
    @required String deviceID,
  }) async {
    UserModel _output;

    if (deviceID != null){

      final List<Map<String, dynamic>> maps = await Fire.readCollectionDocs(
        collName: usersColl,
        limit: 1,
        addDocsIDs: true,
        finders: <FireFinder>[

          FireFinder(
            field: 'deviceID',
            comparison: FireComparison.equalTo,
            value: deviceID,
          ),

        ],
      );

      if (Mapper.checkCanLoopList(maps) == true){

        _output = UserModel.decipher(
            map: maps.first,
            fromJSON: false,
        );

      }

    }

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// UPDATE

  // --------------------
  ///
  static Future<void> update({
    @required UserModel newUser,
    @required UserModel oldUser,
  }) async {

    if (newUser != null){

      final bool _identical = UserModel.checkUsersAreIdentical(
          user1: newUser,
          user2: oldUser,
      );

      if (_identical == false){

        await Fire.updateDoc(
            collName: usersColl,
            docName: newUser.id,
            input: newUser.toMap(toJSON: false),
        );

      }

    }

  }
  // -----------------------------------------------------------------------------

  /// DELETE

  // --------------------
  ///
  static Future<void> delete({
    @required String userID,
  }) async {

    if (userID != null){

      await Fire.deleteDoc(
          collName: usersColl,
          docName: userID,
      );

    }

  }
  // -----------------------------------------------------------------------------
}
