import 'package:flutter/material.dart';
import 'package:layouts/layouts.dart';
import 'package:legalizer/legalizer.dart';
import 'package:talktohumanity/b_views/a_screens/a_starting_screen.dart';
import 'package:talktohumanity/b_views/a_screens/b_0_home_screen.dart';
import 'package:talktohumanity/b_views/x_dashboard_screens/d_pending_posts_screen.dart';
import 'package:talktohumanity/b_views/x_dashboard_screens/x_lab_screen.dart';
import 'package:talktohumanity/c_services/helpers/helper_methods.dart';
import 'package:talktohumanity/c_services/helpers/standards.dart';

class Routing {
  // -----------------------------------------------------------------------------

  const Routing();

  // -----------------------------------------------------------------------------
  static const String _domain = 'talktohumanity.com';
  // -----------------------------------------------------------------------------

  /// ROUTE NAMES

  // --------------------
  static const String startingRoute = '/starting';
  static const String homeRoute = '/home';
  static const String terms = '/terms';
  static const String privacy = '/privacy';
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
      case homeRoute:
        return Nav.fadeToScreen(const HomeScreen(), settings);
        break;

    /// TERMS
      case terms:
        return Nav.fadeToScreen(const TermsScreen(domain: _domain,), settings);
        break;
    /// PRIVACY
      case privacy:
        return Nav.fadeToScreen(const PrivacyScreen(domain: _domain,), settings);
        break;

    }
    return Nav.fadeToScreen(const StartingScreen(), settings);
  }
  // -----------------------------------------------------------------------------

  /// MAP

  // --------------------
  static Map<String, Widget Function(BuildContext)> routesMap = {
    startingRoute: (context) => const StartingScreen(),
    homeRoute: (context) => const HomeScreen(),
    terms: (context) => const TermsScreen(domain: _domain),
    privacy: (context) => const PrivacyScreen(domain: _domain),
  };
  // -----------------------------------------------------------------------------

  /// TALK NAVIGATORS

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> goToLab() async {
    // if (Standards.isRageh() == true || kDebugMode == true){
      await Nav.goToNewScreen(context: getContext(), screen: const LabScreen());
    // }
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> goToPendingPosts() async {
    if (Standards.isRageh() == true){
      await Nav.goToNewScreen(context: getContext(), screen: const PendingPostsScreen());
    }
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> goToPrivacyScreen() async {
    await Nav.goToRoute(getContext(), Routing.privacy);
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> goToTermsScreen() async {
    await Nav.goToRoute(getContext(), Routing.terms);
  }
  // -----------------------------------------------------------------------------
}
