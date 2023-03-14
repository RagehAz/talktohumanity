import 'package:filers/filers.dart';
import 'package:flutter/material.dart';
import 'package:scale/scale.dart';
import 'package:talktohumanity/views/helpers/standards.dart';
import 'package:talktohumanity/views/widgets/layouts/basic_layout.dart';
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
          itemCount: 3,
          shrinkWrap: true,
          padding: EdgeInsets.only(
            top: Standards.getTimeLineTopMostMargin(),
            bottom: Standards.timelineMinTileHeight,
          ),
          itemBuilder: (_, index) {

            return TimelineMonthBuilder(
              onLike: (String post) => _onLike(),
              onView: (String post) => _onView(),
              posts: _posts,
              isFirstMonth: index == 0,
            );

          },
        ),
      ),
    );
    // --------------------
  }
  // --------------------------------------------------------------------------
}
