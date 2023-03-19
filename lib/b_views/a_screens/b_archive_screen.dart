import 'package:bldrs_theme/bldrs_theme.dart';
import 'package:filers/filers.dart';
import 'package:flutter/material.dart';
import 'package:layouts/layouts.dart';
import 'package:mapper/mapper.dart';
import 'package:scale/scale.dart';
import 'package:super_box/super_box.dart';
import 'package:talktohumanity/a_models/post_model.dart';
import 'package:talktohumanity/b_views/a_screens/d_pending_posts_screen.dart';
import 'package:talktohumanity/b_views/b_widgets/e_timeline/timeline_builder.dart';
import 'package:talktohumanity/c_protocols/post_ldb_ops.dart';
import 'package:talktohumanity/c_protocols/post_real_ops.dart';

class ArchiveScreen extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const ArchiveScreen({
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  @override
  _ArchiveScreenState createState() => _ArchiveScreenState();
  /// --------------------------------------------------------------------------
}

class _ArchiveScreenState extends State<ArchiveScreen> {
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
    }

    setState(() {});

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

    }

    setState(() {});

    post.blogPost();
  }
  // --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    final double _screenWidth = Scale.screenWidth(context);
    final double _screenHeight = Scale.screenHeight(context);
    // --------------------
    return BasicLayout(
      body: SizedBox(
        width: _screenWidth,
        height: _screenHeight,
        child: ValueListenableBuilder(
          valueListenable: _loading,
          child: Container(),
          builder: (_, bool isLoading, Widget child) {

            if (isLoading) {
              return const Loading(
                loading: true,
                color: Colorz.white255,
                size: 500,
              );
            }

            else {

              return TimeLineBuilder(
                posts: _publishedPosts,
                onDoubleTap: (PostModel post) async {
                  await Nav.goToNewScreen(
                    context: context,
                    screen: const PendingPostsScreen(),
                  );
                },
                controller: _scrollController,
                      onLike: (PostModel post) => _onLike(post),
                      onView: (PostModel post) => _onView(post),
                // goToPostCreatorButtonIsOn: true,
              );

              // return ListView.builder(
              //   physics: const BouncingScrollPhysics(),
              //   shrinkWrap: true,
              //   padding: EdgeInsets.only(
              //     top: Standards.getTimeLineTopMostMargin(),
              //     bottom: Standards.timelineMinTileHeight,
              //   ),
              //   itemCount: _keys.length + 1,
              //   itemBuilder: (_, i) {
              //
              //     if (i == _keys.length) {
              //       return Column(
              //         children: <Widget>[
              //
              //           const SeparatorLine(
              //             width: 100,
              //             withMargins: true,
              //           ),
              //
              //           TalkBox(
              //             height: 50,
              //             text: 'Talk to Humanity',
              //             // margins: const EdgeInsets.only(top: 50),
              //             color: Colorz.white255,
              //             textColor: Colorz.black255,
              //             icon: Iconz.share,
              //             iconColor: Colorz.black255,
              //             iconSizeFactor: 0.5,
              //             textScaleFactor: 0.8 / 0.5,
              //             onTap: () async {
              //               await Nav.goToNewScreen(
              //                 context: context,
              //                 screen: const PostCreatorScreen(),
              //               );
              //             },
              //             onDoubleTap: ,
              //           ),
              //
              //           const SeparatorLine(
              //             width: 100,
              //             withMargins: true,
              //           ),
              //
              //         ],
              //       );
              //     }
              //
              //     else {
              //       final String key = _keys[i];
              //
              //       return TimelineMonthBuilder(
              //         onLike: (PostModel post) => _onLike(post),
              //         onView: (PostModel post) => _onView(post),
              //         posts: _postsMap[key],
              //         isFirstMonth: i == 0,
              //       );
              //     }
              //
              //   },
              // );
            }

          },
        ),
      ),
    );
    // --------------------
  }
  // --------------------------------------------------------------------------
}
