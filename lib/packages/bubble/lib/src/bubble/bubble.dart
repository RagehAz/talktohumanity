part of bubbles;

class Bubbles extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const Bubbles({
    @required this.columnChildren,
    @required this.bubbleHeaderVM,
    this.childrenCentered = false,
    this.bubbleColor = const Color.fromARGB(10, 255, 255, 255),
    this.width,
    this.onBubbleTap,
    this.margin,
    this.corners,
    this.areTopCentered = true,
    this.onBubbleDoubleTap,
    this.appIsLTR = true,
    this.splashColor = const Color.fromARGB(200, 255, 255, 255),
    Key key,
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final List<Widget> columnChildren;
  final BubbleHeaderVM bubbleHeaderVM;
  final bool childrenCentered;
  final Color bubbleColor;
  final double width;
  final Function onBubbleTap;
  final dynamic margin;
  final dynamic corners;
  final bool areTopCentered;
  final Function onBubbleDoubleTap;
  final bool appIsLTR;
  final Color splashColor;
  // -----------------------------------------------------------------------------
  static double clearWidth({
    @required BuildContext context,
    double bubbleWidthOverride,
  }) {
    final double _bubbleWidth = bubbleWidth(
        context: context,
        bubbleWidthOverride: bubbleWidthOverride,
    );
    const double _bubblePaddings = 10 * 2.0;
    return _bubbleWidth - _bubblePaddings;
  }
  // --------------------
  static double bubbleWidth({
    @required BuildContext context,
    double bubbleWidthOverride
  }) {
    return bubbleWidthOverride ?? Scale.screenWidth(context) - 20;
  }
  // --------------------
  /*
  static double _getTitleHeight(BuildContext context){
    const int _titleVerseSize = 2;
    return SuperVerse.superVerseRealHeight(
      context: context,
      size: _titleVerseSize,
      sizeFactor: 1,
      hasLabelBox: false,
    );
  }
   */
  // --------------------
  static double getHeightWithoutChildren({
    @required double headlineHeight,
  }){
    return (_pageMargin * 3) + headlineHeight;
    // return (_pageMargin * 3) + _getTitleHeight(context);
  }
  // --------------------
  static const double cornersValue = 18;
  static const double _pageMargin = 10;
  // --------------------
  static const double clearCornersValue = cornersValue - _pageMargin;
  // --------------------
  static BorderRadius borders(BuildContext context,) {
    return Borderers.superCorners(
      context: context,
      corners: cornersValue,
    );
  }
  // --------------------
  static BorderRadius clearBorders(BuildContext context,) {
    return Borderers.superCorners(
      context: context,
      corners: clearCornersValue,
    );
  }
  // --------------------
  static double paddingValue(){
    return _pageMargin;
  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    final EdgeInsets _bubbleMargins = margin == null ? EdgeInsets.zero : Scale.superMargins(margin: margin);
    // --------------------
    final double _bubbleWidth = bubbleWidth(
        context: context,
        bubbleWidthOverride: width,
    );
    // --------------------
    final BorderRadius _corners = corners == null ?
    borders(context)
        :
    Borderers.superCorners(context: context, corners: corners);
    // --------------------
    final Alignment _alignment = childrenCentered == true ?
    (areTopCentered == true ? Alignment.topCenter : Alignment.center)
        :
    (areTopCentered == true ? Aligner.top(appIsLTR: appIsLTR) : Aligner.center(appIsLTR: appIsLTR));
    // --------------------
    final Widget _bubbleContents = _BubbleContents(
      width: width,
      childrenCentered: childrenCentered,
      columnChildren: columnChildren,
      headerViewModel: bubbleHeaderVM,
    );
    // --------------------
    return Center(
      child: Container(
        key: key,
        width: _bubbleWidth,
        margin: _bubbleMargins.copyWith(bottom: _pageMargin),
        // padding: EdgeInsets.all(_pageMargin),
        decoration: BoxDecoration(
          color: bubbleColor,
          borderRadius: _corners,
        ),
        alignment: _alignment,
        child: onBubbleTap == null && onBubbleDoubleTap == null?

        _bubbleContents

            :

        Material(
          color: const Color.fromARGB(0, 255, 255, 255),
          child: InkWell(
            onTap: onBubbleTap,
            onDoubleTap: onBubbleDoubleTap,
            splashColor: onBubbleTap == null ? const Color.fromARGB(0, 255, 255, 255) : splashColor,
            borderRadius: _corners,
            child: _bubbleContents,
          ),
        ),

      ),
    );
    // --------------------
  }
// -----------------------------------------------------------------------------
}

class _BubbleContents extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const _BubbleContents({
    @required this.columnChildren,
    @required this.childrenCentered,
    @required this.width,
    @required this.headerViewModel,
    Key key,
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final List<Widget> columnChildren;
  final bool childrenCentered;
  final double width;
  final BubbleHeaderVM headerViewModel;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return Padding(
      key: const ValueKey<String>('_BubbleContents'),
      padding: const EdgeInsets.all(Bubbles._pageMargin),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: childrenCentered == true ?
        MainAxisAlignment.center
            :
        MainAxisAlignment.start,
        crossAxisAlignment: childrenCentered == true ?
        CrossAxisAlignment.center
            :
        CrossAxisAlignment.start,
        children: <Widget>[

          BubbleHeader(
            viewModel: headerViewModel.copyWith(
                headerWidth: headerViewModel?.headerWidth ??
                    (width == null ? null : width-20)
            ),
          ),

          ...columnChildren,

        ],
      ),
    );

  }
/// --------------------------------------------------------------------------
}
