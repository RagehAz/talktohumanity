part of authing;

class AuthError {
  // -----------------------------------------------------------------------------

  const AuthError();

  // -----------------------------------------------------------------------------
  static const Map<String, dynamic> _authErrors = {
    // There is no user record corresponding to this identifier. The user may have been deleted.',
    '[firebase_auth/user-not-found]': 'E-mail is not found',
    // A network error (such as timeout, interrupted connection or unreachable host) has occurred.',
    '[firebase_auth/network-request-failed]': 'No internet connection',
    // The email address is badly formatted.',
    '[firebase_auth/invalid-email]': 'E-mail is wrong',
    // The password is invalid or the user does not have a password.'
    '[firebase_auth/wrong-password]': 'Password is wrong',
    // We have blocked all requests from this device due to unusual activity. Try again later.',
    '[firebase_auth/too-many-requests]': 'Too many failed attempts, please try again later',
    // Google sign in failed
    'PlatformException(sign_in_failed, com.google.android.gms.common.api.ApiException: 10: , null, null)' : 'Could not sign in by google',
    // The email address is already in use by another account.',
    '[firebase_auth/email-already-in-use]': 'This email is already registered',
    // The service is currently unavailable. This is a most likely a transient condition and may be corrected by retrying with a backoff.
    '[cloud_firestore/unavailable]': 'Network is unresponsive',
    //
    '[firebase_auth/account-exists-with-different-credential]': 'This email is already used by different Sign-In method',
    //

  };
  // -----------------------------------------------------------------------------
  ///
  static String getErrorReply({
    @required String error,
  }) {
    String _output = 'Something went wrong !';

    if (error != null){

      for (final String key in _authErrors.keys.toList()){

        final bool _errorIsKnown = TextCheck.stringContainsSubString(
          string: error,
          subString: key,
        );

        if (_errorIsKnown == true){
          _output = _authErrors[key];
        }
        break;

      }

    }

    return _output;
  }
  // --------------------
  ///
  static String getErrorKey({
    @required String error,
  }) {
    String _output;

    if (error != null){

      for (final String key in _authErrors.keys.toList()){

        final bool _errorIsKnown = TextCheck.stringContainsSubString(
          string: error,
          subString: key,
        );

        if (_errorIsKnown == true){
          _output = key;
        }

        break;

      }

    }

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// CHECKERS

  // --------------------
  ///
  static bool checkIsUserNotFound(String error){
    bool _output;

    if (TextCheck.isEmpty(error) == false){

      _output = TextCheck.stringContainsSubString(
          string: error,
          subString: '[firebase_auth/user-not-found]',
        );

    }

    return _output;
  }
  // -----------------------------------------------------------------------------
}
