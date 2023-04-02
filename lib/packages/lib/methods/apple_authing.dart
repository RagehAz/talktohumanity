part of authing;

/*

- IOS 13+
- add Apple as auth provider in firebase console
- add "Sign in with Apple" in xCode/Runner/Signing & Capabilities/+ Capability/Sign in with Apple
- make sure it is addedunder all - debug - release - profile

 */

class AppleAuthing {
  // -----------------------------------------------------------------------------

  const AppleAuthing();

  // -----------------------------------------------------------------------------

  /// APPLE AUTHENTICATION

  // --------------------
  /// WORKS ON IOS DEVICE
  static Future<void> signInByApple({
    @required BuildContext context,
  }) async {


    blog('starting apple auth ops');

    final AuthorizationCredentialAppleID credential = await SignInWithApple.getAppleIDCredential(
      scopes: [
        AppleIDAuthorizationScopes.email,
        AppleIDAuthorizationScopes.fullName,
      ],
      // state: ,
      // nonce: ,
      // webAuthenticationOptions: ,
    );

    Authing.blogAppleCred(credential);

  }

  // -----------------------------------------------------------------------------
}
