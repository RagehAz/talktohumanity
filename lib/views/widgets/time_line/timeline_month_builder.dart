import 'package:flutter/material.dart';
import 'package:talktohumanity/views/widgets/time_line/time_line_headline.dart';
import 'package:talktohumanity/views/widgets/time_line/timeline_tile.dart';

class TimelineMonthBuilder extends StatelessWidget {
  // --------------------------------------------------------------------------
  const TimelineMonthBuilder({
    @required this.posts,
    @required this.onLike,
    @required this.onView,
    Key key
  }) : super(key: key);
  // --------------------------------------------------------------------------
  final List<String> posts;
  final Function(String post) onLike;
  final Function(String post) onView;
  // --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      itemCount: posts.length + 1,
      shrinkWrap: true,
      itemBuilder: (_, int i) {

        if (i == 0) {
          return const TimeLineHeadline();
        }

        else {

          final int index = i - 1;
          final String post = posts[index];

          return TimelineTile(
            isFirst: index == 0,
            isLast: index + 1 == posts.length,
            onLike: () => onLike(post),
            onView: () => onView(post),
          );
        }

      },
    );
  }
  // --------------------------------------------------------------------------
}
