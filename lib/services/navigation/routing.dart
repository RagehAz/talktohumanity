import 'package:flutter/material.dart';
import 'package:layouts/layouts.dart';
import 'package:talktohumanity/views/screens/b_archive_screen.dart';
import 'package:talktohumanity/views/screens/a_home_screen.dart';

class Routing {
  // -----------------------------------------------------------------------------

  const Routing();

  // -----------------------------------------------------------------------------

  /// ROUTE NAMES

  // --------------------
  static const String homeRoute = '/home';
  static const String archiveRoute = '/archive';
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
    /// LAB
      case archiveRoute:
        return Nav.fadeToScreen(const ArchiveScreen(), settings);
        break;

    }
    return Nav.fadeToScreen(const HomeScreen(), settings);
  }
  // -----------------------------------------------------------------------------

  /// MAP

  // --------------------
  static Map<String, Widget Function(BuildContext)> routesMap = {
    homeRoute: (context) => const HomeScreen(),
    archiveRoute: (context) => const ArchiveScreen(),
    // translator: (context) => const TranslatorPage(),
    // youtubeWebpage: (context) => const YoutubeWebPage(),
  };
  // -----------------------------------------------------------------------------
}
