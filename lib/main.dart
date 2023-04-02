import 'package:bldrs_theme/bldrs_theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:firebase_ui_oauth_apple/firebase_ui_oauth_apple.dart';
import 'package:firebase_ui_oauth_facebook/firebase_ui_oauth_facebook.dart';
import 'package:firebase_ui_oauth_google/firebase_ui_oauth_google.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:talktohumanity/b_views/a_screens/a_starting_screen.dart';
import 'package:talktohumanity/c_protocols/providers/ui_provider.dart';
import 'package:talktohumanity/d_helpers/routing.dart';
import 'package:talktohumanity/firebase_options.dart';

class SocialKey{

  const SocialKey({
    this.facebookAppID,
    this.googleClientID,
});

  /// FROM FIREBASE CONSOLE - AUTH - GOOGLE - EDIT CONFIG
  final String googleClientID;
  final String facebookAppID;

  static const SocialKey talkToHumanityKeys = SocialKey(
    /// GET FACEBOOK ID FROM FACEBOOK DEV DASHBOARD
    facebookAppID: '727816559045136',
    /// GET CLIENT_ID TAG FROM GoogleService-info.plist
    googleClientID: '569221317127-apg6rskk26v2mbkccslo2nqughb75h8r.apps.googleusercontent.com',
  );

}

Future<void> main() async {
  // --------------------------------------------------------------------------
  WidgetsFlutterBinding.ensureInitialized();
  // --------------------
  // if (kIsWeb == false){
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  // }

  FirebaseUIAuth.configureProviders([
    EmailAuthProvider(),
    GoogleProvider(
      clientId: SocialKey.talkToHumanityKeys.googleClientID,
      // redirectUri: ,
      // scopes: ,
      // iOSPreferPlist: ,
    ),
    FacebookProvider(
      clientId: SocialKey.talkToHumanityKeys.facebookAppID,
      // redirectUri: '',
    ),
    AppleProvider(
      // scopes: ,
    ),
  ]);

  // await FacebookAuth.instance.webInitialize(
  //     appId: '727816559045136',
  //     cookie: true, xfbml: true,
  //     version: 'v11.0',
  // );
  // --------------------
  return runApp(const AppStarter());
  // --------------------------------------------------------------------------
}

class AppStarter extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const AppStarter({
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  @override
  State<AppStarter> createState() => _AppStarterState();
  /// --------------------------------------------------------------------------
  static final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  /// --------------------------------------------------------------------------
}

class _AppStarterState extends State<AppStarter> {
  // -----------------------------------------------------------------------------
  /*
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
   */
  // -----------------------------------------------------------------------------
  @override
  void initState() {
    super.initState();
  }
  // --------------------
  /*
  bool _isInit = true;
  @override
  void didChangeDependencies() {
    if (_isInit) {
      _triggerLoading(setTo: true).then((_) async {
        /// END
        await _triggerLoading(setTo: false);
      });
    }
    _isInit = false;
    super.didChangeDependencies();
  }
   */
  // --------------------
  @override
  void dispose() {
    // _loading.dispose();
    super.dispose();
  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return MultiProvider(
      providers: <SingleChildWidget>[

          ChangeNotifierProvider<UiProvider>(
            create: (BuildContext ctx) => UiProvider(),
          ),

      ],
      child: MaterialApp(
        title: 'Talk to Humanity',

        /// DEBUG
        debugShowCheckedModeBanner: false,
        // debugShowMaterialGrid: false,
        // showPerformanceOverlay: false,
        // checkerboardRasterCacheImages: false,
        // showSemanticsDebugger: ,
        // checkerboardOffscreenLayers: ,

        /// THEME
        theme: ThemeData(
          canvasColor: Colorz.nothing,
          primarySwatch: const MaterialColor(0xFF13244b, {
            50: Color(0xFF13244b),
            100: Color(0xFF13244b),
            200: Color(0xFF13244b),
            300: Color(0xFF13244b),
            400: Color(0xFF13244b),
            500: Color(0xFF13244b),
            600: Color(0xFF13244b),
            700: Color(0xFF13244b),
            800: Color(0xFF13244b),
            900: Color(0xFF13244b),
          }),
          textSelectionTheme: const TextSelectionThemeData(
            selectionHandleColor: Colorz.white255,
            selectionColor: Colorz.white50,
          ),
        ),

        /// ROUTES
        home: const StartingScreen(),
        // navigatorObservers: [],
        // onGenerateInitialRoutes: ,
        // onUnknownRoute: ,
        navigatorKey: AppStarter.navigatorKey,
        onGenerateRoute: Routing.allRoutes,
        // initialRoute: Routing.homeRoute,
        routes: Routing.routesMap,
      ),
    );

  }
  // -----------------------------------------------------------------------------
}
