import 'package:filers/filers.dart';
import 'package:flutter/material.dart';
import 'package:numeric/numeric.dart';
import 'package:scale/scale.dart';
import 'package:talktohumanity/controllers/publishing_controllers.dart';
import 'package:talktohumanity/packages/keyboard/keyboard_sensor.dart';
import 'package:talktohumanity/model/post_model.dart';
import 'package:talktohumanity/packages/layouts/nav.dart';
import 'package:talktohumanity/views/widgets/layouts/basic_layout.dart';
import 'package:talktohumanity/views/widgets/post_creator.dart';

class PostCreatorScreen extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const PostCreatorScreen({
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  @override
  _PostCreatorScreenState createState() => _PostCreatorScreenState();
  /// --------------------------------------------------------------------------
}

class _PostCreatorScreenState extends State<PostCreatorScreen> {
  // -----------------------------------------------------------------------------
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _bodyController = TextEditingController();
  PostModel _draft;
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

    _draft = PostModel(
      id: Numeric.createUniqueID().toString(),
      name: null,
      email: null,
      bio: null,
      headline: null,
      body: null,
      pic: null,
      time: null,
      likes: 0,
      views: 0,
    );

  }
  // --------------------
  bool _isInit = true;
  @override
  void didChangeDependencies() {
    if (_isInit && mounted) {
      _triggerLoading(setTo: true).then((_) async {

        /// FUCK

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
    _titleController.dispose();
    super.dispose();
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
        child: SizedBox(
            width: _screenWidth,
            height: _screenHeight,
            child: PostCreatorView(
              titleController: _titleController,
              bodyController: _bodyController,
              onPublish: () => onPublishPost(
                draft: PostModel(
                  body: _bodyController.text,
                  headline: _titleController.text,
                  id: Numeric.createUniqueID().toString(),
                  views: 0,
                  likes: 0,
                  time: DateTime.now(),
                  name: null,
                  bio: null,
                  email: null,
                  pic: null
                ),
              ),
              onSkip: () => Nav.goBack(context: context),
            ),
          ),
        builder: (bool isVisible, Widget child) {

          blog(' THE KEYBOARD isVisible : $isVisible');

          return child;
        }
      ),
    );
    // --------------------
  }
  // --------------------------------------------------------------------------
}
