import 'package:flutter/material.dart';
import 'package:ldb/ldb.dart';
import 'package:talktohumanity/model/post_model.dart';

class PostLDBPOps {
  // --------------------------------------------------------------------------

  const PostLDBPOps();

  // -----------------------------------------------------------------------------
  static const String myViews = 'myViews';
  static const String myLikes = 'myLikes';
  // -----------------------------------------------------------------------------

  /// CREATE

  // --------------------
  ///
  static Future<void> insertPost({
    @required PostModel post,
    @required String docName,
  }) async {

    if (post != null){

        await LDBOps.insertMap(
          docName: docName,
          primaryKey: 'id',
          input: post.toMap(toJSON: true),
        );
    }

  }
  // -----------------------------------------------------------------------------

  /// READ

  // --------------------
  ///
  static Future<List<PostModel>> readAll({
    @required String docName,
  }) async {

    final List<Map<String, dynamic>> _viewed = await LDBOps.readAllMaps(
      docName: docName,
    );

    return PostModel.decipherPosts(
        maps: _viewed,
        fromJSON: true,
    );

  }
  // --------------------
  ///
  static Future<bool> checkIsInserted({
    @required PostModel post,
    @required String docName,
  }) async{

    final Map<String, dynamic> _postMap = await LDBOps.searchFirstMap(
        sortFieldName: 'id',
        searchFieldName: 'id',
        searchValue: post?.id,
        docName: docName,
    );

    return _postMap != null;
  }
  // -----------------------------------------------------------------------------

  /// DELETE

  // --------------------
  ///
  static Future<void> deletePost({
    @required PostModel post,
    @required String docName,
  }) async {

    if (post != null){

        await LDBOps.deleteMap(
          docName: docName,
          primaryKey: 'id',
          objectID: post.id,
        );
    }

  }
  // -----------------------------------------------------------------------------
  // -----------------------------------------------------------------------------
}
