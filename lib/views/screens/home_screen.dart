import 'package:animators/animators.dart';
import 'package:bldrs_theme/bldrs_theme.dart';
import 'package:bubbles/bubbles.dart';
import 'package:filers/filers.dart';
import 'package:flutter/material.dart';
import 'package:scale/scale.dart';
import 'package:super_image/super_image.dart';
import 'package:talktohumanity/services/navigation/nav.dart';
import 'package:talktohumanity/services/navigation/routing.dart';
import 'package:talktohumanity/views/widgets/layouts/basic_layout.dart';
import 'package:talktohumanity/views/widgets/basics/talk_box.dart';
import 'package:talktohumanity/views/widgets/basics/talk_text.dart';

class HomeScreen extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const HomeScreen({Key key}) : super(key: key);

  /// --------------------------------------------------------------------------
  @override
  _HomeScreenState createState() => _HomeScreenState();

  /// --------------------------------------------------------------------------
}

class _HomeScreenState extends State<HomeScreen> {
  // -----------------------------------------------------------------------------
  final PageController _pageController = PageController();
  final TextEditingController _textController = TextEditingController();
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
  /// TESTED : WORKS PERFECT
  Future<void> _slideToNextPage({
    @required int currentSlide,
  }) async {
    await Sliders.slideToNext(
      pageController: _pageController,
      numberOfSlides: 4,
      currentSlide: currentSlide,
    );
  }
  // --------------------
  /// TASK : TEST ME
  Future<void> _onSkipPublishing() async {
    blog('_onSkipPublishing start');
    await navToArchiveScreen();
  }
  // --------------------
  /// TASK : TEST ME
  Future<void> onPublishPost() async {
    blog('onPublishPost start');
    final bool _canPublish = await prePublishCheckUps();

    if (_canPublish == true) {

      final bool _published = await publishPostOps();

      await notifyAndNavigate(
        published: _published,
      );

    }

  }
  // --------------------
  /// TASK : TEST ME
  Future<bool> prePublishCheckUps() async {
    blog('prePublishCheckUps start');
    bool _canContinue = false;
    final bool _userIsSignedIn = await userIsSignedIn();

    /// IF SIGNED IN
    if (_userIsSignedIn == true) {
      _canContinue = await confirmPublishDialog();
    }

    /// IF NOT SIGNED IN
    else {
      final bool _signInSuccess = await signIn();

      /// COULD SIGN IN
      if (_signInSuccess == true) {
        _canContinue = await confirmPublishDialog();
      }

      /// COULD NOT SIGN IN
      else {
        _canContinue = false;
      }
    }

    return _canContinue;
  }
  // --------------------
  /// TASK : WRITE ME
  Future<bool> userIsSignedIn() async {
    blog('userIsSignedIn start');
    bool _isSignedIn = false;
    if (mounted){
      _isSignedIn = true;
    }
    return _isSignedIn;
  }
  // --------------------
  /// TASK : WRITE ME
  Future<bool> signIn() async {
    blog('signIn start');
    bool _success = false;

    if (mounted){
      _success = true;
    }

    return _success;
  }
  // --------------------
  /// TASK : WRITE ME
  Future<bool> confirmPublishDialog() async {
    blog('confirmPublishDialog start');
    bool _continue = false;
    if (mounted){
      _continue = true;
    }
    return _continue;
  }
  // --------------------
  /// TASK : WRITE ME
  Future<bool> publishPostOps() async {
    blog('publishPostOps start');
    bool _isPublished = false;
    if (mounted){
      _isPublished = true;
    }
    return _isPublished;
  }
  // --------------------
  Future<void> notifyAndNavigate({
    @required bool published,
  }) async {
    blog('notifyAndNavigate start');

    if (published == true) {
      await showPublishSuccessDialog();

      await navToArchiveScreen();
    }

    else {
      await showPublishFailureDialog();
    }
  }
  // --------------------
  /// TASK : WRITE ME
  Future<void> showPublishSuccessDialog() async {
    blog('showPublishSuccessDialog start');
  }
  // --------------------
  /// TASK : WRITE ME
  Future<void> showPublishFailureDialog() async {
    blog('showPublishFailureDialog start');
  }
  // --------------------
  /// TASK : WRITE ME
  Future<void> navToArchiveScreen() async {
    blog('navToArchiveScreen start');

    await Nav.goToRoute(context, Routing.archiveRoute);

  }
  // --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------

