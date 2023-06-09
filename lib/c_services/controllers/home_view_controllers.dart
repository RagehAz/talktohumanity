import 'package:talktohumanity/b_views/a_screens/b_0_home_screen.dart';
import 'package:talktohumanity/c_services/providers/ui_provider.dart';
import 'package:super_fire/super_fire.dart';

void onTalkToHumanityButtonTap(){

  final String _userID = Authing.getUserID();
  final SignInMethod _signInMethod = Authing.getCurrentSignInMethod();
  final bool _isAnonymous = _signInMethod == null || _signInMethod == SignInMethod.anonymous;

  if (_userID == null || _isAnonymous == true){
    UiProvider.proSetHomeView(view: HomeScreenView.auth, notify: true);
  }

  else {
    UiProvider.proSetHomeView(view: HomeScreenView.creator, notify: true);
  }

}

void onBackToPostsView(){
    UiProvider.proSetHomeView(view: HomeScreenView.posts, notify: true);
}
