part of authing;

class GoogleAuthing {
  // --------------------
  GoogleAuthing.singleton();
  static final GoogleAuthing _singleton = GoogleAuthing.singleton();
  static GoogleAuthing get instance => _singleton;
  // -----------------------------------------------------------------------------

  /// AUDIO PLAYER SINGLETON

  // --------------------
  GoogleSignIn _googleSignIn;
  GoogleSignIn get googleSignIn => _googleSignIn ??= GoogleSignIn();
  static GoogleSignIn getGoogleSignIn() => GoogleAuthing.instance.googleSignIn;
  // -----------------------------------------------------------------------------

  /// SIGN IN

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<AuthClient> scopedSignIn({
    List<String> scopes,
    // String clientID,
  }) async {
    AuthClient client;

    final GoogleSignIn _googleSignIn = GoogleSignIn(
      scopes: scopes,
      // clientId: clientID,
      // forceCodeForRefreshToken: ,
      // hostedDomain: ,
      // serverClientId: ,
      // signInOption: ,
    );

    await tryAndCatch(
      invoker: 'googleSignIn',
        functions: () async {

          await _googleSignIn.signIn();

          client = await _googleSignIn.authenticatedClient();

        },
    );

    return client;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<UserCredential> emailSignIn({
    Function(String error) onError,
  }) async {
    // --------------------
    UserCredential _userCredential;
    // --------------------
    await tryAndCatch(
        invoker: 'signInByGoogle',
        functions: () async {

          await getGoogleSignIn().signOut();

          final FirebaseAuth _firebaseAuth = Authing.getFirebaseAuth();

          /// if on web
          if (kIsWeb) {

            /// get [auth provider]
            final GoogleAuthProvider _googleAuthProvider = GoogleAuthProvider();

            /// get [user credential] from [auth provider]
            _userCredential = await _firebaseAuth.signInWithPopup(_googleAuthProvider);

          }

          /// if kIsWeb != true : so its android or ios
          else {

            /// get [google sign in account]
            final GoogleSignInAccount _googleSignInAccount = await getGoogleSignIn().signIn();

            if (_googleSignInAccount != null) {

              /// get [google sign in auth] from [google sign in account]
              final GoogleSignInAuthentication _googleSignInAuthentication = await
              _googleSignInAccount.authentication;

              /// get [auth credential] from [google sign in auth]
              final AuthCredential _authCredential = GoogleAuthProvider.credential(
                accessToken: _googleSignInAuthentication.accessToken,
                idToken: _googleSignInAuthentication.idToken,
              );

              /// C - get [user credential] from [auth credential]
              _userCredential = await _firebaseAuth.signInWithCredential(_authCredential);

            }

          }

        },
        onError: onError,
    );
    // --------------------
    return _userCredential;
  }
  // -----------------------------------------------------------------------------

  /// SIGN OUT

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<bool> signOut({
    Function(String error) onError,
  }) async {
    bool _isSignedIn = true;
    // blog('googleSignOutOps : currentUser was : ${googleSignIn.currentUser}');

    await tryAndCatch(
      invoker: 'googleSignOutOps',
      functions: () async {
        if (kIsWeb == false) {
          await getGoogleSignIn().signOut();
        }

        await Authing.getFirebaseAuth().signOut();

        _isSignedIn = false;
      },
      onError: onError,
    );

    // blog('googleSignOutOps : currentUser is : ${googleSignIn.currentUser}');
    return _isSignedIn;
  }
  // -----------------------------------------------------------------------------
}
