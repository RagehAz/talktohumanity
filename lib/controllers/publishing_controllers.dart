import 'package:filers/filers.dart';
import 'package:flutter/material.dart';
import 'package:talktohumanity/authenticator/authenticator.dart';
import 'package:talktohumanity/services/helper_methods.dart';
import 'package:talktohumanity/services/navigation/nav.dart';
import 'package:talktohumanity/services/navigation/routing.dart';
import 'package:talktohumanity/views/screens/auth_screen.dart';
// -----------------------------------------------------------------------------
const bool mounted = true;
// -----------------------------------------------------------------------------
/// TASK : TEST ME
Future<void> onSkipPublishing() async {
  blog('_onSkipPublishing start');
  await navToArchiveScreen();
}
// --------------------
/// TASK : TEST ME
Future<void> onPublishPost() async {
  blog('onPublishPost start');
  final bool _canPublish = await prePublishCheckUps();

  if (_canPublish == true) {
    final bool _published = await publishPostOps();

    // await notifyAndNavigate(
    //   published: _published,
    // );
  }
}
// --------------------
/// TESTED : WORKS PERFECT
Future<bool> prePublishCheckUps() async {
  blog('prePublishCheckUps start');
  bool _canContinue = false;
  final bool _userIsSignedIn = await userIsSignedIn();

  /// IF SIGNED IN
  if (_userIsSignedIn == true) {
    _canContinue = await confirmPublishDialog();
  }

  /// IF NOT SIGNED IN
  else {
    final bool _signInSuccess = await signIn();

    /// COULD SIGN IN
    if (_signInSuccess == true) {
      _canContinue = await confirmPublishDialog();
    }

    /// COULD NOT SIGN IN
    else {
      _canContinue = false;
    }
  }

  return _canContinue;
}
// --------------------
/// TESTED : WORKS PERFECT
Future<bool> userIsSignedIn() async {
  blog('userIsSignedIn start');
  return Authing.getUserID() != null;
}
// --------------------
/// TESTED : WORKS PERFECT
Future<bool> signIn() async {
  blog('signIn start');

  final bool _success = await Nav.goToNewScreen(
      context: getContext(),
      screen: const AuthScreen(),
  );

  return _success;
}
// --------------------
/// TASK : WRITE ME
Future<bool> confirmPublishDialog() async {
  blog('confirmPublishDialog start');
  bool _continue = false;
  if (mounted) {
    _continue = true;
  }
  return _continue;
}
// --------------------
/// TASK : WRITE ME
Future<bool> publishPostOps() async {
  blog('publishPostOps start');
  bool _isPublished = false;
  if (mounted) {
    _isPublished = true;
  }
  return _isPublished;
}
// --------------------
Future<void> notifyAndNavigate({
  @required bool published,
}) async {
  blog('notifyAndNavigate start');

  if (published == true) {
    await showPublishSuccessDialog();
    await navToArchiveScreen();
  }

  else {
    await showPublishFailureDialog();
  }
}
// --------------------
/// TASK : WRITE ME
Future<void> showPublishSuccessDialog() async {
  blog('showPublishSuccessDialog start');
}
// --------------------
/// TASK : WRITE ME
Future<void> showPublishFailureDialog() async {
  blog('showPublishFailureDialog start');
}
// --------------------
/// TASK : WRITE ME
Future<void> navToArchiveScreen() async {
  blog('navToArchiveScreen start');
  await Nav.goToRoute(getContext(), Routing.archiveRoute);
}
  // -----------------------------------------------------------------------------
