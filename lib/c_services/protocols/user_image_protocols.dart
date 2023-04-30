import 'dart:typed_data';
import 'package:filers/filers.dart';
import 'package:flutter/material.dart';
import 'package:mediators/mediators.dart';
import 'package:super_fire/super_fire.dart';

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

  if (bytes != null && userID != null) {
    final Dimensions _dims = await Dimensions.superDimensions(bytes);

    final Reference _ref = await Storage.uploadBytes(
      bytes: bytes,
      path: '$usersPics/$userID',
      metaData: PicMetaModel(
        ownersIDs: [userID],
        height: _dims.height,
        width: _dims.width,
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
