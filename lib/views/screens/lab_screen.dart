import 'package:bldrs_theme/bldrs_theme.dart';
import 'package:bubbles/bubbles.dart';
import 'package:filers/filers.dart';
import 'package:flutter/material.dart';
import 'package:talktohumanity/model/post_model.dart';
import 'package:talktohumanity/providers/post_real_ops.dart';
import 'package:talktohumanity/views/helpers/device_checker.dart';
import 'package:talktohumanity/views/widgets/basics/talk_box.dart';
import 'package:talktohumanity/views/widgets/basics/talk_text.dart';
import 'package:talktohumanity/views/widgets/layouts/basic_layout.dart';

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
      body: ListView(
        children: <Widget>[

        /// CREATE DUMMIES
        TalkBox(
          height: 40,
          text: 'Upload dummy posts',
          onTap: () async {

            for (final PostModel post in PostModel.dummyPosts()){

              final PostModel _uploaded = await PostRealOps.createNewPost(
                  post: post,
              );

              _uploaded.blogPost();

            }

          },
        ),

        /// READ ALL POSTS
        TalkBox(
          height: 40,
          text: 'Read all dummies',
          onTap: () async {

            final List<PostModel> _posts = await PostRealOps.readAllPublishedPosts();
            blog('RECEIVED ----> ${_posts.length} POSTS HERE BABY');

          },
        ),

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
        ),

        TalkText(
          text: dataValue.toString(),
          textHeight: 20,
          centered: false,
          font: BldrsThemeFonts.fontBldrsBodyFont,
          margins: const EdgeInsets.only(bottom: 7),
          maxLines: 3,
          // boxWidth: 300,
        ),

      ],
    );

  }
  // --------------------------------------------------------------------------
}
