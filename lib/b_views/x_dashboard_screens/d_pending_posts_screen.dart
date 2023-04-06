import 'package:bldrs_theme/bldrs_theme.dart';
import 'package:dialogs/dialogs.dart';
import 'package:filers/filers.dart';
import 'package:fire/fire.dart';
import 'package:flutter/material.dart';
import 'package:layouts/layouts.dart';
import 'package:ldb/ldb.dart';
import 'package:mapper/mapper.dart';
import 'package:real/real.dart';
import 'package:scale/scale.dart';
import 'package:talktohumanity/a_models/post_model.dart';
import 'package:talktohumanity/b_views/b_widgets/b_texting/talk_text.dart';
import 'package:talktohumanity/b_views/b_widgets/c_dialogs/talk_dialogs.dart';
import 'package:talktohumanity/b_views/b_widgets/c_dialogs/wait_dialog.dart';
import 'package:talktohumanity/b_views/b_widgets/e_timeline/timeline_builder.dart';
import 'package:talktohumanity/c_services/protocols/post_protocols/post_ldb_ops.dart';
import 'package:talktohumanity/c_services/protocols/post_protocols/post_real_ops.dart';
import 'package:talktohumanity/c_services/helpers/routing.dart';

class PendingPostsScreen extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const PendingPostsScreen({
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  @override
  _PendingPostsScreenState createState() => _PendingPostsScreenState();
  /// --------------------------------------------------------------------------
}

class _PendingPostsScreenState extends State<PendingPostsScreen> {
  // -----------------------------------------------------------------------------
  final ScrollController _scrollController = ScrollController();
  PaginationController _paginationController;
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

    _paginationController = PaginationController.initialize(
      addExtraMapsAtEnd: true,
      onDataChanged: (List<Map<String, dynamic>> maps){

        blog('READ : ${maps.length}');

      }
    );
  }
  // --------------------
  bool _isInit = true;
  @override
  void didChangeDependencies() {
    if (_isInit && mounted) {
      _triggerLoading(setTo: true).then((_) async {


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
  @override
  Widget build(BuildContext context) {
    // --------------------
    final double _screenWidth = Scale.screenWidth(context);
    final double _screenHeight = Scale.screenHeightGross(context);
    // --------------------
    return BasicLayout(
      body: SizedBox(
        width: _screenWidth,
        height: _screenHeight,
        child: RealCollPaginator(
            scrollController: _scrollController,
            paginatorController: _paginationController,
            realQueryModel: const RealQueryModel(
              path: PostRealOps.pendingPostsColl,
              fieldNameToOrderBy: 'id',
              keyFieldName: 'id',
              limit: 10,
              orderType: RealOrderType.byKey,
              // queryRange: QueryRange.startAt,
              // readFromBeginningOfOrderedList: true,
            ),
            builder: (_, List<Map<String, dynamic>> maps, bool isLoading, Widget child){

              final List<PostModel> _posts = PostModel.decipherPosts(
                  maps: maps,
                  fromJSON: true,
              );

              if (Mapper.checkCanLoopList(_posts) == true){
                return TimeLineBuilder(
                posts: _posts,
                controller: _scrollController,
                goToPostCreatorButtonIsOn: false,
                onDoubleTap: (PostModel post) async {

                  final GlobalKey flushbarKey = GlobalKey();

                  await BottomDialog.showBottomDialog(
                      context: context,
                      draggable: true,
                      height: 300,
                      child: Column(
                        children: [

                          /// APPROVE
                          BottomDialog.wideButton(
                            context: context,
                            text: 'Approve',
                            onTap: () async {

                              final bool _go = await TalkDialog.boolDialog(
                                title: 'Publish ?',
                                invertButtons: true,
                              );

                              if (_go == true){

                                await Nav.goBack(context: context);

                                pushTalkWaitDialog(context: context, text: 'Moving');

                                await PostRealOps.movePost(
                                  postID: post.id,
                                  fromColl: PostRealOps.pendingPostsColl,
                                  toColl: PostLDBPOps.publishedPosts,
                                );

                                _paginationController.removeMapsByIDs(
                                    ids: [post.id],
                                    mounted: mounted,
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

                            }
                          ),

                          /// DELETE
                          BottomDialog.wideButton(
                            context: context,
                            text: 'Delete',
                            onTap: () async {

                              final bool _go = await TalkDialog.boolDialog(
                                title: 'Delete ?',
                                invertButtons: true,
                              );

                              if (_go == true){

                                await Nav.goBack(context: context);

                                pushTalkWaitDialog(context: context, text: 'Deleting');

                                await PostRealOps.deletePost(
                                  postID: post.id,
                                  collName: PostRealOps.pendingPostsColl,
                                );

                                _paginationController.removeMapsByIDs(
                                    ids: [post.id],
                                    mounted: mounted,
                                );

                                await WaitDialog.closeWaitDialog(context);

                                await TalkDialog.topDialog(
                                    flushbarKey: flushbarKey,
                                    headline: 'Post is deleted',
                                );

                              }

                            }
                          ),

                        ],
                      ),
                  );

                },
              );
              }

              else {

                return const Center(
                  child: TalkText(
                    isBold: true,
                    text: 'No posts are pending',
                    maxLines: 2,
                    margins: 60,
                    // textHeight: 50,
                    italic: true,
                    textColor: Colorz.white200,
                  ),
                );

              }


            }
        ),
      ),
    );
    // --------------------
  }
  // --------------------------------------------------------------------------
}
