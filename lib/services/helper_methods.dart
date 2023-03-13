import 'package:flutter/material.dart';
import 'package:talktohumanity/main.dart';
// -----------------------------------------------------------------------------

/// CONTEXT

// --------------------
BuildContext getContext(){
  return AppStarter.navigatorKey.currentContext;
}
// --------------------
String getRoute(BuildContext context){
  return ModalRoute.of(context)?.settings?.name;
}
// -----------------------------------------------------------------------------
