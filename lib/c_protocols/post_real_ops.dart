import 'package:flutter/material.dart';
import 'package:mapper/mapper.dart';
import 'package:real/real.dart';
import 'package:talktohumanity/a_models/post_model.dart';
import 'package:talktohumanity/d_helpers/helper_methods.dart';

class PostRealOps {
  // -----------------------------------------------------------------------------

  const PostRealOps();

  // -----------------------------------------------------------------------------
  static const String publishedPostsColl = 'publishedPosts';
  static const String pendingPostsColl = 'pendingPosts';
  static const userPic = 'userPic';
  // -----------------------------------------------------------------------------

  /// CREATE

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<PostModel> createNewPost({
    @required PostModel post,
    @required String collName,
  }) async {

    PostModel _output;

    if (post != null){

      await Real.createNamedDoc(
        collName: collName,
        docName: post.id,
        map: post.toMap(toJSON: true),
      );

      _output = post;

    }

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// READ

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<List<PostModel>> readAllPublishedPosts() async {
    final List<PostModel> _output = <PostModel>[];

    final dynamic _map = await Real.readPath(
      path: publishedPostsColl,
    );

    if (_map != null){

      final Map<String, dynamic> _allPostsMap = Mapper.getMapFromIHLMOO(
        ihlmoo: _map,
      );

      final List<String> _keys = _allPostsMap.keys.toList();

      if (Mapper.checkCanLoopList(_keys) == true){

        for (final String key in _keys){

          Map<String, dynamic> _map = _allPostsMap[key];
          _map = Mapper.insertPairInMap(
            map: _map,
            key: 'id',
            value: key,
            overrideExisting: true,
          );

          final PostModel _postModel = PostModel.decipherPost(
              map: _map,
              fromJSON: true,
          );

          _output.add(_postModel);

        }

      }

    }

    return _output;
  }
  // --------------------
  /// TASK : TEST ME
  static Future<PostModel> readPost({
    @required String collName,
    @required String postID,
  }) async {
    PostModel _output;

    if (collName != null && postID != null){

      final Map<String, dynamic> _map = await Real.readDoc(
          collName: collName,
          docName: postID,
      );

      _output = PostModel.decipherPost(map: _map, fromJSON: true);

    }

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// UPDATE

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> likePost(PostModel post) async {
    if (post != null) {

      await Real.incrementDocFields(
        context: getContext(),
        collName: publishedPostsColl,
        docName: post.id,
        isIncrementing: true,
        incrementationMap: {
          'likes': 1,
        },
      );
    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> dislikePost(PostModel post) async {

    if (post != null){

      await Real.incrementDocFields(
        context: getContext(),
        collName: publishedPostsColl,
        docName: post.id,
        isIncrementing: false,
        incrementationMap: {
          'likes': 1,
        },
      );
    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> viewPost(PostModel post) async {

    if (post != null){

      await Real.incrementDocFields(
        context: getContext(),
        collName: publishedPostsColl,
        docName: post.id,
        isIncrementing: true,
        incrementationMap: {
          'views': 1,
        },
      );
    }
      }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> movePost({
    @required String postID,
    @required String fromColl,
    @required String toColl,
  }) async {

    if (postID != null && fromColl != null && toColl != null){

      final PostModel _post = await readPost(
          collName: fromColl,
          postID: postID
      );

      if (_post != null){

        final PostModel _uploaded = await createNewPost(
            post: _post,
            collName: toColl,
        );

        if (_uploaded != null){

          await deletePost(
              postID: postID,
              collName: fromColl,
          );

        }


      }

    }

  }
  // -----------------------------------------------------------------------------

  /// DELETE

  // --------------------
  /// TASK : TEST ME
  static Future<void> deletePost({
    @required String postID,
    @required String collName,
  }) async {
    if (postID != null && collName != null) {
      await Real.deleteDoc(
        collName: collName,
        docName: postID,
      );
    }
  }
  // -----------------------------------------------------------------------------
}
