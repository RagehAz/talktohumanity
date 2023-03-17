import 'package:filers/filers.dart';
import 'package:flutter/material.dart';
import 'package:numeric/numeric.dart';
import 'package:scale/scale.dart';
import 'package:talktohumanity/controllers/publishing_controllers.dart';
import 'package:talktohumanity/model/post_model.dart';
import 'package:talktohumanity/services/navigation/nav.dart';
import 'package:talktohumanity/views/widgets/layouts/basic_layout.dart';
import 'package:talktohumanity/views/widgets/post_creator.dart';

class PostCreatorScreen extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const PostCreatorScreen({Key key}) : super(key: key);

  /// --------------------------------------------------------------------------
  @override
  _PostCreatorScreenState createState() => _PostCreatorScreenState();

  /// --------------------------------------------------------------------------
}

class _PostCreatorScreenState extends State<PostCreatorScreen> {
  // -----------------------------------------------------------------------------
  final TextEditingController _textController = TextEditingController();
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
    _textController.dispose();
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
      body: SizedBox(
        width: _screenWidth,
        height: _screenHeight,
        child: PostCreatorView(
          titleController: _textController,
          bodyController: _bodyController,
          onPublish: onPublishPost,
          onSkip: () => Nav.goBack(context: context),
        ),
      ),
    );
    // --------------------
  }
  // --------------------------------------------------------------------------
}
