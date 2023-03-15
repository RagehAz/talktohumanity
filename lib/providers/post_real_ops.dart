import 'package:flutter/material.dart';
import 'package:mapper/mapper.dart';
import 'package:real/real.dart';
import 'package:talktohumanity/model/post_model.dart';
import 'package:talktohumanity/services/helper_methods.dart';

class PostRealOps {
  // -----------------------------------------------------------------------------

  const PostRealOps();

  // -----------------------------------------------------------------------------
  static const String publishedPosts = 'publishedPosts';
  // -----------------------------------------------------------------------------

  /// CREATE

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<PostModel> createNewPost({
    @required PostModel post,
  }) async {

    PostModel _output;

    if (post != null){

      final Map<String, dynamic> _map =
      await Real.createDoc(
        collName: publishedPosts,
        map: post.toMap(toJSON: true),
        addDocIDToOutput: true, // DOESN'T ALWAYS SUCCESSFULLY REPLACE WITH NEW ID, DUNNO WHY
      );

      _output = post.copyWith(
        id: _map['id'],
      );

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
      path: publishedPosts,
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
  // -----------------------------------------------------------------------------

  /// UPDATE

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> likePost(PostModel post) async {
    if (post != null) {

      await Real.incrementDocFields(
        context: getContext(),
        collName: publishedPosts,
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
        collName: publishedPosts,
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
        collName: publishedPosts,
        docName: post.id,
        isIncrementing: true,
        incrementationMap: {
          'views': 1,
        },
      );
    }
      }
  // -----------------------------------------------------------------------------

  /// DELETE

  // --------------------
  ///
  // -----------------------------------------------------------------------------
}
