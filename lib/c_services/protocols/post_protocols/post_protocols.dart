

import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:mediators/mediators.dart';
import 'package:storage/foundation/pic_meta_model.dart';
import 'package:storage/storage.dart';
import 'package:talktohumanity/a_models/post_model.dart';
import 'package:talktohumanity/c_services/protocols/post_protocols/post_ldb_ops.dart';
import 'package:talktohumanity/c_services/protocols/post_protocols/post_real_ops.dart';

class PostProtocols {
 // -----------------------------------------------------------------------------

 const PostProtocols();

  // -----------------------------------------------------------------------------

  /// COMPOSE

  // --------------------
  Future<void> publishPost({
    @required PostModel postModel,
  }) async {

  }
  // --------------------
    /// TESTED : WORKS PERFECT
  static Future<String> uploadPosterImageAndGetURL({
    @required Uint8List bytes,
    @required String ownerID,
    @required String postID,
  }) async {
  String _output;

  if (bytes != null && ownerID != null) {
    final Dimensions _dims = await Dimensions.superDimensions(bytes);

    final Reference _ref = await Storage.uploadBytes(
      bytes: bytes,
      path: 'talkersImages/$postID',
      metaData: PicMetaModel(
        ownersIDs: [ownerID],
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

  /// FETCH

  // --------------------

  // -----------------------------------------------------------------------------

  /// RENOVATE

  // --------------------
  static Future<void> renovate({
    @required PostModel post,
    @required String realCollName,
    @required String ldbDocName,
  }) async {

    if (post != null && post.id != null){

      await PostRealOps.createNewPost(
          post: post,
          collName: realCollName
      );

      await PostLDBPOps.insertPost(
        post: post,
        docName: ldbDocName,
      );

    }

  }
  // -----------------------------------------------------------------------------

  /// WIPE

  // --------------------

  // -----------------------------------------------------------------------------
}
