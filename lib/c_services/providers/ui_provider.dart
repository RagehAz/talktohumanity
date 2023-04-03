import 'package:filers/filers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:talktohumanity/b_views/a_screens/b_0_home_screen.dart';
import 'package:talktohumanity/c_services/helpers/helper_methods.dart';

// -----------------------------------------------------------------------------
/// => TAMAM
// final UiProvider _uiProvider = Provider.of<UiProvider>(context, listen: false);
class UiProvider extends ChangeNotifier {
  // -----------------------------------------------------------------------------

  /// HOME SCREEN VIEW

  // --------------------
  HomeScreenView _previousView;
  HomeScreenView get previousView => _previousView;
  // --------------------
  HomeScreenView _view = HomeScreenView.posts;
  HomeScreenView get homeView => _view;
  // --------------------
  /// TESTED : WORKS PERFECT
  static HomeScreenView proGetHomeView({
    @required bool listen,
  }) {
    final UiProvider _uiProvider = Provider.of<UiProvider>(getContext(), listen: listen);
    return _uiProvider.homeView;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static HomeScreenView proGetPreviousHomeView({
    @required bool listen,
  }) {
    final UiProvider _uiProvider = Provider.of<UiProvider>(getContext(), listen: false);
    return _uiProvider.previousView;
  }  // --------------------
  /// TESTED : WORKS PERFECT
  static void proSetHomeView({
    @required HomeScreenView view,
    @required bool notify,
  }) {
    final UiProvider _uiProvider = Provider.of<UiProvider>(getContext(), listen: false);
    _uiProvider.setHomeView(
      view: view,
      notify: notify,
    );
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  void setHomeView({
    @required HomeScreenView view,
    @required bool notify,
  }){

    if (_view != view) {
      _previousView = _view;
      _view = view;
      blog('HomeScreenView : ($_previousView) ===> ($_view)');
      if (notify == true) {
        notifyListeners();
      }
    }

  }

  static void goBack() {
    final HomeScreenView _previous = UiProvider.proGetPreviousHomeView(listen: false);
    UiProvider.proSetHomeView(view: _previous, notify: true);
  }

  // -----------------------------------------------------------------------------
}
// -----------------------------------------------------------------------------
