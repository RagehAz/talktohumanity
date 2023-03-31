import 'package:filers/filers.dart';
import 'package:bldrs_theme/bldrs_theme.dart';
import 'package:flutter/material.dart';
import 'package:stringer/stringer.dart';
import 'package:super_text/super_text.dart';

class ValueBox extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const ValueBox({
    @required this.dataKey,
    @required this.value,
    this.color = Colorz.bloodTest,
    Key key,
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final String dataKey;
  final dynamic value;
  final Color color;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTap: () async {

        blog('copyToClipboard : value.runTimeType : ${value.runtimeType}');

        await TextClipBoard.copy(
          copy: value,
        );

      },
      child: Container(
        height: 40,
        width: 80,
        color: color,
        margin: const EdgeInsets.all(2),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[

            SuperText(
              text: dataKey,
              italic: true,
              textHeight: 15,
            ),

            SuperText(
              text: value.toString(),
              textHeight: 15,
            ),

          ],
        ),
      ),
    );

  }
  /// --------------------------------------------------------------------------
}
