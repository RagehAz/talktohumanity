import 'package:talktohumanity/b_views/a_screens/b_0_home_screen.dart';
import 'package:talktohumanity/c_services/providers/ui_provider.dart';
import 'package:authing/authing.dart';

void onTalkToHumanityButtonTap(){

  final String _userID = Authing.getUserID();

  if (_userID == null){
    UiProvider.proSetHomeView(view: HomeScreenView.auth, notify: true);
  }

  else {
    UiProvider.proSetHomeView(view: HomeScreenView.creator, notify: true);
  }

}

void onBackToPostsView(){
    UiProvider.proSetHomeView(view: HomeScreenView.posts, notify: true);
}
