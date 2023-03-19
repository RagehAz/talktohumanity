import 'package:flutter/material.dart';
import 'package:talktohumanity/a_models/post_model.dart';
import 'package:talktohumanity/b_views/b_widgets/e_timeline/timeline_month_bullet.dart';
import 'package:talktohumanity/b_views/b_widgets/e_timeline/timeline_tile.dart';

class TimelineMonthBuilder extends StatelessWidget {
  // --------------------------------------------------------------------------
  const TimelineMonthBuilder({
    @required this.posts,
    @required this.onLike,
    @required this.onView,
    @required this.isFirstMonth,
    this.onDoubleTap,
    Key key
  }) : super(key: key);
  // --------------------------------------------------------------------------
  final List<PostModel> posts;
  final Function(PostModel post) onLike;
  final Function(PostModel post) onView;
  final bool isFirstMonth;
  final Function(PostModel post) onDoubleTap;
  // --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      itemCount: posts.length + 1,
      shrinkWrap: true,
      itemBuilder: (_, int i) {

        /// MONTH BULLET
        if (i == posts.length) {
          return TimeLineMonthBullet(
            month: posts.first.time.month,
            year: posts.first.time.year,
          );
        }

        /// MONTH TILES
        else {

          final int index = i ;
          final PostModel post = posts[index];

          return TimelineTile(
            isFirst: index == 0,
            firstIsExpanded: isFirstMonth == true,
            isLast: index + 1 == posts.length,
            onLike: onLike == null ? null : () => onLike(post),
            onView: onView == null ? null : () => onView(post),
            post: post,
            onDoubleTap: onDoubleTap == null ? null : () => onDoubleTap(post),
          );
        }

      },
    );

  }
  // --------------------------------------------------------------------------
}
