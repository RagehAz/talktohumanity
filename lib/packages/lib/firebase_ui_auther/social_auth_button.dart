import 'package:filers/filers.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:firebase_ui_oauth_apple/firebase_ui_oauth_apple.dart';
import 'package:firebase_ui_oauth_facebook/firebase_ui_oauth_facebook.dart';
import 'package:firebase_ui_oauth_google/firebase_ui_oauth_google.dart';
import 'package:flutter/material.dart';
import 'package:super_box/super_box.dart';
import 'package:talktohumanity/packages/lib/authing.dart';
import 'package:talktohumanity/packages/lib/models/social_keys.dart';

/*
DOCUMENTATION
https://github.com/firebase/flutterfire/blob/master/packages/firebase_ui_auth/doc/providers/oauth.md#custom-screens
 */

class SocialAuthButton extends StatelessWidget {
  // --------------------------------------------------------------------------
  const SocialAuthButton({
    @required this.signInMethod,
    @required this.socialKeys,
    this.onUserCreated,
    this.inAuthCredLinked,
    this.onAuthCredReceived,
    this.onAuthFailed,
    this.onSignedIn,
    this.onDifferentSignInMethodsFound,
    Key key
  }) : super(key: key);
  // --------------------------------------------------------------------------
  final SignInMethod signInMethod;
  final SocialKeys socialKeys;
  final Function(UserCredential cred) onUserCreated;
  final Function(AuthCredential authCred) onAuthCredReceived;
  final Function(AuthCredential authCred) inAuthCredLinked;
  final Function(String error) onAuthFailed;
  final Function(User user) onSignedIn;
  final Function(AuthCredential authCred, String email, List<String> methods) onDifferentSignInMethodsFound;
  // --------------------------------------------------------------------------
  dynamic _getProvider(SignInMethod signInMethod) {
    switch (signInMethod) {

      case SignInMethod.google:
        return GoogleProvider(
          clientId: socialKeys.googleClientID,
          // redirectUri: ,
          // scopes: ,
          // iOSPreferPlist: ,
        );
        break;

      case SignInMethod.facebook:
        return FacebookProvider(
          clientId: socialKeys.facebookAppID,
          // redirectUri: '',
        );
        break;

      case SignInMethod.apple:
        return AppleProvider(
          // scopes: ,
        );
        break;

      case SignInMethod.anonymous:
        return null;
        break;

      case SignInMethod.email:
        return null;
        break;
    }
  }
  // --------------------
  bool _listen (AuthState oldState, AuthState newState, OAuthController ctrl){

    /// UN-INITIALIZED
    if (newState is Uninitialized){
      blog('SocialAuthButton : is Uninitialized');
    }

    /// SIGNING IN
    else if (newState is SigningIn){
      blog('SocialAuthButton : is signing in');
    }

    /// AUTH CRED RECEIVED
    else if (newState is CredentialReceived){
      if (onAuthCredReceived != null){
        final CredentialReceived cred = newState;
        onAuthCredReceived(cred.credential);
      }
      blog('SocialAuthButton : is CredentialReceived');
    }

    /// AUTH CRED LINKED
    else if (newState is CredentialLinked){
      if (inAuthCredLinked != null){
        final CredentialLinked cred = newState;
        inAuthCredLinked(cred.credential);
      }
    }

    /// AUTH FAILED
    else if (newState is AuthFailed){
      if (onAuthFailed != null){
        final AuthFailed failure = newState;
        onAuthFailed(failure.exception.toString());
      }
    }

    /// SIGNED IN
    else if (newState is SignedIn) {
      if (onSignedIn != null){
        final SignedIn signedIn = newState;
        onSignedIn(signedIn.user);
      }
    }

    /// USER CREATED
    else if (newState is UserCreated){
      if (onUserCreated != null){
        final UserCreated userCreated = newState;
        onUserCreated(userCreated.credential);
      }
    }

    /// DIFFERENT SIGN IN METHOD FOUND
    else if (newState is DifferentSignInMethodsFound){
      if (onDifferentSignInMethodsFound != null){
        final DifferentSignInMethodsFound  dif = newState;
        onDifferentSignInMethodsFound(dif.credential, dif.email, dif.methods,);

      }
    }

    /// FETCHING PROVIDERS FOR EMAIL
    else if (newState is FetchingProvidersForEmail){
      blog('SocialAuthButton : is FetchingProvidersForEmail');
    }

    /// MFA REQUIRED
    else if (newState is MFARequired){
      blog('SocialAuthButton : is MFARequired');
    }

    else {

    }

    // ignore: avoid_returning_null
    return null;
  }
  // --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return AuthButtonBox(
        child: AuthStateListener<OAuthController>(
          listener: _listen,
          child: OAuthProviderButton(
            provider: _getProvider(signInMethod),
            auth: Authing.getFirebaseAuth(),
            action: AuthAction.signIn,
            variant: OAuthButtonVariant.icon,
          ),
        ),
      );

  }
  // --------------------------------------------------------------------------
}

class AuthButtonBox extends StatelessWidget {
  // --------------------------------------------------------------------------
  const AuthButtonBox({
    this.width = 300,
    this.child,
    Key key
  }) : super(key: key);
  // --------------------
  final double width;
  final Widget child;
  // --------------------
  static const double height  = 50; /// STANDARD DO NOT CHANGE
  // --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return Stack(
      children: <Widget>[

        SizedBox(
          width: height+10,//width,
          height: height,
          child: child,
        ),

        const IgnorePointer(
          child: SuperBox(
            width: height+10,//width,
            height: height,
            // color: Colorz.bloodTest,
            margins: EdgeInsets.symmetric(vertical: 5),
            corners: 19 / 3, /// mimics the corners of sign in buttons, do not change this
          ),
        ),

      ],
    );


  }
  // --------------------------------------------------------------------------
}
