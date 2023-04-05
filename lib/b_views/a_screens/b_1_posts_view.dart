import 'package:bldrs_theme/bldrs_theme.dart';
import 'package:dialogs/dialogs.dart';
import 'package:filers/filers.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:layouts/layouts.dart';
import 'package:ldb/ldb.dart';
import 'package:mapper/mapper.dart';
import 'package:mediators/mediators.dart';
import 'package:scale/scale.dart';
import 'package:super_box/super_box.dart';
import 'package:talktohumanity/a_models/post_model.dart';
import 'package:talktohumanity/b_views/b_widgets/c_dialogs/talk_dialogs.dart';
import 'package:talktohumanity/b_views/b_widgets/c_dialogs/wait_dialog.dart';
import 'package:talktohumanity/b_views/b_widgets/e_timeline/timeline_builder.dart';
import 'package:talktohumanity/c_services/helpers/routing.dart';
import 'package:talktohumanity/c_services/protocols/post_protocols/post_ldb_ops.dart';
import 'package:talktohumanity/c_services/protocols/post_protocols/post_protocols.dart';
import 'package:talktohumanity/c_services/protocols/post_protocols/post_real_ops.dart';
import 'package:talktohumanity/c_services/helpers/standards.dart';
import 'package:widget_fader/widget_fader.dart';

class PostsView extends StatefulWidget {
  // --------------------------------------------------------------------------
  const PostsView({
    Key key
  }) : super(key: key);
  // --------------------------------------------------------------------------
  @override
  State<PostsView> createState() => _PostsViewState();
  // --------------------------------------------------------------------------
}

