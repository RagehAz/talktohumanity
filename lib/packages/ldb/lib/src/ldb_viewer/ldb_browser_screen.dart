part of ldb;

class LDBBrowserScreen extends StatelessWidget {
  // -----------------------------------------------------------------------------
  const LDBBrowserScreen({
    @required this.docs,
    Key key
  }) : super(key: key);

  final List<String> docs;
  // -----------------------------------------------------------------------------
  /// TESTED : WORKS PERFECT
  static Future<void> goToLDBViewer(BuildContext context, String ldbDocName) async {
    await Nav.goToNewScreen(
        context: context,
        screen: LDBViewerScreen(
          ldbDocName: ldbDocName,
        )
    );
  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    if (Mapper.checkCanLoopList(docs) == false){
      return const Center(
          child: SuperText(
              text: 'No Docs found'
          )
      );
    } else {

      return BasicLayout(
        body: MaxBounceNavigator(
          child: FloatingList(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            columnChildren: <Widget>[

              const SuperText(
                text: 'All LDB Docs :-',
                font: BldrsThemeFonts.fontBldrsHeadlineFont,
                weight: FontWeight.w600,
                italic: true,
                margins: 10,
                // textHeight: 50,
                centered: false,
                appIsLTR: true,
                textColor: Colorz.white200,
                textDirection: TextDirection.ltr,
              ),

              const SeparatorLine(),

              ...List<Widget>.generate(docs.length, (int index) {

                  final String ldbDoc = docs[index];

                  /// HEADLINE
                  if (ldbDoc.startsWith('headline')) {
                    return SuperText(
                      text: TextMod.removeTextBeforeFirstSpecialCharacter(ldbDoc, ':'),
                      font: BldrsThemeFonts.fontBldrsHeadlineFont,
                      weight: FontWeight.w600,
                      italic: true,
                      margins: 10,
                      textHeight: 40,
                      centered: false,
                      appIsLTR: true,
                      textDirection: TextDirection.ltr,
                    );
                  }

                  /// BUTTON
                  else {
                    return SuperBox(
                      height: 40,
                      text: ldbDoc, // notifications prefs, my user model
                      onTap: () => goToLDBViewer(context, ldbDoc),
                      icon: Iconz.info,
                      iconSizeFactor: 0.6,
                      color: Colorz.bloodTest,
                      margins: 5,
                    );
                  }
                }),

            ],
          ),
        ),
      );
    }
  }
  // -----------------------------------------------------------------------------
}
