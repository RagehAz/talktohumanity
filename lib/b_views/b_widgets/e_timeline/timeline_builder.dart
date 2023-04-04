import 'package:bldrs_theme/bldrs_theme.dart';
import 'package:flutter/material.dart';
import 'package:layouts/layouts.dart';
import 'package:scale/scale.dart';
import 'package:talktohumanity/a_models/post_model.dart';
import 'package:talktohumanity/b_views/b_widgets/a_buttons/talk_box.dart';
import 'package:talktohumanity/b_views/b_widgets/e_timeline/timeline_month_builder.dart';
import 'package:talktohumanity/c_services/controllers/home_view_controllers.dart';
import 'package:talktohumanity/c_services/helpers/standards.dart';

class TimeLineBuilder extends StatelessWidget {
  // --------------------------------------------------------------------------
  const TimeLineBuilder({
    @required this.posts,
    this.onView,
    this.onLike,
    this.controller,
    this.goToPostCreatorButtonIsOn = true,
    this.onDoubleTap,
    Key key
  }) : super(key: key);
  // --------------------------------------------------------------------------
  final List<PostModel> posts;
  final Function(PostModel post) onLike;
  final Function(PostModel post) onView;
  final ScrollController controller;
  final bool goToPostCreatorButtonIsOn;
  final Function(PostModel post) onDoubleTap;
  // --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final Map<String, dynamic> _postsMap = PostModel.organizePostsInMap(
        posts: posts,
      );

    final List<String> _keys = _postsMap?.keys?.toList();

    return ListView.builder(
      controller: controller,
      physics: const BouncingScrollPhysics(),
      shrinkWrap: true,
      padding: EdgeInsets.only(
        top: Standards.getTimeLineTopMostMargin(),
        bottom: Standards.timelineMinTileHeight,
      ),
      itemCount: _keys.length + 1,
      itemBuilder: (_, i) {

        if (i == _keys.length) {

          return goToPostCreatorButtonIsOn == false ? const SizedBox() : Column(
            children: <Widget>[

              const SeparatorLine(
                width: 100,
                withMargins: true,
                color: Colorz.white50,
              ),

              TalkBox(
                height: 50,
                width: Scale.screenWidth(context) - 20,
                text: 'Talk to Humanity',
                // margins: const EdgeInsets.only(top: 50),
                // color: Colorz.white255,
                isBold: true,
                // icon: TalkTheme.logo_cloudy,
                iconSizeFactor: 0.7,
                iconColor: Colorz.black255,
                textScaleFactor: 0.8 / 0.7,
                onTap: onTalkToHumanityButtonTap,
              ),

              const SeparatorLine(
                width: 100,
                withMargins: true,
                color: Colorz.white50,
              ),

            ],
          );

        }

        else {
          final String key = _keys[i];

          return TimelineMonthBuilder(
            onLike: onLike == null ? null : (PostModel post) => onLike(post),
            onView: onView == null ? null : (PostModel post) => onView(post),
            posts: _postsMap[key],
            isFirstMonth: i == 0,
            onDoubleTap: onDoubleTap,
          );
        }
      },
    );
  }
  // --------------------------------------------------------------------------
}
