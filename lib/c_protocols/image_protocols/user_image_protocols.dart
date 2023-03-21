import 'dart:typed_data';
import 'package:filers/filers.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:mediators/mediators.dart';
import 'package:storage/foundation/pic_meta_model.dart';
import 'package:storage/storage.dart';
import 'package:talktohumanity/packages/authing/authing.dart';

class UserImageProtocols {
  // -----------------------------------------------------------------------------

  const UserImageProtocols();

  // -----------------------------------------------------------------------------
  static const String usersPics = 'usersPics';
  // -----------------------------------------------------------------------------

  /// CREATE

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<String> uploadBytesAndGetURL({
    @required Uint8List bytes,
    @required String userID,
  }) async {
  String _output;

  if (bytes != null) {
    final Dimensions _dims = await Dimensions.superDimensions(bytes);

    final Reference _ref = await Storage.uploadBytes(
      bytes: bytes,
      path: '$usersPics/$userID',
      metaData: PicMetaModel(
        ownersIDs: [userID],
        dimensions: _dims,
      ).toSettableMetadata(),
    );

    _output = await Storage.createURLByRef(
      ref: _ref,
    );
  }

  return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<Uint8List> downloadUserPic() async {
    Uint8List _output;

    final User _user = Authing.getFirebaseUser();

    if (_user != null && _user.photoURL != null){

      _output = await Floaters.getUint8ListFromURL(_user?.photoURL);

    }

    return _output;
  }
  // -----------------------------------------------------------------------------
}
