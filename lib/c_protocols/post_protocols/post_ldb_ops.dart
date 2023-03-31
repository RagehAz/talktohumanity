import 'package:flutter/material.dart';
import 'package:talktohumanity/packages/ldb/lib/ldb.dart';
import 'package:talktohumanity/a_models/post_model.dart';

class PostLDBPOps {
  // --------------------------------------------------------------------------

  const PostLDBPOps();

  // -----------------------------------------------------------------------------
  static const String myViews = 'myViews';
  static const String myLikes = 'myLikes';
  static const String publishedPosts = 'publishedPosts';
  // -----------------------------------------------------------------------------

  /// CREATE

  // --------------------
  /// TESTED : WORKS PERFECT
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
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> insertPosts({
    @required List<PostModel> posts,
    @required String docName,
  }) async {

    await LDBOps.insertMaps(
      docName: docName,
      primaryKey: 'id',
      inputs: PostModel.cipherPosts(posts: posts, toJSON: true),
    );

  }
  // -----------------------------------------------------------------------------

  /// READ

  // --------------------
  /// TESTED : WORKS PERFECT
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
  /// TESTED : WORKS PERFECT
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
  /// TESTED : WORKS PERFECT
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
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> wipeAllPosts() async {
    await LDBOps.deleteAllMapsAtOnce(docName: publishedPosts);
  }
  // -----------------------------------------------------------------------------
}
