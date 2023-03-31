part of ldb;


class LDBViewerScreen extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const LDBViewerScreen({
    @required this.ldbDocName,
    Key key,
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final String ldbDocName;
  /// --------------------------------------------------------------------------
  static List<Widget> rows({
    @required BuildContext context,
    @required List<Map<String, Object>> maps,
    @required ValueChanged<Map<String, dynamic>> onRowOptionsTap,
    /// if there is field with name ['color']
    bool userColorField = false,
  }) {

    final double _screenWidth = Scale.screenWidth(context);
    final bool _bubbleIsOn = onRowOptionsTap != null;

    return List<Widget>.generate(maps?.length ?? 0, (int index) {

      final Map<String, Object> _map = maps[index];
      final List<Object> _keys = _map.keys.toList();
      final List<Object> _values = _map.values.toList();
      // final String _primaryValue = _map[_primaryKey];

      return SizedBox(
        width: _screenWidth,
        height: 42,
        child: ListView(
          physics: const BouncingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          children: <Widget>[

            /// MORE OPTIONS
            SuperBox(
              height: 37,
              width: 37,
              icon: Iconz.more,
              iconSizeFactor: 0.4,
              bubble: _bubbleIsOn,
              onTap: () {
                if (onRowOptionsTap != null) {
                  onRowOptionsTap(_map);
                }
              },
              // margins: EdgeInsets.all(5),
            ),

            /// ROW NUMBER
            SuperBox(
              height: 40,
              width: 40,
              text: '${index + 1}',
              textScaleFactor: 0.6,
              margins: const EdgeInsets.all(5),
              bubble: false,
              color: Colorz.white10,
            ),

            /// ROW VALUES
            ...List<Widget>.generate(_values.length, (int i) {
              final String _key = _keys[i];
              final String _value = _values[i].toString();

              return ValueBox(
                dataKey: _key,
                value: _value,
                color: userColorField == true ? Colorizer.decipherColor(_map['color']) ?? Colorz.bloodTest : Colorz.green125,
              );
            }),

          ],
        ),
      );
    });
  }
  /// --------------------------------------------------------------------------
  @override
  State<LDBViewerScreen> createState() => _LDBViewerScreenState();
  /// --------------------------------------------------------------------------
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(StringProperty('ldbDocName', ldbDocName));
  }
  /// --------------------------------------------------------------------------
}

class _LDBViewerScreenState extends State<LDBViewerScreen> {
  // -----------------------------------------------------------------------------
  final GlobalKey _flushbarKey = GlobalKey();
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
    super.didChangeDependencies();

    if (_isInit) {
      _triggerLoading(setTo: true).then((_) async {
        await _readSembast();
      });
    }
    _isInit = false;
  }
  // --------------------
  @override
  void dispose() {
    _loading.dispose();
    super.dispose();
  }
  // -----------------------------------------------------------------------------
  List<Map<String, Object>> _maps;
  Future<void> _readSembast() async {
    final List<Map<String, Object>> _sembastMaps = await LDBOps.readAllMaps(
      docName: widget.ldbDocName,
    );

    setState(() {
      _maps = _sembastMaps;
    });

    unawaited(_triggerLoading(setTo: false));

  }
  // --------------------
  Future<void> _onRowTap(Map<String, dynamic> map) async {
    // blog('Bldrs local data base : _bldbName : ${widget.ldbDocName} : row id : $id');
    Mapper.blogMap(map);
  }
  // --------------------
  Future<void> _onClearLDB() async {

    final bool _result = await CenterDialog.showCenterDialog(
      context: context,
      bubble: CenterDialog.buildBubble(
        context: context,
        boolDialog: true,
        title: 'Confirm ?',
        body: 'All data will be permanently deleted, do you understand ?',
      ),
    );

    if (_result == true) {
      await LDBOps.deleteAllMapsAtOnce(docName: widget.ldbDocName);
      await _readSembast();
    }

    else {
      await TopDialog.showTopDialog(
        flushbarKey: _flushbarKey,
        context: context,
        firstText: 'Nothing was deleted',
      );
    }

  }
  // --------------------
  Future<void> _onBldrsTap() async {

    await BottomDialog.showButtonsBottomDialog(
        context: context,
        draggable: true,
        buttonHeight: 40,
        numberOfWidgets: 1,
        builder: (_){

          return <Widget>[

            SuperBox(
              width: BottomDialog.clearWidth(context),
              height: 40,
              text: 'Clear ${widget.ldbDocName} data',
              textScaleFactor: 0.7,
              onTap: _onClearLDB,
            ),

          ];

        }

    );
  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return BasicLayout(
      body: MaxBounceNavigator(
        child: FloatingList(
          columnChildren: <Widget>[

            SuperBox(
              height: 40,
              text: 'Tap Bldrs.net to wipe this:\n${widget.ldbDocName}',
              onTap: _onBldrsTap,
            ),

            if (Mapper.checkCanLoopList(_maps))
          ...LDBViewerScreen.rows(
            context: context,
            // color: Colorz.Green125,
            maps: _maps,
            onRowOptionsTap: _onRowTap,
          ),


          ],
        ),
      ),

    );

  }
  // -----------------------------------------------------------------------------
}
