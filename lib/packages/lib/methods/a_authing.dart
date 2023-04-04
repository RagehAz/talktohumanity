part of authing;

/*

APPLE WEB         : ignore
APPLE IOS         : DONE
APPLE ANDROID     : ignore

GOOGLE WEB        : DONE
GOOGLE IOS        : DONE
GOOGLE ANDROID    : DONE

FACEBOOK WEB      : DONE
FACEBOOK IOS      : DONE
FACEBOOK ANDROID  : DONE

ANONYMOUS         : DONE

EMAIL WEB         : DONE
EMAIL IOS         : DONE
EMAIL ANDROID     : DONE

 */

class Authing {
  // -----------------------------------------------------------------------------

  /// AuthFireOps SINGLETON

  // --------------------
  Authing.singleton();
  static final Authing _singleton = Authing.singleton();
  static Authing get instance => _singleton;
  // -----------------------------------------------------------------------------

  /// FIREBASE AUTH

  // --------------------
  /// FIREBASE AUTH SINGLETON
  FirebaseAuth _auth;
  FirebaseAuth get auth => _auth ??= FirebaseAuth.instance;
  static FirebaseAuth getFirebaseAuth() => Authing.instance.auth;
  // -----------------------------------------------------------------------------

  /// INITIALIZE SOCIAL AUTHING

  // --------------------
  /// TESTED : WORKS PERFECT
  static void initializeSocialAuthing({
    @required SocialKeys socialKeys,
  }) {

    if (socialKeys != null) {
      fireUI.FirebaseUIAuth.configureProviders([
        if (socialKeys.supportEmail == true) fireUI.EmailAuthProvider(),
        if (socialKeys.googleClientID != null)
          GoogleProvider(
            clientId: socialKeys.googleClientID,
            // redirectUri: ,
            // scopes: ,
            // iOSPreferPlist: ,
          ),
        if (socialKeys.facebookAppID != null)
          FacebookProvider(
            clientId: socialKeys.facebookAppID,
            // redirectUri: '',
          ),
        if (socialKeys.supportApple == true)
          AppleProvider(
              // scopes: ,
              ),
      ]);
    }

  }
  // -----------------------------------------------------------------------------

