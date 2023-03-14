import 'package:bldrs_theme/bldrs_theme.dart';
import 'package:filers/filers.dart';
import 'package:flutter/material.dart';
import 'package:scale/scale.dart';
import 'package:super_text/super_text.dart';
import 'package:talktohumanity/views/widgets/basic_layout.dart';

/// ============================================================================


class TheStatefulScreen extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const TheStatefulScreen({
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  @override
  _TheStatefulScreenState createState() => _TheStatefulScreenState();
  /// --------------------------------------------------------------------------
}

class _TheStatefulScreenState extends State<TheStatefulScreen> {
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
    super.dispose();
  }
  // --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    return BasicLayout(
      body: DummyView(
        title: 'Stateful',
        onTap: (){},
      ),
    );
    // --------------------
  }
  // --------------------------------------------------------------------------
}


/// ============================================================================


class TheStatelessScreen extends StatelessWidget {
  // --------------------------------------------------------------------------
  const TheStatelessScreen({
    Key key
  }) : super(key: key);
  // --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    return BasicLayout(
        body: DummyView(
          title: 'Stateless',
          onTap: (){},
        ),
    );
    // --------------------
  }
  // --------------------------------------------------------------------------
}


/// ============================================================================

class DummyView extends StatelessWidget {
  // --------------------------------------------------------------------------
  const DummyView({
    @required this.onTap,
    @required this.title,
    Key key
  }) : super(key: key);
  // --------------------------------------------------------------------------
  final Function onTap;
  final String title;
  // --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    // --------------------
    final double _referenceLength = Scale.screenShortestSide(context);
    // --------------------
    return BasicLayout(
      body: Center(
        child: SuperText(
          text: title,
          font: BldrsThemeFonts.fontBldrsHeadlineFont,
          weight: FontWeight.w400,
          italic: true,
          boxWidth: _referenceLength * 0.5,
          textHeight: _referenceLength * 0.1,
          maxLines: 2,
        ),

      ),
    );
    // --------------------

  }
  // --------------------------------------------------------------------------
}

/// ============================================================================
