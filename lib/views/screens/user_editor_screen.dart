import 'dart:typed_data';
import 'package:bldrs_theme/bldrs_theme.dart';
import 'package:bubbles/bubbles.dart';
import 'package:filers/filers.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:layouts/layouts.dart';
import 'package:super_box/super_box.dart';
import 'package:talktohumanity/model/post_model.dart';
import 'package:talktohumanity/packages/authing/authing.dart';
import 'package:talktohumanity/packages/mediators/mediators.dart';
import 'package:talktohumanity/views/widgets/basics/talk_text.dart';
import 'package:talktohumanity/views/widgets/layouts/basic_layout.dart';
import 'package:talktohumanity/views/widgets/post_creator.dart';

class UserEditorScreen extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const UserEditorScreen({
    @required this.post,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final PostModel post;
  /// --------------------------------------------------------------------------
  @override
  _UserEditorScreenState createState() => _UserEditorScreenState();
  /// --------------------------------------------------------------------------
}

class _UserEditorScreenState extends State<UserEditorScreen> {
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

  }
  // --------------------
  bool _isInit = true;
  @override
  void didChangeDependencies() {
    if (_isInit && mounted) {

      _triggerLoading(setTo: true).then((_) async {

        await initializeVariables();

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
  Future<void> initializeVariables() async {

    final User _user = Authing.getFirebaseUser();
    final Uint8List _uint8List = await Floaters.getUint8ListFromURL(_user?.photoURL);

    setState(() {
      _imageBytes = _uint8List;
      _nameController.text = _user.displayName;
      _emailController.text =  _user.email;
    });

  }
  // --------------------------------------------------------------------------
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

  @override
  Widget build(BuildContext context) {
    // --------------------
    final double _bubbleWidth = PostCreatorView.getBubbleWidth();
    // --------------------
    return BasicLayout(
      body: FloatingList(
        columnChildren: <Widget>[

          const DotSeparator(bottomMarginIsOn: false),

          const TalkText(
            text: 'Add more info about you',
            textHeight: 40,
          ),

          const DotSeparator(),

          /// NAME FIELD
          TextFieldBubble(
            bubbleHeaderVM: const BubbleHeaderVM(
              headlineText: 'Name',
              headlineHeight: 18,
              headlineColor: Colorz.white200,
            ),
            bubbleWidth: _bubbleWidth,
            textController: _nameController,
            // maxLength: 10000,
            keyboardTextInputType: TextInputType.multiline,
            fieldTextFont: BldrsThemeFonts.fontBldrsHeadlineFont,
            hintText: '...',
            bulletPointsFont: BldrsThemeFonts.fontBldrsBodyFont,
            fieldTextCentered: true,
            fieldTextHeight: 37,
            // maxLines: 1,
            // minLines: 1,
          ),

          /// BIO FIELD
          TextFieldBubble(
            bubbleHeaderVM: const BubbleHeaderVM(
              headlineText: 'Biography',
              headlineHeight: 18,
              headlineColor: Colorz.white200,
            ),
            bubbleWidth: _bubbleWidth,
            textController: _bioController,
            maxLines: 7,
            // maxLength: 10000,
            keyboardTextInputType: TextInputType.multiline,
            fieldTextFont: BldrsThemeFonts.fontBldrsHeadlineFont,
            hintText: '...',
            bulletPointsFont: BldrsThemeFonts.fontBldrsBodyFont,
            minLines: 3,
            fieldTextCentered: true,
            fieldTextHeight: 37,
          ),

          /// EMAIL FIELD
          TextFieldBubble(
            bubbleHeaderVM: const BubbleHeaderVM(
              headlineText: 'E-mail',
              headlineHeight: 18,
              headlineColor: Colorz.white200,
            ),
            bubbleWidth: _bubbleWidth,
            textController: _emailController,
            // maxLength: 10000,
            keyboardTextInputType: TextInputType.multiline,
            fieldTextFont: BldrsThemeFonts.fontBldrsHeadlineFont,
            hintText: '...',
            bulletPointsFont: BldrsThemeFonts.fontBldrsBodyFont,
            fieldTextCentered: true,
            fieldTextHeight: 37,
            // maxLines: 1,
            // minLines: 1,
          ),

          /// USER IMAGE
          SuperBox(
            width: 70,
            height: 70,
            icon: _imageBytes,
            onTap: _pickImage
          ),

        ],
      ),
    );
    // --------------------
  }
  // --------------------------------------------------------------------------
}
