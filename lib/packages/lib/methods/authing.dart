part of authing;

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
  static Future<UserCredential> anonymousSignin() async {
    UserCredential _userCredential;

    await tryAndCatch(
        invoker: 'anonymousSignin',
        functions: () async {
          _userCredential = await getFirebaseAuth().signInAnonymously();
        }
        );

    return _userCredential;
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
      blog('FIRE BASE USER :----> ');
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
      blog('blogUserCredential : USER CREDENTIAL IS NULL');
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
  // -----------------------------------------------------------------------------
}
