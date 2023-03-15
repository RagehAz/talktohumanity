import 'package:filers/filers.dart';
import 'package:flutter/material.dart';
import 'package:talktohumanity/services/helper_methods.dart';
import 'package:talktohumanity/services/navigation/nav.dart';
import 'package:talktohumanity/services/navigation/routing.dart';
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

    await notifyAndNavigate(
      published: _published,
    );
  }
}
// --------------------
/// TASK : TEST ME
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
/// TASK : WRITE ME
Future<bool> userIsSignedIn() async {
  blog('userIsSignedIn start');
  bool _isSignedIn = false;
  if (mounted) {
    _isSignedIn = true;
  }
  return _isSignedIn;
}
// --------------------
/// TASK : WRITE ME
Future<bool> signIn() async {
  blog('signIn start');
  bool _success = false;

  if (mounted) {
    _success = true;
  }

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
