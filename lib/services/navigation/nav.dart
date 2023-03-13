import 'dart:async';
import 'package:filers/filers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:page_transition/page_transition.dart';
import 'package:talktohumanity/main.dart';
import 'package:talktohumanity/services/navigation/routing.dart';

class Nav {
  // -----------------------------------------------------------------------------

  const Nav();

  static const Duration duration150ms = Duration(milliseconds: 150);
  // -----------------------------------------------------------------------------

  /// GOING FORWARD

  // --------------------
  /// TESTED : WORKS PERFECT
  static PageTransition<dynamic> slideToScreen(Widget screen, RouteSettings settings) {
    return PageTransition<dynamic>(
      child: screen,
      type: PageTransitionType.bottomToTop,
      // duration: Ratioz.durationFading200,
      // reverseDuration: Ratioz.durationFading200,
      curve: Curves.fastOutSlowIn,
      settings: settings,
    );
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static PageTransition<dynamic> fadeToScreen(Widget screen, RouteSettings settings) {
    return PageTransition<dynamic>(
      child: screen,
      type: PageTransitionType.fade,
      duration: duration150ms,
      reverseDuration: duration150ms,
      curve: Curves.fastOutSlowIn,
      settings: settings,
    );
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<dynamic> goToNewScreen({
    @required BuildContext context,
    @required Widget screen,
    PageTransitionType pageTransitionType = PageTransitionType.bottomToTop,
    Widget childCurrent,
  }) async {

    final dynamic _result = await Navigator.push(
      context,
      PageTransition<dynamic>(
        type: pageTransitionType,
        childCurrent: childCurrent,
        child: screen,
        // duration: Ratioz.durationFading200,
        // reverseDuration: Ratioz.durationFading200,
        curve: Curves.fastOutSlowIn,
        alignment: Alignment.bottomCenter,
      ),
    );

    return _result;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> goToRoute(BuildContext context, String routezName, {dynamic arguments}) async {
    await Navigator.of(context).pushNamed(routezName, arguments: arguments);
  }

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> replaceRoute(BuildContext context, String routezName, {dynamic arguments}) async {
    await Navigator.of(context).pushReplacementNamed(routezName, arguments: arguments);
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<dynamic> replaceScreen({
    @required BuildContext context,
    @required Widget screen,
    PageTransitionType transitionType = PageTransitionType.bottomToTop,
  }) async {

    final dynamic _result = await Navigator.pushReplacement(
        context,
        PageTransition<dynamic>(
          type: transitionType,
          child: screen,
          // duration: Ratioz.duration750ms,
          // reverseDuration: Ratioz.duration750ms,
          curve: Curves.fastOutSlowIn,
          alignment: Alignment.bottomCenter,
        )
    );

    return _result;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> pushNamedAndRemoveAllBelow({
    @required BuildContext context,
    @required String goToRoute,
  }) async {

    await Navigator.of(context).pushNamedAndRemoveUntil(goToRoute, (Route<dynamic> route) => false);

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> pushAndRemoveUntil({
    @required BuildContext context,
    @required Widget screen,
  }) async {

    await Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute<dynamic>(
          builder: (_) => screen,
        ),
            (Route<dynamic> route) => route.isFirst);
  }
  // -----------------------------------------------------------------------------

  /// GOING BACK

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> goBack({
    @required BuildContext context,
    String invoker,
    dynamic passedData,
    bool addPostFrameCallback = false,
  }) async {

    // await CacheOps.wipeCaches();

    if (context != null){

      if (addPostFrameCallback == true){
        SchedulerBinding.instance.addPostFrameCallback((_) {
          final BuildContext _context = AppStarter.navigatorKey.currentContext;
          Navigator.pop(_context, passedData);
        });
      }

      else {
        await Future.delayed(Duration.zero, (){
          Navigator.pop(context, passedData);
        });
      }


    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> closeApp(BuildContext context) async {
    await SystemNavigator.pop();
  }

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> goBackUntil({
    @required BuildContext context,
    @required String routeName,
    bool addPostFrameCallback = false,
  }) async {

    if (context != null){

      if (addPostFrameCallback == true){
        SchedulerBinding.instance.addPostFrameCallback((_) {
          Navigator.popUntil(context, ModalRoute.withName(routeName));
        });
      }

      else {
        await Future.delayed(Duration.zero, (){
          Navigator.popUntil(context, ModalRoute.withName(routeName));
        });
      }


    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> pushHomeAndRemoveAllBelow({
    @required BuildContext context,
    @required String invoker,
  }) async {

    blog('goBackToHomeScreen : popUntil Routing.home : $invoker');

    await Nav.pushNamedAndRemoveAllBelow(
      context: context,
      goToRoute: Routing.homeRoute,
    );

  }
  // -----------------------------------------------------------------------------

  /// I DONT KNO ABOUT THIS SHIT

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> removeRouteBelow(BuildContext context, Widget screen) async {
    Navigator.removeRouteBelow(context, MaterialPageRoute<dynamic>(builder: (BuildContext context) => screen));
  }
  // -----------------------------------------------------------------------------

  /// TRANSITION

  // --------------------
  /// TESTED : WORKS PERFECT
  static PageTransitionType superHorizontalTransition({
    @required BuildContext context,
    bool appIsLTR = true, /// LEFT => RIGHT (ENGLISH)
    bool inverse = false,
  }) {

    /// NOTE: IMAGINE OPENING AN ENGLISH BOOK => NEXT PAGE COMES FROM RIGHT TO LEFT

    /// LEFT TO RIGHT (EN)
    if (appIsLTR == true){

      return inverse == false ?
      /// NORMAL : <--- RIGHT TO LEFT (LIKE A BOOK)
      PageTransitionType.rightToLeftWithFade
          :
      /// INVERSE : ---> LEFT TO RIGHT
      PageTransitionType.leftToRightWithFade;
    }

    /// RIGHT TO LEFT (AR)
    else {
      return inverse == false ?
      /// NORMAL : ---> LEFT TO RIGHT (LIKE A BOOK)
      PageTransitionType.leftToRightWithFade
          :
      /// INVERSE : <--- RIGHT TO LEFT
      PageTransitionType.rightToLeftWithFade;
    }

    // -----------------------------------------------------------------------------
  }
  // -----------------------------------------------------------------------------

  /// HOME SCREEN NAV.

  // --------------------
  /*
  /// TESTED : WORKS PERFECT
  static Future<void> autoNav({
    @required BuildContext context,
    @required String routeName,
    @required bool startFromHome,
    Object arguments,
  }) async {

    if (routeName != null){

      UiProvider.proSetAfterHomeRoute(
          context: context,
          routeName:routeName,
          arguments: arguments,
          notify: true
      );

      if (startFromHome == true){
        await Nav.pushHomeAndRemoveAllBelow(
          context: context,
          invoker: 'autoNav',
        );
      }

      else {
        await autoNavigateFromHomeScreen(context);
      }

    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> autoNavigateFromHomeScreen(BuildContext context) async {

    final RouteSettings _afterHomeRoute = UiProvider.proGetAfterHomeRoute(
      context: context,
      listen: false,
    );

    if (_afterHomeRoute != null){

      Future<void> _goTo;

      switch(_afterHomeRoute.name){
      // --------------------
      /// TESTED : WORKS PERFECT
        case Routing.myBzScreen:
          _goTo = Nav.goToMyBzScreen(
            context: context,
            bzID: _afterHomeRoute.arguments,
            replaceCurrentScreen: false,
          ); break;
      // --------------------
      /// TESTED : WORKS PERFECT
        case Routing.myBzNotesPage:
          _goTo = Nav.goToMyBzScreen(
            context: context,
            bzID: _afterHomeRoute.arguments,
            replaceCurrentScreen: false,
            initialTab: BzTab.notes,
          ); break;
      // --------------------
      /// TESTED : WORKS PERFECT
        case Routing.myBzTeamPage:
          _goTo = Nav.goToMyBzScreen(
            context: context,
            bzID: _afterHomeRoute.arguments,
            replaceCurrentScreen: false,
            initialTab: BzTab.team,
          ); break;
      // --------------------
      /// TESTED : WORKS PERFECT
        case Routing.myUserScreen:
          _goTo = Nav.goToMyUserScreen(
            context: context,
          ); break;
      // --------------------
      /// TESTED : WORKS PERFECT
        case Routing.myUserNotesPage:
          _goTo = Nav.goToMyUserScreen(
            context: context,
            userTab: UserTab.notifications,
          ); break;
      // --------------------
      /// TESTED : WORKS PERFECT
        case Routing.userPreview:
          _goTo = jumpToUserPreviewScreen(
            context: context,
            userID: _afterHomeRoute.arguments,
          ); break;
      // --------------------
      /// TESTED : WORKS PERFECT
        case Routing.bzPreview:
          _goTo = jumpToBzPreviewScreen(
            context: context,
            bzID: _afterHomeRoute.arguments,
          ); break;
      // --------------------
      /// TESTED : WORKS PERFECT
        case Routing.flyerPreview:
          _goTo = jumpToFlyerPreviewScreen(
            context: context,
            flyerID: _afterHomeRoute.arguments,
          ); break;
      // --------------------
      /// TESTED : WORKS PERFECT
        case Routing.flyerReviews:
          _goTo = jumpToFlyerReviewScreen(
            context: context,
            flyerIDAndReviewID: _afterHomeRoute?.arguments,
          ); break;
      // --------------------
      /// PLAN : ADD COUNTRIES PREVIEW SCREEN
      /*
       case Routing.countryPreview:
         return jumpToCountryPreviewScreen(
           context: context,
           countryID: _afterHomeRoute.arguments,
         ); break;
        */
      // --------------------
      /// PLAN : ADD BLDRS PREVIEW SCREEN
      /*
         case Routing.bldrsPreview:
           return jumpToBldrsPreviewScreen(
             context: context,
           ); break;
          */
      // --------------------
      }

      /// CLEAR AFTER HOME ROUTE
      UiProvider.proClearAfterHomeRoute(
        context: BldrsAppStarter.navigatorKey.currentContext,
        notify: true,
      );

      await _goTo;

    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> onLastGoBackInHomeScreen(BuildContext context) async {

    /// TO HELP WHEN PHRASES ARE NOT LOADED TO REBOOT SCREENS
    if (PhraseProvider.proGetPhidsAreLoaded(context) == false){
      await Nav.pushNamedAndRemoveAllBelow(
        context: context,
        goToRoute: Routing.staticLogoScreen,
      );
    }

    /// NORMAL CASE WHEN ON BACK WHILE IN HO
    else {

      final bool _result = await Dialogs.goBackDialog(
        context: context,
        titleVerse: const Verse(
          text: 'phid_exit_app_?',
          translate: true,
        ),
        bodyVerse: const Verse(
          pseudo: 'Would you like to exit and close Bldrs.net App ?',
          text: 'phid_exit_app_notice',
          translate: true,
        ),
        confirmButtonVerse: const Verse(
          text: 'phid_exit',
          translate: true,
        ),

      );

      if (_result == true){

        await CenterDialog.closeCenterDialog(context);

        await Future.delayed(const Duration(milliseconds: 500), () async {
          await Nav.closeApp(context);
        },
        );

      }

    }

  }
   */
  // -----------------------------------------------------------------------------
}
