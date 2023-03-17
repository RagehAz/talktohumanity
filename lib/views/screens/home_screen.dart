import 'package:animators/animators.dart';
import 'package:bldrs_theme/bldrs_theme.dart';
import 'package:filers/filers.dart';
import 'package:flutter/material.dart';
import 'package:scale/scale.dart';
import 'package:super_image/super_image.dart';
import 'package:talktohumanity/controllers/publishing_controllers.dart';
import 'package:talktohumanity/packages/layouts/nav.dart';
import 'package:talktohumanity/views/screens/lab_screen.dart';
import 'package:talktohumanity/views/widgets/basics/talk_text.dart';
import 'package:talktohumanity/views/widgets/layouts/basic_layout.dart';
import 'package:talktohumanity/views/widgets/post_creator.dart';

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
  final TextEditingController _bodyController = TextEditingController();
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
    await Sliders.slideToNext(
      pageController: _pageController,
      numberOfSlides: 4,
      currentSlide: currentSlide,
    );
  }
  // --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------

    const String _s = 'And your message will be the only message visible to the entire world for '
        '24 hours\n\nwill never be removed\n\nand shall never be forgotten';

    final double _screenWidth = Scale.screenWidth(context);
    final double _screenHeight = Scale.screenHeight(context);

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
              onLongPress: () => Nav.goToNewScreen(context: context, screen: const LabScreen()),
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
              child: PostCreatorView(
                titleController: _textController,
                bodyController: _bodyController,
                onPublish: onPublishPost,
                onSkip: onSkipPublishing,
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