class _PostsViewState extends State<PostsView> {
  // -----------------------------------------------------------------------------
  final ScrollController _scrollController = ScrollController();
  // --------------------
  List<PostModel> _publishedPosts = [];
  // -----------------------------------------------------------------------------
  /// --- LOADING
  final ValueNotifier<bool> _loading = ValueNotifier(true);
  // --------------------
  Future<void> _triggerLoading({@required bool setTo}) async {
    setNotifier(
      notifier: _loading,
      mounted: mounted,
      value: setTo,
    );
  }
  // -----------------------------------------------------------------------------
  @override
  void initState() {
    super.initState();
  }
  // --------------------
  bool _isInit = true;
  @override
  void didChangeDependencies() {
    if (_isInit && mounted) {
      _triggerLoading(setTo: true).then((_) async {

        await fetchAllPublishedPosts();

        await _triggerLoading(setTo: false);
      });

      _isInit = false;
    }
    super.didChangeDependencies();
  }
  // --------------------
  @override
  void dispose() {
    _loading.dispose();
    _scrollController.dispose();
    super.dispose();
  }
  // --------------------------------------------------------------------------
  /// TESTED : WORKS PERFECT
  Future<void> fetchAllPublishedPosts() async {

    List<PostModel> _posts = await PostLDBPOps.readAll(
      docName: PostLDBPOps.publishedPosts,
    );

    if (Mapper.checkCanLoopList(_posts) == false) {
      _posts = await PostRealOps.readAllPublishedPosts();
      blog('${_posts.length} posts found in REAL DB');
      if (Mapper.checkCanLoopList(_posts) == true) {
        await PostLDBPOps.insertPosts(
          posts: _posts,
          docName: PostLDBPOps.publishedPosts,
        );
      }
    }

    else {
      blog('${_posts.length} posts found in LDB');
    }

    setState(() {
      _publishedPosts = _posts;
    });
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  Future<void> _onLike(PostModel post) async {
    blog('is liked');

    final bool _isLiked = await PostLDBPOps.checkIsInserted(
      post: post,
      docName: PostLDBPOps.myLikes,
    );

    /// IS ALREADY LIKED => REMOVE LIKE
    if (_isLiked == true) {

      await Future.wait(<Future>[

        /// REMOVE FROM LDB
        PostLDBPOps.deletePost(
          post: post,
          docName: PostLDBPOps.myLikes,
        ),

        /// DECREMENT REAL COUNTER
        PostRealOps.dislikePost(post),

      ]);

      setState(() {
        _publishedPosts = PostModel.changeCounterCount(
          posts: _publishedPosts,
          post: post,
          field: 'likes',
          increment: -1,
        );
      });

    }

    /// IS NOT LIKED => CREATE A NEW LIKE
    else {

      /// INSERT IN LDB
      await Future.wait(<Future>[
        PostLDBPOps.insertPost(
          post: post,
          docName: PostLDBPOps.myLikes,
        ),

        /// INCREMENT REAL COUNTER
        PostRealOps.likePost(post),

      ]);

      setState(() {
        _publishedPosts = PostModel.changeCounterCount(
          posts: _publishedPosts,
          post: post,
          field: 'likes',
          increment: 1,
        );
      });

    }


    post.blogPost();
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  Future<void> _onView(PostModel post) async {

    final bool _isViewed = await PostLDBPOps.checkIsInserted(
      post: post,
      docName: PostLDBPOps.myViews,
    );

    if (_isViewed == false) {

      await Future.wait(<Future>[

        /// INSERT IN LDB
        PostLDBPOps.insertPost(
          post: post,
          docName: PostLDBPOps.myViews,
        ),

        /// INCREMENT REAL COUNTER
        PostRealOps.viewPost(post),

      ]);

      setState(() {
        _publishedPosts = PostModel.changeCounterCount(
          posts: _publishedPosts,
          post: post,
          field: 'views',
          increment: 1,
        );
      });
    }

    else {
      setState(() {});
    }

    post.blogPost();
  }
  // --------------------------------------------------------------------------
  Future<void> _onEditPost(PostModel post) async {

    if (Standards.isRageh() == true) {
      final GlobalKey flushbarKey = GlobalKey();

      await BottomDialog.showBottomDialog(
        context: context,
        draggable: true,
        height: 300,
        child: Column(
          children: [

            /// CHANGE POSTER IMAGE
            BottomDialog.wideButton(
                context: context,
                text: 'Change Image',
                onTap: () async {

                  final Uint8List _bytes = await PicMaker.pickAndCropSinglePic(
                    context: context,
                    cropAfterPick: true,
                    aspectRatio: 1,
                    resizeToWidth: 200,
                  );

                  if (_bytes != null) {
                    final bool _go = await TalkDialog.boolDialog(
                      title: 'Update pic ?',
                      invertButtons: true,
                    );

                    if (_go == true) {
                      await Nav.goBack(context: context);

                      pushTalkWaitDialog(context: context, text: 'Moving');

                      final String _newURL = await PostProtocols.uploadPosterImageAndGetURL(
                        bytes: _bytes,
                        ownerID: Standards.ragehID,
                        postID: post.id,
                      );

                      await PostProtocols.renovate(
                        post: post.copyWith(
                          pic: _newURL,
                        ),
                        realCollName: PostRealOps.publishedPostsColl,
                        ldbDocName: PostLDBPOps.publishedPosts,
                      );

                      await WaitDialog.closeWaitDialog(context);

                      await TalkDialog.topDialog(
                        flushbarKey: flushbarKey,
                        headline: 'Post is updated',
                      );

                      await Nav.pushNamedAndRemoveAllBelow(
                        context: context,
                        goToRoute: Routing.homeRoute,
                      );
                    }
                  }
                }),

            /// SUSPEND
            BottomDialog.wideButton(
                context: context,
                text: 'Approve',
                onTap: () async {

                  final bool _go = await TalkDialog.boolDialog(
                    title: 'Suspend ?',
                    invertButtons: true,
                  );

                  if (_go == true) {
                    await Nav.goBack(context: context);

                    pushTalkWaitDialog(context: context, text: 'Moving');

                    await PostRealOps.movePost(
                      postID: post.id,
                      fromColl: PostRealOps.publishedPostsColl,
                      toColl: PostLDBPOps.suspendedPosts,
                    );

                    await LDBOps.deleteAllMapsAtOnce(
                      docName: PostLDBPOps.publishedPosts,
                    );

                    await WaitDialog.closeWaitDialog(context);

                    await TalkDialog.topDialog(
                      flushbarKey: flushbarKey,
                      headline: 'Post is Moved',
                    );

                    await Nav.pushNamedAndRemoveAllBelow(
                      context: context,
                      goToRoute: Routing.homeRoute,
                    );
                  }
                }),

            /// DELETE
            BottomDialog.wideButton(
                context: context,
                text: 'Delete',
                onTap: () async {
                  final bool _go = await TalkDialog.boolDialog(
                    title: 'Delete ?',
                    invertButtons: true,
                  );

                  if (_go == true) {
                    await Nav.goBack(context: context);

                    pushTalkWaitDialog(context: context, text: 'Deleting');

                    await PostRealOps.deletePost(
                      postID: post.id,
                      collName: PostRealOps.publishedPostsColl,
                    );

                    await LDBOps.deleteAllMapsAtOnce(
                      docName: PostLDBPOps.publishedPosts,
                    );

                    await WaitDialog.closeWaitDialog(context);

                    await TalkDialog.topDialog(
                      flushbarKey: flushbarKey,
                      headline: 'Post is deleted',
                    );

                    await Nav.pushNamedAndRemoveAllBelow(
                      context: context,
                      goToRoute: Routing.homeRoute,
                    );

                  }
                }),

          ],
        ),
      );
    }

  }
  // --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    final double _screenWidth = Scale.screenWidth(context);
    final double _screenHeight = Scale.screenHeightGross(context);
    // --------------------
    return WidgetFader(
      fadeType: FadeType.fadeIn,
      duration: Standards.homeViewFadeDuration,
      child: Container(
        width: _screenWidth,
        height: _screenHeight,
        color: Colorz.black125,
        alignment: Alignment.topCenter,
        child: ValueListenableBuilder(
          valueListenable: _loading,
          child: Container(),
          builder: (_, bool isLoading, Widget child) {

            /// LOADING
            if (isLoading) {
              return const Loading(
                loading: true,
                color: Colorz.white255,
                size: 500,
              );
            }

            /// TIMELINES BUILDER
            else {
              return TimeLineBuilder(
                posts: _publishedPosts,
                onDoubleTap: _onEditPost,
                controller: _scrollController,
                onLike: (PostModel post) => _onLike(post),
                onView: (PostModel post) => _onView(post),
              );
            }
          },
        ),
      ),
    );
  }
}
