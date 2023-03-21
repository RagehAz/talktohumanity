part of authing;

class FacebookAuthing {

  const FacebookAuthing();

  // -----------------------------------------------------------------------------

  /// FACEBOOK AUTHENTICATION

  // --------------------
  /// PLAN : FIX ME
  /*
  static Future<AuthModel> signInByFacebook({
    @required BuildContext context,
    @required ZoneModel currentZone,
  }) async {
    /*
    // steps ----------
    /// facebook sign in to get firebase user to check if it has a userModel or to
    /// create a new one
    ///
    /// X1 - try get firebase user or return error
    ///   xx - try catch return google auth on WEB & ANDROID-IOS
    ///       B - get [accessToken]
    ///       C - Create [credential] from the [access token]
    ///       D - get [user credential] by [credential]
    ///       E - get firebase [user] from [user credential]
    ///
    /// X2 - process firebase user to return UserModel or error
    ///   xx - return error : if auth fails
    ///   xx - return firebase user : if auth succeeds
    ///      E - get Or Create UserModel From User
    // ----------
    AuthModel _authModel = const AuthModel();
    LoginResult _facebookLoginResult;
    UserCredential _userCredential;
    String _authError;
    FacebookAuthCredential _facebookAuthCredential;
    /// X1 - try get firebase user or return error
    // -------------------------------------------------------
    /// xx - try catch return facebook auth
    final bool _authSucceeds = await tryCatchAndReturnBool(
        invoker: 'signInByFacebook',
        functions: () async {

          final FirebaseAuth _firebaseAuth = FirebaseAuth?.instance;

          /// get [accessToken]
          _facebookLoginResult = await FacebookAuth.instance.login();
          final AccessToken _accessToken = _facebookLoginResult?.accessToken;

          /// IF COULD LOGIN BY FACEBOOK
          if (_accessToken != null) {

            /// C - Create [credential] from the [access token]
            _facebookAuthCredential = FacebookAuthProvider.credential(_accessToken.token);

            /// D - get [user credential] by [credential]
            _userCredential = await _firebaseAuth.signInWithCredential(_facebookAuthCredential);

          }

          /// IF COULD NOT LOGIN AND ACCESS TOKEN == NULL
          else {
            blog('Facebook Access token is null');
          }

        },

        onError: (String error) async {
          _authError = error;
        }
    );
    // -----------------------------
    _authModel = AuthModel.create(
      authSucceeds: _authSucceeds,
      authError: _authError,
      userCredential: _userCredential,
      facebookLoginResult: _facebookLoginResult,
      facebookAuthCredential: _facebookAuthCredential,

    );
    // -----------------------------
    /// xx - return firebase user : if auth succeeds
    if (_authModel.authSucceeds == true) {

      /// E - get Or Create UserModel From User
      final UserModel _userModel = await UserFireOps.getOrCreateUserModelFromUser(
        context: context,
        zone: currentZone,
        user: _userCredential.user,
        authBy: AuthType.facebook,
      );

      _authModel = _authModel.copyWith(
        userModel: _userModel,
      );

    }

    return _authModel;

     */
  }
   */
  // -----------------------------------------------------------------------------
}