    const String _s = 'And your message will be the only message visible to the entire world for '
        '24 hours\n\nwill never be removed\n\nand shall never be forgotten';

    final double _screenWidth = Scale.screenWidth(context);
    final double _screenHeight = Scale.screenHeight(context);
    final double _bubbleWidth = _screenWidth - 20;

    return BasicLayout(
      body: SizedBox(
        width: _screenWidth,
        height: _screenHeight,
        child: PageView(
          physics: const BouncingScrollPhysics(),
          controller: _pageController,
          scrollDirection: Axis.vertical,
          children: <Widget>[
            /// 1
            GestureDetector(
              onTap: () => _slideToNextPage(currentSlide: 0),
              child: Container(
                width: _screenWidth,
                height: _screenHeight,
                color: Colorz.black200,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const SuperImage(
                      height: 100,
                      width: 100,
                      pic: Iconz.contAfrica,
                    ),
                    TalkText(
                      boxWidth: _screenWidth * 0.7,
                      textHeight: 40,
                      text: 'If you have\none chance\nto speak to all Humanity\n',
                      font: BldrsThemeFonts.fontBldrsBodyFont,
                      italic: true,
                      margins: 10,
                      maxLines: 5,
                    ),
                  ],
                ),
              ),
            ),

            /// 2
            GestureDetector(
              onTap: () => _slideToNextPage(
                currentSlide: 1,
              ),
              child: Container(
                width: _screenWidth,
                height: _screenHeight,
                color: Colorz.black200,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const SuperImage(
                      height: 100,
                      width: 100,
                      pic: Iconz.contAfrica,
                    ),
                    TalkText(
                      boxWidth: _screenWidth * 0.7,
                      textHeight: 40,
                      text: _s,
                      font: BldrsThemeFonts.fontBldrsBodyFont,
                      italic: true,
                      margins: 10,
                      maxLines: 20,
                    ),
                  ],
                ),
              ),
            ),

            /// 3
            GestureDetector(
              onTap: () => _slideToNextPage(
                currentSlide: 2,
              ),
              child: Container(
                width: _screenWidth,
                height: _screenHeight,
                color: Colorz.black200,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    TalkText(
                      boxWidth: _screenWidth * 0.7,
                      textHeight: 40,
                      text: 'What shall you say ?',
                      font: BldrsThemeFonts.fontBldrsBodyFont,
                      italic: true,
                      margins: 10,
                      maxLines: 20,
                    ),
                  ],
                ),
              ),
            ),

            /// 4
            GestureDetector(
              onTap: () => _slideToNextPage(
                currentSlide: 2,
              ),
              child: Stack(
                alignment: Alignment.center,
                children: <Widget>[
                  /// BACKGROUND WORLD
                  Opacity(
                    opacity: 0.3,
                    child: SuperImage(
                      height: _screenWidth * 1.2,
                      width: _screenWidth * 1.2,
                      pic: Iconz.contAfrica,
                    ),
                  ),

                  /// BUBBLE
                  Container(
                    width: _screenWidth,
                    height: _screenHeight,
                    color: Colorz.black200,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        /// TEST FIELD
                        TextFieldBubble(
                          bubbleHeaderVM: const BubbleHeaderVM(
                            headlineText: 'A message to the world',
                          ),
                          bubbleWidth: _bubbleWidth,
                          textController: _textController,
                          maxLines: 1000,
                          maxLength: 10000,
                          keyboardTextInputType: TextInputType.multiline,
                          bulletPoints: const [
                            'You can say absolutely anything',
                          ],
                          fieldTextFont: BldrsThemeFonts.fontBldrsBodyFont,
                          hintText: '...',
                          bulletPointsFont: BldrsThemeFonts.fontBldrsBodyFont,
                          counterIsOn: true,
                          minLines: 10,
                        ),

                        /// BUTTONS
                        SizedBox(
                          width: _screenWidth,
                          height: 100,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              /// SKIP
                              TalkBox(
                                height: 60,
                                text: 'Skip',
                                margins: 10,
                                onTap: _onSkipPublishing,
                              ),

                              /// PUBLISH
                              TalkBox(
                                height: 60,
                                text: 'Publish',
                                margins: 10,
                                onTap: onPublishPost,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
    // --------------------
  }
  // --------------------------------------------------------------------------
}
