import 'package:bldrs_theme/bldrs_theme.dart';
import 'package:filers/filers.dart';
import 'package:flutter/material.dart';
import 'package:real/real.dart';
import 'package:scale/scale.dart';
import 'package:talktohumanity/model/post_model.dart';
import 'package:talktohumanity/providers/post_ldb_ops.dart';
import 'package:talktohumanity/services/navigation/nav.dart';
import 'package:talktohumanity/views/helpers/standards.dart';
import 'package:talktohumanity/views/screens/post_creator_screen.dart';
import 'package:talktohumanity/views/widgets/basics/talk_box.dart';
import 'package:talktohumanity/views/widgets/layouts/basic_layout.dart';
import 'package:talktohumanity/views/widgets/layouts/separator_line.dart';
import 'package:talktohumanity/views/widgets/time_line/timeline_month_builder.dart';

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
  final ScrollController _scrollControllerB = ScrollController();
  List<PostModel> posts = PostModel.dummyPosts(); //[];

  Map<String, dynamic> _postsMap = {};
  // -----------------------------------------------------------------------------
  /// --- LOADING
  final ValueNotifier<bool> _loading = ValueNotifier(false);
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

    _postsMap = PostModel.organizePostsInMap(
        posts: posts,
    );

    _scrollController.addListener(() {
      _scrollControllerB.jumpTo(_scrollController.offset * 1.5);
    });
  }
  // --------------------
  bool _isInit = true;
  @override
  void didChangeDependencies() {
    if (_isInit && mounted) {
      _triggerLoading(setTo: true).then((_) async {
        /// FUCK

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
    _scrollControllerB.dispose();
    super.dispose();
  }
  // --------------------------------------------------------------------------
  ///
  Future<void> _onLike(PostModel post) async {
    blog('is liked');

    final bool _isLiked = await PostLDBPOps.checkIsInserted(
      post: post,
      docName: PostLDBPOps.myLikes,
    );

    if (_isLiked == true) {
      await PostLDBPOps.deletePost(
        post: post,
        docName: PostLDBPOps.myLikes,
      );
    }

    else {
      await PostLDBPOps.insertPost(
        post: post,
        docName: PostLDBPOps.myLikes,
      );
    }

    setState(() {

    });

    post.blogPost();
  }
  // --------------------
  ///
  Future<void> _onView(PostModel post) async {

    final bool _isViewed = await PostLDBPOps.checkIsInserted(
      post: post,
      docName: PostLDBPOps.myViews,
    );

    if (_isViewed == false) {

      /// INSERT IN LDB
      await PostLDBPOps.insertPost(
        post: post,
        docName: PostLDBPOps.myViews,
      );

      /// INCREMENT REAL COUNTER
      await Real.incrementDocFields(
        context: context,
        collName: 'counters',
        docName: 'views',
        isIncrementing: true,
        incrementationMap: {
          post.id: 1,
        },
      );
    }

    setState(() {});

    post.blogPost();
  }
  // --------------------
  ///
  Future<void> insertPostToMyViewsInLDB({
    @required PostModel post,
  }) async {

    await PostLDBPOps.insertPost(
      post: post,
      docName: PostLDBPOps.myViews,
    );

  }
  // --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    final double _screenWidth = Scale.screenWidth(context);
    final double _screenHeight = Scale.screenHeight(context);
    // --------------------
    final List<String> _keys = _postsMap?.keys?.toList();
    // --------------------
    return BasicLayout(
      body: SizedBox(
        width: _screenWidth,
        height: _screenHeight,
        child: ListView.builder(
          physics: const BouncingScrollPhysics(),
          shrinkWrap: true,
          padding: EdgeInsets.only(
            top: Standards.getTimeLineTopMostMargin(),
            bottom: Standards.timelineMinTileHeight,
          ),
          itemCount: _keys.length + 1,
          itemBuilder: (_, i) {

            if (i == _keys.length){

              return Column(
                children: <Widget>[
                  const SeparatorLine(
                    width: 100,
                    withMargins: true,
                  ),
                  TalkBox(
                    height: 50,
                    text: 'Talk to Humanity',
                    // margins: const EdgeInsets.only(top: 50),
                    color: Colorz.bloodTest,
                    icon: Iconz.share,
                    iconSizeFactor: 0.5,
                    textScaleFactor: 0.8 / 0.5,
                    onTap: () async {
                      await Nav.goToNewScreen(
                        context: context,
                        screen: const PostCreatorScreen(),
                      );
                      },
                  ),
                  const SeparatorLine(
                    width: 100,
                    withMargins: true,
                  ),
                ],
              );

            }

            else {

              final String key = _keys[i];

              return TimelineMonthBuilder(
                onLike: (PostModel post) => _onLike(post),
                onView: (PostModel post) => _onView(post),
                posts: _postsMap[key],
                isFirstMonth: i == 0,
              );

            }

          },
        ),
      ),
    );
    // --------------------
  }
  // --------------------------------------------------------------------------
}
