import 'dart:typed_data';

import 'package:filers/filers.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:mediators/mediators.dart';
import 'package:storage/foundation/pic_meta_model.dart';
import 'package:storage/storage.dart';

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
  // -----------------------------------------------------------------------------

  /// READ

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<Uint8List> downloadUserPic({
    @required String imageURL,
  }) async {
    Uint8List _output;

    if (imageURL != null){

      _output = await Floaters.getUint8ListFromURL(imageURL);

    }

    return _output;
  }
  // -----------------------------------------------------------------------------
}
