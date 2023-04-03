library authing;
// -----------------------------------------------------------------------------
import 'package:extension_google_sign_in_as_googleapis_auth/extension_google_sign_in_as_googleapis_auth.dart';
import 'package:filers/filers.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart' as fireUI;
import 'package:firebase_ui_oauth_apple/firebase_ui_oauth_apple.dart';
import 'package:firebase_ui_oauth_facebook/firebase_ui_oauth_facebook.dart';
import 'package:firebase_ui_oauth_google/firebase_ui_oauth_google.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:googleapis_auth/googleapis_auth.dart'; // as gapis;
import 'package:mapper/mapper.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:stringer/stringer.dart';
import 'package:talktohumanity/packages/lib/models/social_keys.dart';
// -----------------------------------------------------------------------------
part 'methods/apple_authing.dart';
part 'methods/auth_error.dart';
part 'methods/authing.dart';
part 'methods/email_authing.dart';
part 'methods/facebook_authing.dart';
part 'methods/google_authing.dart';
part 'methods/sign_in_method.dart';
// -----------------------------------------------------------------------------
