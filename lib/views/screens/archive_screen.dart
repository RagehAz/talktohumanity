import 'package:bldrs_theme/bldrs_theme.dart';
import 'package:filers/filers.dart';
import 'package:flutter/material.dart';
import 'package:scale/scale.dart';
import 'package:segmented_circle_border/segmented_circle_border.dart';
import 'package:talktohumanity/views/helpers/standards.dart';
import 'package:talktohumanity/views/widgets/basic_layout.dart';
import 'package:talktohumanity/views/widgets/expander_button/b_expanding_tile.dart';
import 'package:talktohumanity/views/widgets/talk_box.dart';

class ArchiveScreen extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const ArchiveScreen({Key key}) : super(key: key);

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
  @override
  Widget build(BuildContext context) {
    // --------------------
    final double _screenWidth = Scale.screenWidth(context);
    final double _screenHeight = Scale.screenHeight(context);
    const double _timelineZoneWidth = 100;
    final double _postZoneWidth = _screenWidth - _timelineZoneWidth;
    // --------------------
    final double _maxTileHeight = _screenHeight - 150;
    // --------------------
    return BasicLayout(
      body: SizedBox(
        width: _screenWidth,
        height: _screenHeight,
        child: ListView.builder(
          physics: const BouncingScrollPhysics(),
          shrinkWrap: true,
          itemBuilder: (_, int index) {
            return ExpandingTile(
              // initiallyExpanded: false,
              // isCollapsable: true,
              // scrollable: true,
              // isDisabled: index.isOdd,
              width: _screenWidth,
              firstHeadline: 'Name',
              secondHeadline: 'title',
              // initialColor: Colorz.bloodTest,
              expansionColor: Colorz.yellow50,
              margin: EdgeInsets.zero,
              corners: 0,
              collapsedHeight: Standards.timelineMinTileHeight,
              maxHeight: _maxTileHeight,
              sideBox: SizedBox(
                width: Standards.timelineMinTileHeight,
                height: Standards.timelineMinTileHeight,
                child: Stack(
                  children: <Widget>[

                    /// VERTICAL LINE
                    const VerticalLineLayer(
                      height: Standards.timelineMinTileHeight,
                    ),

                    /// HORIZONTAL LINE
                    Container(
                      width: Standards.timelineMinTileHeight,
                      height: Standards.timelineMinTileHeight,
                      alignment: Alignment.topLeft,
                      child: Container(
                        width: Standards.timelineMinTileHeight - Standards.timelineSideMargin - Standards.timelineLineRadius,
                        height: Standards.timelineLineThickness,
                        color: Standards.timelineLineColor,
                        margin: const EdgeInsets.only(
                          left: Standards.timelineSideMargin + (Standards.timelineLineRadius),
                          top: Standards.timelineSideMargin * 3,
                        ),
                      ),
                    ),

                    /// QUARTER CIRCLE

                    Padding(
                      padding: const EdgeInsets.only(
                        left: Standards.timelineSideMargin,
                        top: Standards.timelineSideMargin * 3,
                      ),
                      child: Material(
                          shape: SegmentedCircleBorder(
                              // offset: 0, // this rotates segments anticlockwise from top quadrant
                              numberOfSegments: 4,
                              sides: const <BorderSide>[
                                BorderSide(color: Colorz.nothing, width: 2),
                                BorderSide(color: Colorz.nothing, width: 2),
                                BorderSide(color: Standards.timelineLineColor, width: 2),
                                BorderSide(color: Colorz.nothing, width: 2),
                              ]),
                          child: Container(
                            width: Standards.timelineLineRadius * 2,
                            height: Standards.timelineLineRadius * 2,
                            color: Colorz.nothing,
                          )),
                    ),

                  ],
                ),
              ),
              child: Row(
                children: [
                  VerticalLineLayer(
                    height: _maxTileHeight - Standards.timelineMinTileHeight,
                  ),
                  TalkBox(
                    height: _maxTileHeight - Standards.timelineMinTileHeight,
                    width: _postZoneWidth - 20,
                    text: 'A',
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
    // --------------------
  }
// --------------------------------------------------------------------------
}

class VerticalLineLayer extends StatelessWidget {
  const VerticalLineLayer({@required this.height, Key key}) : super(key: key);

  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: Standards.timelineMinTileHeight,
      alignment: Alignment.centerLeft,
      child: Container(
        width: Standards.timelineLineThickness,
        height: height,
        color: Standards.timelineLineColor,
        margin: const EdgeInsets.only(left: Standards.timelineSideMargin),
      ),
    );
  }
}
