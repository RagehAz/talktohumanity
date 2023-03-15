import 'package:bldrs_theme/bldrs_theme.dart';
import 'package:filers/filers.dart';
import 'package:flutter/material.dart';
import 'package:scale/scale.dart';
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
  Future<void> _onLike() async {
    blog('is liked');
  }
  // --------------------
  Future<void> _onView() async {
    blog('is Viewed');
  }
  // --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    final double _screenWidth = Scale.screenWidth(context);
    final double _screenHeight = Scale.screenHeight(context);
    // --------------------
    final List<String> _posts = ['fuck', 'you', 'bitch'];
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
          itemCount: 3 + 1,
          itemBuilder: (_, i) {

            if (i == 3){

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

              return TimelineMonthBuilder(
              onLike: (String post) => _onLike(),
              onView: (String post) => _onView(),
              posts: _posts,
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
