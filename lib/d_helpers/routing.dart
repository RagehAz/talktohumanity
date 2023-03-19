import 'package:flutter/material.dart';
import 'package:layouts/layouts.dart';
import 'package:talktohumanity/b_views/a_screens/b_archive_screen.dart';
import 'package:talktohumanity/b_views/a_screens/a_starting_screen.dart';

class Routing {
  // -----------------------------------------------------------------------------

  const Routing();

  // -----------------------------------------------------------------------------

  /// ROUTE NAMES

  // --------------------
  static const String startingRoute = '/starting';
  static const String archiveRoute = '/archive';
  // -----------------------------------------------------------------------------

  /// ROUTER

  // --------------------
  /// TESTED : WORKS PERFECT
  static Route<dynamic> allRoutes(RouteSettings settings) {

    switch (settings.name) {

    /// HOME
      case startingRoute:
        return Nav.fadeToScreen(const StartingScreen(), settings);
        break;
    /// LAB
      case archiveRoute:
        return Nav.fadeToScreen(const ArchiveScreen(), settings);
        break;

    }
    return Nav.fadeToScreen(const StartingScreen(), settings);
  }
  // -----------------------------------------------------------------------------

  /// MAP

  // --------------------
  static Map<String, Widget Function(BuildContext)> routesMap = {
    startingRoute: (context) => const StartingScreen(),
    archiveRoute: (context) => const ArchiveScreen(),
    // translator: (context) => const TranslatorPage(),
    // youtubeWebpage: (context) => const YoutubeWebPage(),
  };
  // -----------------------------------------------------------------------------
}
