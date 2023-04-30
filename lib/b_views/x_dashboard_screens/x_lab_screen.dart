import 'dart:typed_data';

import 'package:super_fire/super_fire.dart';
import 'package:bldrs_theme/bldrs_theme.dart';
import 'package:devicer/devicer.dart';
import 'package:filers/filers.dart';
import 'package:flutter/material.dart';
import 'package:layouts/layouts.dart';
import 'package:ldb/ldb.dart';
import 'package:legalizer/legalizer.dart';
import 'package:super_image/super_image.dart';
import 'package:talktohumanity/a_models/post_model.dart';
import 'package:talktohumanity/b_views/b_widgets/a_buttons/lab_button.dart';
import 'package:talktohumanity/b_views/b_widgets/b_texting/lab_title.dart';
import 'package:talktohumanity/b_views/b_widgets/b_texting/talk_text_field.dart';
import 'package:talktohumanity/b_views/b_widgets/c_dialogs/talk_dialogs.dart';
import 'package:talktohumanity/b_views/x_dashboard_screens/d_pending_posts_screen.dart';
import 'package:talktohumanity/c_services/helpers/standards.dart';
import 'package:talktohumanity/c_services/protocols/auth_protocols.dart';
import 'package:talktohumanity/c_services/protocols/post_protocols/post_ldb_ops.dart';
import 'package:talktohumanity/c_services/protocols/post_protocols/post_real_ops.dart';
import 'package:talktohumanity/c_services/protocols/timing_protocols.dart';
import 'package:talktohumanity/c_services/protocols/user_image_protocols.dart';
import 'package:talktohumanity/c_services/protocols/zoning_protocols.dart';

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
  bool _canShowDashboard = false;
  final TextEditingController _passwordController = TextEditingController();
  static const String _password = '1235';
  final ValueNotifier<bool> _isObscured = ValueNotifier(true);
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
  String _image = Iconz.achievement;
  // --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    return BasicLayout(

      body: MaxBounceNavigator(
        child: LayoutBuilder(
          builder: (_, BoxConstraints constraints) {

            /// SECRET VIEW
            if (_canShowDashboard == false){
              return Column(
                children: <Widget>[

                  TalkTextField(
                    headlineText: '𓂀 ☥ 𓆣 𓂝 𓆰 𓆎𓍯 𓏤 𓆑 𓆸 𓆏',
                    textController: _passwordController,
                    keyboardTextInputType: TextInputType.number,
                    headlineCentered: true,
                    isObscured: _isObscured,
                    onChanged: (String text){
                      if (text == _password){
                        setState(() {
                          _canShowDashboard = true;
                        });
                      }
                    },
                  ),

                ],
              );
            }

          /// DASHBOARD
          else {
            return FloatingList(
              padding: const EdgeInsets.only(bottom: 100),
              columnChildren: <Widget>[
                /// -------------------------------------------->

                /// SPACING
                const SizedBox(
                  width: 5,
                  height: 50,
                ),

                const DotSeparator(),

                const LabTitle(text: 'Dummy posts'),

                /// CREATE DUMMIES
                LabButton(
                  text: 'Upload dummy posts',
                  isOk: true,
                  onTap: () async {
                    // for (final PostModel post in PostModel.dummyPosts()){
                    //
                    //   final PostModel _uploaded = await PostRealOps.createNewPost(
                    //     post: post,
                    //     collName: PostRealOps.publishedPostsColl,
                    //   );
                    //
                    //   _uploaded?.blogPost();
                    //
                    // }

                   await Real.createDoc(collName: 'fuck', map: {'teez': 'beez'}, addDocIDToOutput: true);
                   blog('done');


                  },
                ),

                /// READ ALL POSTS
                LabButton(
                  text: 'Read all dummies',
                  isOk: true,
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
                  onTap: () {},
                  isOk: true,
                ),

                /// GOOGLE SIGN IN
                LabButton(
                  text: 'Google sign in',
                  isOk: true,
                  onTap: () async {
                    final AuthModel _authModel = await GoogleAuthing.emailSignIn();
                    AuthModel.blogAuthModel(authModel: _authModel);
                    setState(() {});
                  },
                ),

                /// GOOGLE SIGN OUT
                LabButton(
                  text: 'Sign out',
                  isOk: true,
                  onTap: () async {
                    await Authing.signOut();
                    setState(() {});
                  },
                ),

                /// ANONYMOUS SIGN IN
                LabButton(
                  text: 'Anonymous SignIn method',
                  isOk: true,
                  onTap: () async {
                    final AuthModel _authModel = await Authing.anonymousSignin();
                    AuthModel.blogAuthModel(authModel: _authModel);
                    setState(() {});
                  },
                ),

                /// DELETE FIREBASE USER
                LabButton(
                  text: 'Delete Firebase user',
                  isOk: true,
                  onTap: () async {
                    await Authing.deleteFirebaseUser(
                      userID: Authing.getUserID(),
                    );

                    setState(() {});
                  },
                ),

                /// ANONYMOUS SIGN IN
                LabButton(
                  text: 'GET ZONE',
                  isOk: true,
                  onTap: () async {
                    final String _zone = await ZoningProtocols.getZoneByIPApi();

                    blog('zone is : $_zone');
                  },
                ),

                // /// SIMPLE GOOGLE SIGN IN
                // LabButton(
                //   text: 'Simple google sign in',
                //   // isOk: false,
                //   onTap: () async {
                //     await AuthProtocols.simpleGoogleSignIn(
                //       flushbarKey: null,
                //     );
                //
                //     setState(() {});
                //   },
                // ),

                /// SIMPLE ANONYMOUS AUTH
                LabButton(
                  text: 'Simple Anonymous Auth',
                  isOk: true,
                  onTap: () async {
                    await AuthProtocols.simpleAnonymousSignIn();

                    setState(() {});
                  },
                ),

                /// FACEBOOK AUTH
                LabButton(
                  text: 'Facebook  Auth',
                  isOk: true,
                  onTap: () async {
                    // await FacebookAuth.instance.webInitialize(
                    //   appId: '727816559045136',
                    //   cookie: true, xfbml: true,
                    //   version: 'v11.0',
                    // );
                    final AuthModel _authModel = await FacebookAuthing.signIn();
                    AuthModel.blogAuthModel(authModel: _authModel);

                    if (_authModel != null) {
                      final String _url = _authModel.imageURL;

                      final Uint8List bytes = await Floaters.getUint8ListFromURL(_url);

                      final String bo = await UserImageProtocols.uploadBytesAndGetURL(
                        bytes: bytes,
                        userID: _authModel.id,
                      );

                      setState(() {
                        _image = bo;
                      });
                    }
                  },
                ),

                /// -------------------------------------------->
                const DotSeparator(),

                const LabTitle(text: 'Dialogs'),

                /// SHOW CENTER DIALOG
                LabButton(
                  text: 'Center dialog',
                  isOk: true,
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
                  isOk: true,
                  onTap: () async {
                    await Nav.goToNewScreen(
                      context: context,
                      screen: const PendingPostsScreen(),
                    );
                  },
                ),

                /// -------------------------------------------->
                const DotSeparator(),

                /// SIMPLE ANONYMOUS AUTH
                LabButton(
                  text: 'Upload image',
                  isOk: true,
                  onTap: () async {
                    // final Uint8List _bytes = await Floaters.getBytesFromLocalRasterAsset(
                    //     localAsset: TalkTheme.logo_night,
                    // );
                    //
                    // final Dimensions _dims = await Dimensions.superDimensions(_bytes);
                    //
                    // await Storage.uploadBytes(
                    //   bytes: _bytes,
                    //   path: 'test',
                    //   metaData: PicMetaModel(
                    //     ownersIDs: const ['fuckyou'],
                    //     dimensions: _dims,
                    //   ).toSettableMetadata(),
                    // );
                    //
                    // setState(() {});
                  },
                ),

                /// APPLE AUTH
                LabButton(
                  text: 'Apple Auth',
                  isOk: true,
                  onTap: () async {
                    await AppleAuthing.signInByApple();
                  },
                ),

                /// STEAL USER IMAGE
                LabButton(
                  text: 'Steal image',
                  isOk: true,
                  onTap: () async {
                    final User user = Authing.getFirebaseUser();

                    AuthBlog.blogFirebaseUser(user: user);

                    final Uint8List _bytes = await UserImageProtocols.downloadUserPic(
                      imageURL: user.photoURL,
                    );
                    String _newURL;
                    blog('2 steal user Image : _bytes : ${_bytes.length} bytes');

                    if (_bytes != null) {
                      _newURL = await UserImageProtocols.uploadBytesAndGetURL(
                        userID: user.uid,
                        bytes: _bytes,
                      );
                      blog('3 steal user Image : _newURL : $_newURL');
                    }
                  },
                ),

                /// CHECK DEVICE TIME
                LabButton(
                  text: 'CHECK DEVICE TIME',
                  isOk: true,
                  onTap: () async {
                    final bool _isCorrect = await TimingProtocols.checkDeviceTime();
                    blog('device time is correct? : $_isCorrect');
                  },
                ),

                SuperImage(
                  width: 200,
                  height: 200,
                  pic: _image,
                ),

                /// -------------------------------------------->
                const DotSeparator(),

                /// CHECK DEVICE TIME
                LabButton(
                  text: 'blog current firebase user',
                  isOk: true,
                  onTap: () async {
                    AuthBlog.blogCurrentFirebaseUser();
                  },
                ),

                /// -------------------------------------------->
                const DotSeparator(),

                /// GO TO TERMS
                LabButton(
                  text: 'go to Terms screen',
                  isOk: true,
                  onTap: () async {
                    await Nav.goToNewScreen(
                      context: context,
                      screen: const TermsScreen(
                        domain: 'talktohumanity.com',
                      ),
                    );
                  },
                ),

                /// GO TO PRIVACY POLICY
                LabButton(
                  text: 'Go to Privacy Policy',
                  isOk: true,
                  onTap: () async {
                    await Nav.goToNewScreen(
                      context: context,
                      screen: const PrivacyScreen(
                        domain: 'talktohumanity.com',
                      ),
                    );
                  },
                ),

                /// -------------------------------------------->
                const DotSeparator(),

                const LabTitle(text: 'FIRE SIGN IN'),

                /// PRINT CURRENT USER ID
                LabButton(
                  text: 'PRINT CURRENT USER ID',
                  isOk: true,
                  onTap: () async {
                    blog(Authing.getUserID());
                  },
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    ...List.generate(3, (index) {
                      const List<SignInMethod> methods = [
                        SignInMethod.apple,
                        SignInMethod.google,
                        SignInMethod.facebook
                      ];

                      return SocialAuthButton(
                        signInMethod: methods[index],
                        socialKeys: Standards.talkToHumanitySocialKeys,
                        onSuccess: (AuthModel authModel) {
                          AuthModel.blogAuthModel(authModel: authModel);
                        },
                        onError: (String error) {
                          blog('error is : $error');
                        },
                        manualAuthing: DeviceChecker.deviceIsAndroid(),
                      );
                    }),
                  ],
                ),

                /// -------------------------------------------->
                const DotSeparator(),

                const LabTitle(text: 'LDB OPS'),

                /// LDB VIEWERS
                LabButton(
                  text: 'Go to LDB VIEWERS Screen',
                  isOk: true,
                  onTap: () async {
                    await Nav.goToNewScreen(
                      context: context,
                      screen: const LDBBrowserScreen(
                        docs: [
                          'headline: Records',
                          PostLDBPOps.myViews,
                          PostLDBPOps.myLikes,
                          'headline: posts',
                          PostLDBPOps.publishedPosts,
                        ],
                      ),
                    );
                  },
                ),

                /// LDB VIEWER
                LabButton(
                  text: 'Go to LDB VIEWER Screen',
                  isOk: true,
                  onTap: () async {
                    await Nav.goToNewScreen(
                      context: context,
                      screen: const LDBViewerScreen(
                        ldbDocName: PostLDBPOps.myViews,
                      ),
                    );
                  },
                ),

                /// LDB TEST
                LabButton(
                  text: 'Go to LDB TEST Screen',
                  isOk: true,
                  onTap: () async {
                    await Nav.goToNewScreen(
                      context: context,
                      screen: const SembastTestScreen(),
                    );
                  },
                ),

              ],
            );
          }
        }),
      ),
    );
    // --------------------
  }
  // --------------------------------------------------------------------------
}
