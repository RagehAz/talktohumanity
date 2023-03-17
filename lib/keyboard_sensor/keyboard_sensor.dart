import 'package:filers/filers.dart';
import 'package:flutter/material.dart';

class KeyboardSensor extends StatefulWidget {
  // -----------------------------------------------------------------------------
  const KeyboardSensor({
    @required this.child,
    @required this.builder,
    Key key
  }) : super(key: key);
  // -----------------------------------------------------------------------------
  final Widget child;
  final Widget Function(bool isVisible, Widget child) builder;
  // -----------------------------------------------------------------------------
  @override
  State<KeyboardSensor> createState() => _KeyboardSensorState();
  // -----------------------------------------------------------------------------
}

class _KeyboardSensorState extends State<KeyboardSensor> with WidgetsBindingObserver {
  // -----------------------------------------------------------------------------
  final ValueNotifier<bool> _isVisible = ValueNotifier(false);
  // --------------------
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }
  // --------------------
  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _isVisible.dispose();
    super.dispose();
  }
  // --------------------
  @override
  void didChangeMetrics() {
    super.didChangeMetrics();
    final mediaQueryData = MediaQuery.of(context);
    final bool _visible = mediaQueryData.viewInsets.bottom > 0;

    setNotifier(
      value: _visible,
      mounted: mounted,
      notifier: _isVisible,
    );

  }
  // --------------------
  @override
  Widget build(BuildContext context) {

    return ValueListenableBuilder(
        valueListenable: _isVisible,
        child: widget.child,
        builder: (_, bool isVisible, Widget child){

          return widget.builder(isVisible, child);

        },
    );

  }
  // -----------------------------------------------------------------------------
}
