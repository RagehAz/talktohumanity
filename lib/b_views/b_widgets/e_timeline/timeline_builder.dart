import 'package:authing/authing.dart';
import 'package:bldrs_theme/bldrs_theme.dart';
import 'package:flutter/material.dart';
import 'package:layouts/layouts.dart';
import 'package:scale/scale.dart';
import 'package:super_box/super_box.dart';
import 'package:talktohumanity/a_models/post_model.dart';
import 'package:talktohumanity/a_models/user_model.dart';
import 'package:talktohumanity/b_views/b_widgets/a_buttons/talk_box.dart';
import 'package:talktohumanity/b_views/b_widgets/e_timeline/timeline_month_builder.dart';
import 'package:talktohumanity/c_services/controllers/home_view_controllers.dart';
import 'package:talktohumanity/c_services/helpers/routing.dart';
import 'package:talktohumanity/c_services/helpers/standards.dart';
import 'package:talktohumanity/c_services/protocols/user_protocols/user_protocols.dart';

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

        /// TALK TO HUMANITY BUTTON
        if (i == _keys.length) {
          return goToPostCreatorButtonIsOn == false ? const SizedBox()
              :
          Column(
            children: <Widget>[
              const SeparatorLine(
                width: 100,
                withMargins: true,
                color: Colorz.white50,
              ),

              FutureBuilder(
                  future: UserProtocols.fetchUser(userID: Authing.getUserID()),
                  builder: (_, AsyncSnapshot<UserModel> snap) {

                    final UserModel _user = snap.data;

                    return TalkBox(
                      height: 50,
                      width: Scale.screenWidth(context) - 60,
                      text: 'Talk to Humanity',
                      // margins: const EdgeInsets.only(top: 50),
                      // color: Colorz.white255,
                      isBold: true,
                      icon: _user?.image,
                      iconColor: Colorz.black255,
                      textScaleFactor: 0.8,
                      onTap: onTalkToHumanityButtonTap,
                    );
                  }),

              const SeparatorLine(
                width: 100,
                withMargins: true,
                color: Colorz.white50,
              ),

              SuperBox(
                width: 30,
                height: 30,
                icon: Iconz.dvRagehIcon,
                iconColor: Colorz.white10,
                bubble: false,
                onDoubleTap: () async {
                  await Routing.goToLab();
                  },
              ),

                  ],
          );

        }

        /// POSTS
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
