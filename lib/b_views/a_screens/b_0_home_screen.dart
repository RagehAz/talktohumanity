import 'package:filers/filers.dart';
import 'package:flutter/material.dart';
import 'package:layouts/layouts.dart';
import 'package:mediators/mediators.dart';
import 'package:numeric/numeric.dart';
import 'package:provider/provider.dart';
import 'package:talktohumanity/a_models/post_model.dart';
import 'package:talktohumanity/b_views/a_screens/b_1_posts_view.dart';
import 'package:talktohumanity/b_views/a_screens/b_2_auth_view.dart';
import 'package:talktohumanity/b_views/a_screens/b_3_creator_view.dart';
import 'package:talktohumanity/b_views/b_widgets/c_dialogs/talk_dialogs.dart';
import 'package:talktohumanity/b_views/b_widgets/f_planet_page_view/rotating_planet_video_view.dart';
import 'package:talktohumanity/c_services/helpers/talk_theme.dart';
import 'package:talktohumanity/c_services/providers/ui_provider.dart';

enum HomeScreenView {
  posts,
  auth,
  creator,
}

class HomeScreen extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const HomeScreen({
    this.draft,
    Key key
  }) : super(key: key);
  /// --------------------
  final PostModel draft;
  /// --------------------
  @override
  _HomeScreenState createState() => _HomeScreenState();
  /// --------------------------------------------------------------------------
}

class _HomeScreenState extends State<HomeScreen> {
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

    blog('HOME SCREEN : INIT STATE');
    Sounder.playSound(
      mp3Asset: TalkTheme.serenityTrack,
      loop: true,
      initialPosition: Duration(
          seconds: Numeric.createRandomIndex(
            listLength: 410,
          ),
      ),
      initialVolume: 0,
      fadeIn: true,
      fadeInMilliseconds: 5000,
      mounted: mounted,
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
    Sounder.dispose();
    super.dispose();
  }
  // --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    return BasicLayout(
      canGoBack: false,
      onBack: () async {

        final bool _exit = await TalkDialog.boolDialog(
          title: 'Exit ?',
          body: 'Do you want to close and exit ?',
          invertButtons: true,
        );

        if (_exit == true){

          await Future.delayed(const Duration(milliseconds: 500), () async {
            await Nav.closeApp(context);
          });

        }

      },

      body: Stack(
        alignment: Alignment.topCenter,
        children: <Widget>[

          /// PLANET VIDEO
          const RotatingPlanetVideo(),

          Selector<UiProvider, HomeScreenView>(
            selector: (_, UiProvider pro) => pro.homeView,
            builder: (BuildContext context, HomeScreenView _view, Widget child) {

              /// TIMELINE
              if (_view == HomeScreenView.posts) {
                return const PostsView();
              }

              else if (_view == HomeScreenView.auth) {
                return const AuthView(
                  backButtonIsSkipButton: false,
                );
              }

              else if (_view == HomeScreenView.creator) {
                return const CreatorView();
              }

              else {
                return Container();
              }

            },
          ),

          /// TESTING : RE NAV BUTTON
          // Align(
          //   alignment: Alignment.topLeft,
          //   child: TalkBox(
          //     height: 40,
          //     isBold: true,
          //     icon: Iconz.dvRageh,
          //     onTap: () async {
          //       UiProvider.proSetHomeView(view: HomeScreenView.posts, notify: true);
          //       await Nav.pushNamedAndRemoveAllBelow(
          //         context: getContext(),
          //         goToRoute: Routing.archiveRoute,
          //       );
          //     },
          //   ),
          // ),

        ],
      ),
    );
    // --------------------
  }
  // --------------------------------------------------------------------------
}
