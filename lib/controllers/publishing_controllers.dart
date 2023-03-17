import 'package:filers/filers.dart';
import 'package:flutter/material.dart';
import 'package:stringer/stringer.dart';
import 'package:talktohumanity/model/post_model.dart';
import 'package:talktohumanity/packages/authing/authing.dart';
import 'package:talktohumanity/packages/layouts/nav.dart';
import 'package:talktohumanity/services/helper_methods.dart';
import 'package:talktohumanity/services/navigation/routing.dart';
import 'package:talktohumanity/views/screens/auth_screen.dart';
import 'package:talktohumanity/views/widgets/dialogs/talk_dialogs.dart';
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
Future<void> onPublishPost({
  @required PostModel draft,
}) async {
  blog('onPublishPost start');
  final PostModel _postToPublish = await prePublishCheckUps(
    post: draft,
  );

  if (_postToPublish != null) {
    final bool _published = await publishPostOps(
      post: draft,
    );

    // await notifyAndNavigate(
    //   published: _published,
    // );
  }
}
// --------------------
/// TESTED : WORKS PERFECT
Future<PostModel> prePublishCheckUps({
  @required PostModel post,
}) async {
  blog('prePublishCheckUps start');
  PostModel _output;

  if (TextCheck.isEmpty(post?.headline) == false && TextCheck.isEmpty(post?.body) == false){

      /// SIGN IN
  final bool _userIsSignedIn = await signIn();

  if (_userIsSignedIn == true) {

    if (PostModel.postIsPublishable(post: post) == true) {

      /// CONFIRM DIALOG
      final bool _canContinue = await confirmPublishDialog();

      if (_canContinue == true){
        _output = post;
      }

    }

  }

  }

  return _output;
}
// --------------------
/// TESTED : WORKS PERFECT
Future<bool> signIn() async {
  blog('signIn start');

  if (Authing.getUserID() == null) {
    final bool _success = await Nav.goToNewScreen(
      context: getContext(),
      screen: const AuthScreen(),
    );

    return _success;
  }
  else {
    return true;
  }

}
// --------------------
/// TESTED : WORKS PERFECT
Future<bool> confirmPublishDialog() async {
  blog('confirmPublishDialog start');

  final bool _continue = await TalkDialog.boolDialog(
    title: 'Publish Post ?',
    body: 'Your post will be visible to the entire world',
  );

  return _continue;
}
// --------------------
/// TASK : WRITE ME
Future<bool> publishPostOps({
  @required PostModel post,
}) async {
  blog('publishPostOps start');
  bool _isPublished = false;
  if (mounted) {
    blog('SHOULD PUBLISH POST NOOOW');
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
