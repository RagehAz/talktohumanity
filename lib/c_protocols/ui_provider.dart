import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:talktohumanity/d_helpers/helper_methods.dart';

// -----------------------------------------------------------------------------
/// => TAMAM
// final UiProvider _uiProvider = Provider.of<UiProvider>(context, listen: false);
class UiProvider extends ChangeNotifier {
  // -----------------------------------------------------------------------------

  /// CURRENT TAB

  // --------------------
  String _currentTab = 'Home';
  String get currentTab => _currentTab;
  // --------------------
  /// TASK : TEST ME
  static void proSetCurrentTab({
    @required String tab,
    @required bool notify,
  }) {
    final UiProvider _uiProvider = Provider.of<UiProvider>(getContext(), listen: false);
    _uiProvider.setCurrentTab(
      tab: tab,
      notify: notify,
    );
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  void setCurrentTab({
    @required String tab,
    @required bool notify,
  }){

    if (_currentTab != tab) {
      _currentTab = tab;

      if (notify == true) {
        notifyListeners();
      }
    }

  }
  // -----------------------------------------------------------------------------
}
// -----------------------------------------------------------------------------
