import 'package:bldrs_theme/bldrs_theme.dart';
import 'package:devicer/devicer.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:talktohumanity/b_views/a_screens/a_starting_screen.dart';
import 'package:talktohumanity/c_services/helpers/standards.dart';
import 'package:talktohumanity/c_services/providers/ui_provider.dart';
import 'package:talktohumanity/c_services/helpers/routing.dart';
import 'package:talktohumanity/firebase_options.dart';
import 'package:authing/authing.dart';

// --------------------
/// to build clean ON IOS
/*
 flutter clean \
        && rm ios/Podfile.lock pubspec.lock \
        && rm -rf ios/Pods ios/Runner.xcworkspace \
        && flutter build ios --build-name=1.0.0 --build-number=1 --release --dart-define=MY_APP_ENV=prod
 */

/*

// on ios error : No such module 'Flutter' : Xcode 13.2.1

// delete ios/Pods
// delete ios/Podfile.lock
// delete pubspec.lock
// flutter clean
// flutter pub get -v
// pod deintegrate
// pod install
// flutter build ios-framework --output=Flutter -v
(if you wanna create Release Files, you should use command "flutter build ios-framework --no-debug --no-profile --release --output=Flutter").

 */
// ---------------------------------------------------------------------------
/// steps to DEPLOY web
/*

flutter run -d chrome --web-renderer html

1- flutter build web --web-renderer html --release -v

// 1 - flutter build web
// 2 - fix build/web/main.dart.js in line 27435 and put this => else a.xZ(0,s,"Bldrs.net",b)},
        => 1.0.7 was at  28781 else a.zj(0,s,"Bldrs.net",b)},
        => 1.0.7+1 was at else a.zj(0,s,"flutter",b)},

// 3 - firebase deploy
*/
// ---------------------------------------------------------------------------
Future<void> main() async {
  // --------------------------------------------------------------------------
  final WidgetsBinding _binding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: _binding);
  // --------------------
  if (DeviceChecker.deviceIsIOS() == true){
    await Firebase.initializeApp(
      // name: 'talktohumanity',
      // options: DefaultFirebaseOptions.currentPlatform,
    );
  }
  else {
    await Firebase.initializeApp(
      // name: 'talktohumanity',
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }

  // --------------------
  Authing.initializeSocialAuthing(
      socialKeys: Standards.talkToHumanitySocialKeys
  );
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
    FlutterNativeSplash.remove();
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
        initialRoute: Routing.startingRoute,
        routes: Routing.routesMap,
      ),
    );

  }
  // -----------------------------------------------------------------------------
}
