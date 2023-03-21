import 'dart:typed_data';

import 'package:animators/animators.dart';
import 'package:bldrs_theme/bldrs_theme.dart';
import 'package:filers/filers.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:layouts/layouts.dart';
import 'package:night_sky/night_sky.dart';
import 'package:numeric/numeric.dart';
import 'package:scale/scale.dart';
import 'package:super_image/super_image.dart';
import 'package:talktohumanity/c_protocols/image_protocols/user_image_protocols.dart';
import 'package:talktohumanity/c_protocols/publishing_controllers.dart';
import 'package:talktohumanity/a_models/post_model.dart';
import 'package:talktohumanity/d_helpers/talk_theme.dart';
import 'package:talktohumanity/packages/authing/authing.dart';
import 'package:talktohumanity/packages/mediators/mediators.dart';
import 'package:talktohumanity/b_views/b_widgets/d_post_creator/post_creator.dart';
import 'package:talktohumanity/b_views/b_widgets/d_post_creator/user_creator_page.dart';

class PostCreatorScreen extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const PostCreatorScreen({
    this.draft,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final PostModel draft;
  /// --------------------------------------------------------------------------
  @override
  _PostCreatorScreenState createState() => _PostCreatorScreenState();
  /// --------------------------------------------------------------------------
}

class _PostCreatorScreenState extends State<PostCreatorScreen> {
  // -----------------------------------------------------------------------------
  final GlobalKey<FormState> _formKeyA = GlobalKey();
  bool _canErrorizeA = false;
  bool _titleIsOn = true;
  // --------------------
  final GlobalKey<FormState> _formKeyB = GlobalKey();
  bool _canErrorizeB = false;
  // -----------------------------------------------------------------------------
  final PageController _pageController = PageController();
  // --------------------
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _bodyController = TextEditingController();
  // --------------------
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  Uint8List _imageBytes;
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

    if (widget.draft != null){

      _titleController.text = widget.draft.headline;
      _bodyController.text = widget.draft.body;
      _nameController.text = widget.draft.name;
      _bioController.text = widget.draft.bio;
      _emailController.text = widget.draft.email;

    }

  }
  // --------------------
  bool _isInit = true;
  @override
  void didChangeDependencies() {
    if (_isInit && mounted) {
      _triggerLoading(setTo: true).then((_) async {

        await initializeUserVariables();

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
    _pageController.dispose();
    _titleController.dispose();
    _bodyController.dispose();
    _nameController.dispose();
    _bioController.dispose();
    _emailController.dispose();
    super.dispose();
  }
  // --------------------------------------------------------------------------
  /// TESTED : WORKS PERFECT
  Future<void> initializeUserVariables() async {

    final User _user = Authing.getFirebaseUser();
    final Uint8List _uint8List = await UserImageProtocols.downloadUserPic();

    setState(() {
      _imageBytes = _uint8List;
      _nameController.text = _user?.displayName;
      _emailController.text =  _user?.email;
    });

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  Future<void> _pickImage() async {

    final Uint8List _bytes = await PicMaker.pickAndCropSinglePic(
      context: context,
      cropAfterPick: true,
      aspectRatio: 1,
      resizeToWidth: 500,
    );

    if (_bytes != null){
      setState(() {
        _imageBytes = _bytes;
      });
    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  Future<void> _onNext() async {

    final bool _isSignedIn = await signIn();

    if (_isSignedIn == true) {

      final bool isValid = _formKeyA.currentState.validate();

      if (isValid == true){

        await initializeUserVariables();

      await Sliders.slideToNext(
        pageController: _pageController,
        numberOfSlides: 2,
        currentSlide: 0,
      );

      }
      else {

        setState(() {
          _canErrorizeA = true;
        });

      }


    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  Future<void> _onPublish() async {

    FocusManager.instance.primaryFocus?.unfocus();

    final bool isValid = _formKeyB.currentState.validate();

    if (isValid == true){
      await publishPostOps(
        image: _imageBytes,
        post: _generatePostModel(),
      );

    }
    else {
        setState(() {
          _canErrorizeB = true;
        });
    }


  }
  // --------------------
  /// TESTED : WORKS PERFECT
  PostModel _generatePostModel(){
    return PostModel(
          body: _bodyController.text,
          headline: _bodyController.text,
          pic: Authing.getFirebaseUser()?.photoURL,
          email: _emailController.text,
          bio: _bioController.text,
          name: _nameController.text,
          time: DateTime.now(),
          likes: 0,
          views: 0,
          id: Numeric.createUniqueID().toString(),
          userID: Authing.getUserID(),
        );
  }
  // --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    final double _screenWidth = Scale.screenWidth(context);
    final double _screenHeight = Scale.screenHeight(context);
    // --------------------
    return BasicLayout(
      body: SizedBox(
          width: _screenWidth,
          height: _screenHeight,
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[

            const Sky(
              skyColor: Colorz.black255,
              skyType: SkyType.blackStars,
            ),

            /// BACKGROUND WORLD
            Opacity(
              opacity: 0.9,
              child: SuperImage(
                height: _screenWidth * 1.2,
                width: _screenWidth * 1.2,
                pic: TalkTheme.logo_day,
              ),
            ),

            /// PAGES
            PageView(
              physics: const NeverScrollableScrollPhysics(),
              controller: _pageController,
              scrollDirection: Axis.vertical,
              children: <Widget>[

                /// POST CREATOR PAGE
                Form(
                  key: _formKeyA,
                  child: PostCreatorView(
                    titleController: _titleController,
                    bodyController: _bodyController,
                    onPublish: _onNext,
                    canErrorize: _canErrorizeA,
                    onSkip: () => Nav.goBack(context: context),
                    onSwitchTitle: (bool isOn){

                      setState(() {
                        _titleIsOn = isOn;
                      });

                      if (_titleIsOn == false){
                        FocusManager.instance.primaryFocus?.unfocus();
                      }

                      },
                    titleIsOn: _titleIsOn,
                  ),
                ),

                /// USER CREATOR PAGE
                Form(
                  key: _formKeyB,
                  child: UserCreatorView(
                    nameController: _nameController,
                    emailController: _emailController,
                    bioController: _bioController,
                    imageBytes: _imageBytes,
                    onPickImage: _pickImage,
                    onPublish: _onPublish,
                    canErrorize: _canErrorizeB,
                    onSlideBack: () async {

                      await Sliders.slideToBackFrom(
                        pageController: _pageController,
                        currentSlide: 1,
                      );

                      },
                  ),
                ),

              ],
            ),

          ],
          ),
        ),
    );
    // --------------------
  }
  // --------------------------------------------------------------------------
}
