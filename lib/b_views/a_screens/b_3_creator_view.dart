import 'dart:typed_data';

import 'package:animators/animators.dart';
import 'package:bldrs_theme/bldrs_theme.dart';
import 'package:filers/filers.dart';
import 'package:flutter/material.dart';
import 'package:numeric/numeric.dart';
import 'package:scale/scale.dart';
import 'package:talktohumanity/a_models/post_model.dart';
import 'package:talktohumanity/a_models/user_model.dart';
import 'package:talktohumanity/b_views/a_screens/b_0_home_screen.dart';
import 'package:talktohumanity/b_views/b_widgets/d_post_creator/post_creator.dart';
import 'package:talktohumanity/b_views/b_widgets/d_post_creator/user_creator_page.dart';
import 'package:talktohumanity/c_services/controllers/publishing_controllers.dart';
import 'package:talktohumanity/c_services/helpers/standards.dart';
import 'package:talktohumanity/c_services/protocols/user_image_protocols.dart';
import 'package:talktohumanity/c_services/protocols/user_protocols/user_protocols.dart';
import 'package:talktohumanity/c_services/providers/ui_provider.dart';
import 'package:authing/authing.dart';
import 'package:mediators/mediators.dart';
import 'package:widget_fader/widget_fader.dart';

class CreatorView extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const CreatorView({
    this.draft,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final PostModel draft;
  /// --------------------------------------------------------------------------
  @override
  _CreatorViewState createState() => _CreatorViewState();
  /// --------------------------------------------------------------------------
}

class _CreatorViewState extends State<CreatorView> {
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

    final UserModel _user = await UserProtocols.fetchUser(userID: Authing.getUserID());
    final Uint8List _uint8List = await UserImageProtocols.downloadUserPic(
      imageURL: _user?.image
    );

    setState(() {
      _imageBytes = _uint8List;
      _nameController.text = _user?.name;
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
  // --------------------
  void onBack(){
    blog('a77a');
    UiProvider.proSetHomeView(view: HomeScreenView.posts, notify: true);
  }
  // --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    final double _screenWidth = Scale.screenWidth(context);
    final double _screenHeight = Scale.screenHeight(context);
    // --------------------
    return WidgetFader(
      fadeType: FadeType.fadeIn,
      duration: Standards.homeViewFadeDuration,
      child: Container(
        width: _screenWidth,
        height: _screenHeight,
        color: Colorz.black125,
        child: PageView(
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
                onBack: onBack,
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
      ),
    );
    // --------------------
  }
  // --------------------------------------------------------------------------
}
