part of authing;

/*

APPLE WEB         : x
APPLE IOS         : ...
APPLE ANDROID     : x

GOOGLE WEB        : DONE
GOOGLE IOS        : ...
GOOGLE ANDROID    : DONE

FACEBOOK WEB      : DONE
FACEBOOK IOS      : ...
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

  /// CREATE ANONYMOUS AUTH

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<UserCredential> anonymousSignin({
    Function(String error) onError,
  }) async {
    UserCredential _userCredential;

    await tryAndCatch(
      invoker: 'anonymousSignin',
      onError: onError,
      functions: () async {
        _userCredential = await getFirebaseAuth().signInAnonymously();
      },
    );

    return _userCredential;
  }
  // -----------------------------------------------------------------------------

  /// SIGN OUT

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> signOut({
    Function(String error) onError,
  }) async {

    final SignInMethod signInMethod = SignMethod.getSignInMethod();

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
  static String getUserImageURLFromCredential(UserCredential cred){
    String _output;

    if (cred != null){

      final SignInMethod signInMethod = SignMethod.getSignInMethod();

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
  // -----------------------------------------------------------------------------

  /// BLOGGING

  // --------------------
  /// TESTED : WORKS PERFECT
  static void blogUserCredential({
    @required UserCredential credential,
  }){

    if (credential == null){
      blog('blogUserCredential : USER CREDENTIAL IS NULL');
    }

    else {
      blog('USER CREDENTIAL :----> ');
      blog('credential.user.displayName : ${credential.user?.displayName}');
      blog('credential.user.email : ${credential.user?.email}');
      blog('credential.user.emailVerified : ${credential.user?.emailVerified}');
      blog('credential.user.isAnonymous : ${credential.user?.isAnonymous}');
      blog('credential.user.metadata : ${credential.user?.metadata}');
      blog('credential.user.phoneNumber : ${credential.user?.phoneNumber}');
      blog('credential.user.photoURL : ${credential.user?.photoURL}');
      blog('credential.user.providerData : ${credential.user?.providerData}');
      blog('credential.user.refreshToken : ${credential.user?.refreshToken}');
      blog('credential.user.tenantId : ${credential.user?.tenantId}');
      blog('credential.user.uid : ${credential.user?.uid}');
      blog('credential.user.multiFactor : ${credential.user?.multiFactor}');
      blog('CREDENTIAL :-');
      blog('credential.credential.accessToken : ${credential.credential?.accessToken}');
      blog('credential.credential.providerId : ${credential.credential?.providerId}');
      blog('credential.credential.signInMethod : ${credential.credential?.signInMethod}');
      blog('credential.credential.token : ${credential.credential?.token}');
      blog('ADDITIONAL USER INFO :-');
      blog('credential.additionalUserInfo.providerId : ${credential.additionalUserInfo?.providerId}');
      blog('credential.additionalUserInfo.isNewUser : ${credential.additionalUserInfo?.isNewUser}');
      blog('credential.additionalUserInfo.profile : ${credential.additionalUserInfo?.profile}');
      blog('credential.additionalUserInfo.username : ${credential.additionalUserInfo?.username}');
      blog('blogUserCredential : USER CREDENTIAL BLOG END <-----');
    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static void blogFirebaseUser({
    @required User user,
  }){

    if (user == null){
      blog('blogUserCredential : FIRE BASE USER IS NULL');
    }

    else {
      blog('FIRE BASE USER :----> ');
      blog('credential.user.displayName : ${user?.displayName}');
      blog('credential.user.email : ${user?.email}');
      blog('credential.user.emailVerified : ${user?.emailVerified}');
      blog('credential.user.isAnonymous : ${user?.isAnonymous}');
      blog('credential.user.metadata : ${user?.metadata}');
      blog('credential.user.phoneNumber : ${user?.phoneNumber}');
      blog('credential.user.photoURL : ${user?.photoURL}');
      blog('credential.user.providerData : ${user?.providerData}');
      blog('credential.user.refreshToken : ${user?.refreshToken}');
      blog('credential.user.tenantId : ${user?.tenantId}');
      blog('credential.user.uid : ${user?.uid}');
      blog('credential.user.multiFactor : ${user?.multiFactor}');
    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static void blogCurrentFirebaseUser(){

    final User _user = getFirebaseUser();

    if (_user == null){
      blog('blogCurrentFirebaseUser : user is null');
    }
    else {
      blogFirebaseUser(user: _user);
    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static void blogAuthCred(AuthCredential authCred){

    if (authCred == null){
      blog('blogAuthCred : AUTH CREDENTIAL IS NULL');
    }

    else {
      blog('AUTH CREDENTIAL :----> ');
      blog('authCred.signInMethod : ${authCred.signInMethod}');
      blog('authCred.providerId : ${authCred.providerId}');
      blog('authCred.accessToken : ${authCred.accessToken}');
      blog('authCred.token : ${authCred.token}');

    }

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
