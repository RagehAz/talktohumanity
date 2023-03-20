import 'package:flutter/material.dart';
import 'package:layouts/layouts.dart';
import 'package:talktohumanity/b_views/a_screens/a_starting_screen.dart';
import 'package:talktohumanity/b_views/a_screens/b_archive_screen.dart';
import 'package:talktohumanity/b_views/a_screens/d_pending_posts_screen.dart';
import 'package:talktohumanity/b_views/a_screens/x_lab_screen.dart';
import 'package:talktohumanity/d_helpers/helper_methods.dart';
import 'package:talktohumanity/d_helpers/standards.dart';

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

  /// TALK NAVIGATORS

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> goToLab() async {
    if (Standards.isRageh() == true){
      await Nav.goToNewScreen(context: getContext(), screen: const LabScreen());
    }
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> goToPendingPosts() async {
    if (Standards.isRageh() == true){
      await Nav.goToNewScreen(context: getContext(), screen: const PendingPostsScreen());
    }
  }
  // -----------------------------------------------------------------------------
}
