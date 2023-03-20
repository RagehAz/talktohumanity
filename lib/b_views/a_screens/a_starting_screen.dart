import 'package:animators/animators.dart';
import 'package:bldrs_theme/bldrs_theme.dart';
import 'package:filers/filers.dart';
import 'package:flutter/material.dart';
import 'package:layouts/layouts.dart';
import 'package:night_sky/night_sky.dart';
import 'package:scale/scale.dart';
import 'package:talktohumanity/a_models/post_model.dart';
import 'package:talktohumanity/b_views/a_screens/c_post_creator_screen.dart';
import 'package:talktohumanity/b_views/b_widgets/d_post_creator/brief_post_creator.dart';
import 'package:talktohumanity/b_views/b_widgets/f_planet_page_view/starting_screen_planet_page_view.dart';
import 'package:talktohumanity/d_helpers/helper_methods.dart';
import 'package:talktohumanity/d_helpers/routing.dart';
import 'package:talktohumanity/d_helpers/talk_theme.dart';

class StartingScreen extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const StartingScreen({Key key}) : super(key: key);

  /// --------------------------------------------------------------------------
  @override
  _StartingScreenState createState() => _StartingScreenState();

  /// --------------------------------------------------------------------------
}

class _StartingScreenState extends State<StartingScreen> {
  // -----------------------------------------------------------------------------
  final PageController _pageController = PageController();
  final TextEditingController _textController = TextEditingController();
  final TextEditingController _bodyController = TextEditingController();
  // -----------------------------------------------------------------------------
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _canErrorize = false;
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
    _textController.dispose();
    _pageController.dispose();
    super.dispose();
  }
  // --------------------------------------------------------------------------
  /// TESTED : WORKS PERFECT
  Future<void> _slideToNextPage({
    @required int currentSlide,
  }) async {
    FocusManager.instance.primaryFocus?.unfocus();
    await Sliders.slideToNext(
      pageController: _pageController,
      numberOfSlides: 4,
      currentSlide: currentSlide,
    );
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  Future<void> _onPublishMessage() async {

    final bool _isValid = _formKey.currentState.validate();

    if (_isValid == true) {
      await Nav.goToNewScreen(
        context: context,
        screen: PostCreatorScreen(
          draft: PostModel.generateDraft(
            body: _bodyController.text,
          ),
        ),
      );
    }

    else {
      setState(() {
        _canErrorize = true;
      });
    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  Future<void> _onImNotReady() async {
      await Nav.goToRoute(getContext(), Routing.archiveRoute);
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
        child: Stack(
          children: <Widget>[

            const Sky(
              // gradientIsOn: false,
              skyType: SkyType.blackStars,
              skyColor: Colorz.black255,
            ),

            PageView(
              physics: const BouncingScrollPhysics(),
              controller: _pageController,
              scrollDirection: Axis.vertical,
              children: <Widget>[

                /// 1
                PlanetPageView(
                  text: 'If you have\none chance\nto speak\nto all Humanity\n',
                  icon: TalkTheme.logo_night,
                  onTap: () => _slideToNextPage(currentSlide: 0),
                  onLongPress: () => Routing.goToLab(),
                ),

                /// 2
                PlanetPageView(
                  text: 'And your message will be the only message visible to the entire world for '
                      '24 hours\n\nIt will not be removed\n\nand shall never be forgotten',
                  icon: TalkTheme.logo_cloudy,
                  onTap: () => _slideToNextPage(
                    currentSlide: 1,
                  ),
                ),

                /// 3
                PlanetPageView(
                  text: 'What shall you say ?',
                  icon: TalkTheme.logo_day,
                  onTap: () => _slideToNextPage(
                    currentSlide: 2,
                  ),
                ),

                /// 4
                GestureDetector(
                  onTap: () => _slideToNextPage(
                    currentSlide: 2,
                  ),
                  child: BriefPostCreatorView(
                    bodyController: _bodyController,
                    formKey: _formKey,
                    canErrorize: _canErrorize,
                    onPublish: _onPublishMessage,
                    onSkip: _onImNotReady,
                  ),
                ),

              ],
            ),
          ],
        ),
      ),
    );
    // --------------------
  }
  // --------------------------------------------------------------------------
}
