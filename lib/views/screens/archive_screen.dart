import 'package:bldrs_theme/bldrs_theme.dart';
import 'package:filers/filers.dart';
import 'package:flutter/material.dart';
import 'package:im_stepper/stepper.dart';
import 'package:scale/scale.dart';
import 'package:super_box/super_box.dart';
import 'package:talktohumanity/views/widgets/basic_layout.dart';
import 'package:talktohumanity/views/widgets/expander_button/b_expanding_tile.dart';
import 'package:talktohumanity/views/widgets/talk_box.dart';

class ArchiveScreen extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const ArchiveScreen({
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  @override
  _ArchiveScreenState createState() => _ArchiveScreenState();
  /// --------------------------------------------------------------------------
  static const double minTileHeight = 80;
  static const Color lineColor = Colorz.white255;
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

      _scrollControllerB.jumpTo(_scrollController.offset*1.5);

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
    const double _stripHeight = 2;
    const double _stripCorner = 0.2;
    const BorderRadius _stripBorders = BorderRadius.all(Radius.circular(_stripCorner));
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
            itemBuilder: (_, int index){

            return ExpandingTile(
              initiallyExpanded: false,
              isCollapsable: true,
              scrollable: true,
              // isDisabled: index.isOdd,
              width: _screenWidth,
              firstHeadline: 'Name',
              secondHeadline: 'title',
              initialColor: Colorz.bloodTest,
              expansionColor: Colorz.yellow50,
              margin: EdgeInsets.zero,
              corners: 0,
              collapsedHeight: ArchiveScreen.minTileHeight,
              maxHeight: _maxTileHeight,
              sideBox: Container(
                width: ArchiveScreen.minTileHeight,
                height: ArchiveScreen.minTileHeight,
                color: Colorz.bloodTest,
                child: Stack(
                  children: const <Widget>[

                    VerticalLineLayer(
                      height: ArchiveScreen.minTileHeight,
                    ),

                  ],
                ),
              ),
              child: Container(
                child: Row(
                  children: [

                    VerticalLineLayer(
                      height: _maxTileHeight - ArchiveScreen.minTileHeight,
                    ),

                    TalkBox(
                      height: _maxTileHeight - ArchiveScreen.minTileHeight,
                      width: _postZoneWidth - 20,
                      text: 'A',
                    ),

                  ],
                ),
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

  const VerticalLineLayer({
    @required this.height,
    Key key
  }) : super(key: key);

  final double height;

  @override
  Widget build(BuildContext context) {

    return Container(
      height: height,
      width: ArchiveScreen.minTileHeight,
      alignment: Alignment.centerLeft,
      child: Container(
        width: 2,
        height: height,
        color: ArchiveScreen.lineColor,
        margin: const EdgeInsets.only(left: 10),
      ),
    );
  }

}
