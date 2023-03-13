import 'package:flutter/material.dart';
import 'package:talktohumanity/services/navigation/nav.dart';
import 'package:talktohumanity/views/screens/home_screen.dart';

class Routing {
  // -----------------------------------------------------------------------------

  const Routing();

  // -----------------------------------------------------------------------------

  /// ROUTE NAMES

  // --------------------
  static const String homeRoute = '/home';
  // static const String labRoute = '/lab';
  // -----------------------------------------------------------------------------

  /// ROUTER

  // --------------------
  /// TESTED : WORKS PERFECT
  static Route<dynamic> allRoutes(RouteSettings settings) {

    switch (settings.name) {

    /// HOME
      case homeRoute:
        return Nav.fadeToScreen(const HomeScreen(), settings);
        break;
    // /// LAB
    //   case labRoute:
    //     return Nav.fadeToScreen(const LabPage(), settings);
    //     break;

    }
    return Nav.fadeToScreen(const HomeScreen(), settings);
  }
  // -----------------------------------------------------------------------------

  /// MAP

  // --------------------
  static Map<String, Widget Function(BuildContext)> routesMap = {
    // homeRoute: (context) => const HomeScreen(),
    // labRoute: (context) => const LabPage(),
    // translator: (context) => const TranslatorPage(),
    // youtubeWebpage: (context) => const YoutubeWebPage(),
  };
  // -----------------------------------------------------------------------------
}
