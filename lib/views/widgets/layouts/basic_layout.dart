import 'package:bldrs_theme/bldrs_theme.dart';
import 'package:flutter/material.dart';

class BasicLayout extends StatelessWidget {
  // -----------------------------------------------------------------------------
  const BasicLayout({
    @required this.body,
    Key key
  }) : super(key: key);
  // -----------------------------------------------------------------------------
  final Widget body;
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return SafeArea(

        child: GestureDetector(
          onTap: (){
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: Scaffold(
            // appBar: AboTubeAppBar.getBackAppBar(),

            /// INSETS
            resizeToAvoidBottomInset: false, /// if false : prevents keyboard from pushing pyramids up / bottom sheet
            // resizeToAvoidBottomPadding: false,
            backgroundColor: Colorz.black255,

            body: body,
          ),
        ),

    );

  }
  // -----------------------------------------------------------------------------
}
