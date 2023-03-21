import 'package:bldrs_theme/bldrs_theme.dart';
import 'package:devicer/devicer.dart';
import 'package:filers/filers.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:layouts/layouts.dart';
import 'package:talktohumanity/a_models/post_model.dart';
import 'package:talktohumanity/b_views/b_widgets/a_buttons/lab_button.dart';
import 'package:talktohumanity/b_views/b_widgets/b_texting/lab_title.dart';
import 'package:talktohumanity/c_protocols/post_protocols/post_real_ops.dart';
import 'package:talktohumanity/b_views/a_screens/d_pending_posts_screen.dart';
import 'package:talktohumanity/b_views/b_widgets/b_texting/talk_text.dart';
import 'package:talktohumanity/b_views/b_widgets/c_dialogs/talk_dialogs.dart';
import 'package:talktohumanity/packages/lib/authing.dart';

class LabScreen extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const LabScreen({
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  @override
  _LabScreenState createState() => _LabScreenState();
  /// --------------------------------------------------------------------------
}

class _LabScreenState extends State<LabScreen> {
  // -----------------------------------------------------------------------------
  /// --- LOADING
  final ValueNotifier<bool> _loading = ValueNotifier(false);
  // --------------------
  Future<void> _triggerLoading({@required bool setTo}) async {
    setNotifier(
      notifier: _loading,
      mounted: mounted,
      value: setTo,
    );
  }
  // -----------------------------------------------------------------------------
  @override
  void initState() {
    super.initState();
  }
  // --------------------
  bool _isInit = true;
  @override
  void didChangeDependencies() {
    if (_isInit && mounted) {

      _triggerLoading(setTo: true).then((_) async {

        final String _deviceName = await DeviceChecker.getDeviceID();
        blog('device id is : $_deviceName');

        await _triggerLoading(setTo: false);
      });

      _isInit = false;
    }
    super.didChangeDependencies();
  }
  // --------------------
  @override
  void dispose() {
    _loading.dispose();
    super.dispose();
  }
  // --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------

    return BasicLayout(
      body: FloatingList(

        columnChildren: <Widget>[
          /// -------------------------------------------->
          const DotSeparator(),

          const LabTitle(text: 'Dummy posts'),

          /// CREATE DUMMIES
          LabButton(
            text: 'Upload dummy posts',
            onTap: () async {
              for (final PostModel post in PostModel.dummyPosts()){

                final PostModel _uploaded = await PostRealOps.createNewPost(
                  post: post,
                  collName: PostRealOps.publishedPostsColl,
                );

                _uploaded?.blogPost();

              }

              },
          ),

          /// READ ALL POSTS
          LabButton(
            text: 'Read all dummies',
            onTap: () async {
              final List<PostModel> _posts = await PostRealOps.readAllPublishedPosts();
              blog('RECEIVED ----> ${_posts.length} POSTS HERE BABY');
              },
          ),

          /// -------------------------------------------->
          const DotSeparator(),

          const LabTitle(text: 'Authing'),

          /// USER ID
          LabButton(
            text: 'user ID : ${Authing.getUserID()}',
            onTap: (){},
          ),

          /// GOOGLE SIGN IN
          LabButton(
            text: 'Google sign in',
            onTap: () async {
              final UserCredential _userCredential = await GoogleAuthing.emailSignIn();
              Authing.blogUserCredential(credential: _userCredential);
              setState(() {});
              },
          ),

          /// GOOGLE SIGN OUT
          LabButton(
            text: 'Sign out',
            onTap: () async {
              await GoogleAuthing.signOut();
              setState(() {});
              },
          ),

          /// ANONYMOUS SIGN IN
          LabButton(
            text: 'Anonymous SignIn',
            onTap: () async {
              final cred = await Authing.anonymousSignin();
              setState(() {});

              Authing.blogUserCredential(credential: cred);

              },
          ),

          /// DELETE FIREBASE USER
          LabButton(
            text: 'Delete Firebase user',
            onTap: () async {

              await Authing.deleteFirebaseUser(
                userID: Authing.getUserID(),
              );

              setState(() {});

              },
          ),

          /// -------------------------------------------->
          const DotSeparator(),

          const LabTitle(text: 'Dialogs'),

          /// SHOW CENTER DIALOG
          LabButton(
            text: 'Center dialog',
            onTap: () async {
              final bool _ok = await TalkDialog.boolDialog(
                body: 'Boool',
                invertButtons: true,
              );
              blog('is : $_ok');
              },
          ),

          /// -------------------------------------------->
          const DotSeparator(),

          const LabTitle(text: 'DASHBOARD'),

          /// GO TO PENDING POSTS
          LabButton(
            text: 'Go to Pending posts',
            onTap: () async {
              await Nav.goToNewScreen(
                context: context,
                screen: const PendingPostsScreen(),
              );
              },
          ),

          /// -------------------------------------------->
          const DotSeparator(),

        ],
      ),
    );
    // --------------------
  }
  // --------------------------------------------------------------------------
}

class DataStripWithHeadline extends StatelessWidget {
  // --------------------------------------------------------------------------
  const DataStripWithHeadline({
    @required this.dataKey,
    @required this.dataValue,
    Key key
  }) : super(key: key);
  // --------------------------------------------------------------------------
  final String dataKey;
  final dynamic dataValue;
  // --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        TalkText(
          text: dataKey,
          textHeight: 20,
          centered: false,
          boxColor: Colorz.bloodTest,
          isBold: true,
        ),

        TalkText(
          text: dataValue.toString(),
          textHeight: 20,
          centered: false,
          isBold: false,
          margins: const EdgeInsets.only(bottom: 7),
          maxLines: 3,
          // boxWidth: 300,
        ),

      ],
    );

  }
  // --------------------------------------------------------------------------
}
