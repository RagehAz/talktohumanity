import 'dart:typed_data';

import 'package:filers/filers.dart';
import 'package:flutter/material.dart';
import 'package:layouts/layouts.dart';
import 'package:stringer/stringer.dart';
import 'package:talktohumanity/a_models/post_model.dart';
import 'package:talktohumanity/b_views/a_screens/e_auth_screen.dart';
import 'package:talktohumanity/b_views/b_widgets/c_dialogs/talk_dialogs.dart';
import 'package:talktohumanity/c_protocols/image_protocols/user_image_protocols.dart';
import 'package:talktohumanity/c_protocols/post_protocols/post_real_ops.dart';
import 'package:talktohumanity/d_helpers/helper_methods.dart';
import 'package:talktohumanity/d_helpers/routing.dart';
import 'package:talktohumanity/packages/authing/authing.dart';
import 'package:talktohumanity/packages/wait_dialog/wait_dialog.dart';
// -----------------------------------------------------------------------------
/// TESTED : WORKS PERFECT
Future<bool> prePublishCheckUps({
  @required PostModel post,
}) async {
  blog('prePublishCheckUps start');
  bool _output;

  if (TextCheck.isEmpty(post?.headline) == false && TextCheck.isEmpty(post?.body) == false){

      /// SIGN IN
  final bool _userIsSignedIn = await signIn();

  if (_userIsSignedIn == true) {

    if (PostModel.postIsPublishable(post: post) == true) {

      /// CONFIRM DIALOG
      final bool _canContinue = await confirmPublishDialog();

      if (_canContinue == true){
        _output = true;
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
/// TESTED : WORKS PERFECT
Future<void> publishPostOps({
  @required PostModel post,
  @required Uint8List image,
}) async {
  blog('publishPostOps start');


  final bool _canPublish = await prePublishCheckUps(
      post: post,
  );

  if (_canPublish == true){

    final BuildContext context = getContext();

    pushWaitDialog(
        context: context,
        text: 'Uploading post',
    );

    String _imageURL;

    if (image != null){
      _imageURL = await UserImageProtocols.uploadBytesAndGetURL(
        userID: post.userID,
        bytes: image,
      );
    }

    final PostModel _uploaded = await PostRealOps.createNewPost(
      post: post.copyWith(
        pic: _imageURL,
      ),
      collName: PostRealOps.pendingPostsColl,
    );

    await WaitDialog.closeWaitDialog(context);

    /// SUCCESS
    if (_uploaded != null){

      await showPublishSuccessDialog();

      await Nav.pushNamedAndRemoveAllBelow(
          context: getContext(),
          goToRoute: Routing.archiveRoute,
      );

    }

    /// FAILURE
    else {

      await showPublishFailureDialog();

    }

  }

}
// --------------------
/// TESTED : WORKS PERFECT
Future<void> showPublishSuccessDialog() async {
  blog('showPublishSuccessDialog start');

  await TalkDialog.centerDialog(
    title: 'Post has been submitted',
    body: 'Thank you, your post will be reviewed before publishing',
  );

}
// --------------------
/// TESTED : WORKS PERFECT
Future<void> showPublishFailureDialog() async {

  await TalkDialog.centerDialog(
    title: 'Failed to publish',
    body: 'Something went wrong, please try again',
  );

}
// -----------------------------------------------------------------------------
