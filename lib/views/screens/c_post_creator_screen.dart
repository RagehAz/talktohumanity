import 'dart:typed_data';

import 'package:animators/animators.dart';
import 'package:devicer/devicer.dart';
import 'package:filers/filers.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:layouts/layouts.dart';
import 'package:scale/scale.dart';
import 'package:talktohumanity/controllers/publishing_controllers.dart';
import 'package:talktohumanity/model/post_model.dart';
import 'package:talktohumanity/packages/authing/authing.dart';
import 'package:talktohumanity/packages/mediators/mediators.dart';
import 'package:talktohumanity/views/widgets/post_creators/post_creator.dart';
import 'package:talktohumanity/views/widgets/post_creators/user_creator_page.dart';

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
  final PageController _pageController = PageController();
  // -----------------------------------------------------------------------------
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _bodyController = TextEditingController();
  // -----------------------------------------------------------------------------
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
    final Uint8List _uint8List = await Floaters.getUint8ListFromURL(_user?.photoURL);

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

      await initializeUserVariables();

      await Sliders.slideToNext(
        pageController: _pageController,
        numberOfSlides: 2,
        currentSlide: 0,
      );
    }

  }

  // --------------------
  ///
  Future<void> _onPublish() async {



  }
  // --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    final double _screenWidth = Scale.screenWidth(context);
    final double _screenHeight = Scale.screenHeight(context);
    // --------------------
    return BasicLayout(
      body: KeyboardSensor(
        builder: (bool isVisible, Widget child) {
          blog(' THE KEYBOARD isVisible : $isVisible');
          return child;
        },
        child: SizedBox(
            width: _screenWidth,
            height: _screenHeight,
            child: PageView(
              physics: const BouncingScrollPhysics(),
              controller: _pageController,
              scrollDirection: Axis.vertical,
              children: <Widget>[

                PostCreatorView(
                  titleController: _titleController,
                  bodyController: _bodyController,
                  onPublish: _onNext,
                  onSkip: () => Nav.goBack(context: context),
                ),

                UserCreatorView(
                  nameController: _nameController,
                  emailController: _emailController,
                  bioController: _bioController,
                  imageBytes: _imageBytes,
                  onPickImage: _pickImage,
                  onPublish: _onPublish,
                ),

              ],
            ),
          ),
      ),
    );
    // --------------------
  }
  // --------------------------------------------------------------------------
}
