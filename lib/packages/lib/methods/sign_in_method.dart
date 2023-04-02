part of authing;

enum SignInMethod {
  anonymous,
  email,
  google,
  facebook,
  apple,
}

class SignMethod {
  // -----------------------------------------------------------------------------

  const SignMethod();

  // -----------------------------------------------------------------------------

  /// SIGN IN METHOD

  // --------------------
  /// TESTED : WORKS PERFECT
  static String cipherSignInMethod(SignInMethod method){
    switch (method){

      case SignInMethod.google: return 'google.com'; break;
      case SignInMethod.facebook: return 'facebook.com'; break;
      case SignInMethod.anonymous: return 'anonymous'; break;
      case SignInMethod.apple: return 'apple.com'; break;
      default: return null;
    }
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static SignInMethod decipherSignInMethod(String providerID){

    switch (providerID){

      case 'google.com': return SignInMethod.google; break;
      case 'facebook.com': return SignInMethod.facebook; break;
      case 'anonymous': return SignInMethod.anonymous; break;
      case 'apple.com': return SignInMethod.apple; break;
      default: return Authing.getUserID() == null ? null : SignInMethod.anonymous;
    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static SignInMethod getSignInMethod(){
    SignInMethod _output;

    final User _user = Authing.getFirebaseUser();

    if (_user != null){

      final List<UserInfo> providerData = _user.providerData;

      if (Mapper.checkCanLoopList(providerData) == true){
        final UserInfo _info = providerData.first;
        final String providerID = _info?.providerId;
        _output = decipherSignInMethod(providerID);
      }

    }

    return _output;
  }
  // -----------------------------------------------------------------------------
}
