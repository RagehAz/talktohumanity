import 'package:animators/animators.dart';
import 'package:bldrs_theme/bldrs_theme.dart';
import 'package:filers/filers.dart';
import 'package:flutter/material.dart';
import 'package:layouts/layouts.dart';
import 'package:legalizer/legalizer.dart';
import 'package:night_sky/night_sky.dart';
import 'package:scale/scale.dart';
import 'package:talktohumanity/a_models/post_model.dart';
import 'package:talktohumanity/a_models/user_model.dart';
import 'package:talktohumanity/b_views/a_screens/b_0_home_screen.dart';
import 'package:talktohumanity/b_views/b_widgets/d_post_creator/brief_post_creator.dart';
import 'package:talktohumanity/b_views/b_widgets/f_planet_page_view/starting_screen_planet_page_view.dart';
import 'package:talktohumanity/c_services/protocols/auth_protocols.dart';
import 'package:talktohumanity/c_services/protocols/timing_protocols.dart';
import 'package:talktohumanity/c_services/helpers/helper_methods.dart';
import 'package:talktohumanity/c_services/helpers/routing.dart';
import 'package:talktohumanity/c_services/helpers/talk_theme.dart';
import 'package:talktohumanity/c_services/protocols/user_protocols/user_protocols.dart';
import 'package:talktohumanity/c_services/providers/ui_provider.dart';
import 'package:talktohumanity/packages/lib/authing.dart';

class StartingScreen extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const StartingScreen({
    Key key
  }) : super(key: key);
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

        await TimingProtocols.checkDeviceTime();

        await Future.wait(<Future>[

          TimingProtocols.refreshLDBPostsEveryDay(),

        ]);

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

    FocusManager.instance.primaryFocus?.unfocus();
    final bool _isValid = _formKey.currentState.validate();

    if (_isValid == true) {

      final UserModel _user = await UserProtocols.fetchUser(
          userID: Authing.getUserID(),
      );

      if (Authing.getUserID() == null){
        UiProvider.proSetHomeView(view: HomeScreenView.auth, notify: true,);
      }
      else {
        UiProvider.proSetHomeView(view: HomeScreenView.creator, notify: true,);
      }

      await Nav.goToNewScreen(
        context: context,
        screen: HomeScreen(
          draft: PostModel.generateDraft(
            body: _bodyController.text,
          ),
        ),
      );

      await _slideToTop();
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
    FocusManager.instance.primaryFocus?.unfocus();
    await AuthProtocols.simpleAnonymousSignIn();
    UiProvider.proSetHomeView(view: HomeScreenView.posts, notify: true);
    await Nav.goToRoute(getContext(), Routing.archiveRoute);
    await _slideToTop();
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  Future<void> _slideToTop() async {

    await Sliders.slideToIndex(
      pageController: _pageController,
      toIndex: 0,
    );

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
                  child: Stack(
                    children: <Widget>[

                      /// BRIEF MESSAGE BUBBLE
                      BriefPostCreatorView(
                        bodyController: _bodyController,
                        formKey: _formKey,
                        canErrorize: _canErrorize,
                        onPublish: _onPublishMessage,
                        onSkip: _onImNotReady,
                      ),

                      /// LEGAL DISCLAIMER LINE
                      Container(
                        width: Scale.screenWidth(context),
                        height: Scale.screenHeight(context),
                        alignment: Alignment.bottomCenter,
                        child: LegalDisclaimerLine(
                          onPolicyTap: () => Routing.goToPrivacyScreen(),
                          onTermsTap: () => Routing.goToTermsScreen(),
                        ),
                      ),

                    ],
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