  /// CREATE ANONYMOUS AUTH

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<AuthModel> anonymousSignin({
    Function(String error) onError,
  }) async {
    AuthModel _output;

    await tryAndCatch(
      invoker: 'anonymousSignin',
      onError: onError,
      functions: () async {

        final UserCredential _userCredential = await getFirebaseAuth().signInAnonymously();

        _output = AuthModel.getAuthModelFromUserCredential(
            cred: _userCredential,
        );

      },
    );

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// SIGN OUT

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> signOut({
    Function(String error) onError,
  }) async {

    final SignInMethod signInMethod = getCurrentSignInMethod();

    // if (signInMethod != null) {

      if (signInMethod == SignInMethod.google) {
        await GoogleAuthing.signOut(
          onError: onError,
        );
      }

      else if (signInMethod == SignInMethod.facebook) {
        await FacebookAuthing.signOut(onError: onError);
      }

      // else if (signInMethod == SignInMethod.email){
      //
      // }
      // else if (signInMethod == SignInMethod.apple){
      //
      // }
      // else if (signInMethod == SignInMethod.anonymous){
      //
      // }
      // else {
      //
      // }

      await getFirebaseAuth().signOut();
    // }

  }
  // -----------------------------------------------------------------------------

  /// READ AUTH

  // --------------------
  /// TESTED : WORKS PERFECT
  static User getFirebaseUser() {
    return getFirebaseAuth()?.currentUser;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static String getUserID() {
    return getFirebaseUser()?.uid;
  }
  // -----------------------------------------------------------------------------

  /// DELETE FIREBASE USER

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<bool> deleteFirebaseUser({
    @required String userID,
    Function(String error) onError,
  }) async {

    blog('deleting firebase user');
    // String _error;

    final bool _success = await tryCatchAndReturnBool(
        invoker: 'deleteFirebaseUser',
        functions: () => getFirebaseAuth().currentUser?.delete(),
        onError: onError,
    );

    return _success;

    /*
      /// delete firebase user
  // Future<void> _deleteFirebaseUser({
  //   BuildContext context,
  //   String email,
  //   String password,
  // }) async {
  //
  //   try {
  //
  //     User user = _auth.currentUser;
  //
  //     AuthCredential credentials = EmailAuthProvider.credential(email: email, password: password);
  //
  //     blog(user);
  //
  //     UserCredential result = await user.reauthenticateWithCredential(credentials);
  //
  //     await result.user.delete();
  //
  //     return true;
  //
  //   } catch (error) {
  //
  //     blog(error.toString());
  //
  //     await superDialog(
  //       context: context,
  //       title: 'Could not delete account',
  //       body: error,
  //       boolDialog: false,
  //     );
  //
  //     return null;
  //   }
  // }
  // -----------------------------------------------------------------------------
     */
  }
  // -----------------------------------------------------------------------------

  /// USER IMAGE

  // --------------------
  /// TESTED : WORKS PERFECT
  static String getUserImageURLFromUserCredential(UserCredential cred){
    String _output;

    if (cred != null){

      final SignInMethod signInMethod = Authing.getCurrentSignInMethod();

      if (signInMethod == SignInMethod.google){
        _output = cred.user?.photoURL;
      }
      else if (signInMethod == SignInMethod.facebook){
        _output = FacebookAuthing.getUserFacebookImageURLFromUserCredential(cred);
      }
      else if (signInMethod == SignInMethod.apple){
        /// TASK : DO ME
      }
      else {
        _output = cred.user?.photoURL;
      }

    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static SignInMethod getCurrentSignInMethod(){
    return getSignInMethodFromUser(user: Authing.getFirebaseUser());
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static SignInMethod getSignInMethodFromUser({
    @required User user,
  }){
    SignInMethod _output;

    if (user != null){

      final List<UserInfo> providerData = user.providerData;

      if (Mapper.checkCanLoopList(providerData) == true){
        final UserInfo _info = providerData.first;
        final String providerID = _info?.providerId;
        _output = AuthModel.decipherSignInMethod(providerID);
      }

    }

    return _output;
  }
  // -----------------------------------------------------------------------------

}

/*
FACEBOOK USER :---->
credential.user.displayName : Rageh Azzazi
credential.user.email : rageh.az@gmail.com
credential.user.emailVerified : false
credential.user.isAnonymous : false
credential.user.metadata : UserMetadata(creationTime: 2023-03-24 22:22:00.285Z, lastSignInTime: 2023-03-24 22:22:00.285Z)
credential.user.phoneNumber : null
credential.user.photoURL : https://graph.facebook.com/2985820151714340/picture
credential.user.providerData : [UserInfo(displayName: Rageh Azzazi, email: rageh.az@gmail.com, phoneNumber: null, photoURL: https://graph.facebook.com/2985820151714340/picture, providerId: facebook.com, uid: 2985820151714340)]
credential.user.refreshToken :
credential.user.tenantId : null
credential.user.uid : i89sMJuxXoQFdZdzFe0HJp36Bd92
credential.user.multiFactor : Instance of 'MultiFactor'
 */

/*
GOOGLE USER :---->
credential.user.displayName : Rageh Al-Azzazy
credential.user.email : rageh.az@gmail.com
credential.user.emailVerified : true
credential.user.isAnonymous : false
credential.user.metadata : UserMetadata(creationTime: 2023-03-24 23:17:00.440Z, lastSignInTime: 2023-03-24 23:17:00.441Z)
credential.user.phoneNumber : null
credential.user.photoURL : https://lh3.googleusercontent.com/a/AGNmyxYMDcWvkFpnuMF4-HKsofKmQEGTXUFOC6zxv7mY-w=s96-c
credential.user.providerData : [UserInfo(displayName: Rageh Al-Azzazy, email: rageh.az@gmail.com, phoneNumber: null, photoURL: https://lh3.googleusercontent.com/a/AGNmyxYMDcWvkFpnuMF4-HKsofKmQEGTXUFOC6zxv7mY-w=s96-c, providerId: google.com, uid: 112722554956257049626)]
credential.user.refreshToken :
credential.user.tenantId : null
credential.user.uid : ECuHEm33dmMKYI4BCedryds6D2o2
credential.user.multiFactor : Instance of 'MultiFactor'
 */
