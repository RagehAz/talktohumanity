part of authing;

/*

/// SETUP ON ANDROID

1 - open new app facebook developer account
2 - start doing Android
3 - skip download the facebook SDK
4 - assure u r using mavenCentral() under buildscript and allprojects in android/build.gradle
5 - put [ implementation 'com.facebook.android:facebook-android-sdk:latest.release' ] in
dependencies in  android/app/build.gradle,, ref : TalkToHumanity // USED_FOR_FACEBOOK_AUTH
6 - add package name com.example.example and com.example.example.MainActivity in fc dashboard
sequence
7 - get your key hashes and put in in dashboard sequence
  7a - download opensssl 64 from https://code.google.com/archive/p/openssl-for-windows/downloads
  7b - extract openssl in C:\Users\rageh\openssl
  7c - get android debugkey
    7c1 - cd android "from project terminal" to run below line
    7c2 - run this : D:\projects\bldrs\talktohumanity\android> .\gradlew signingreport
    7c3 - make sure that C:\Users\rageh\.android\debug.keystore is correct path for debugKeystore
  7d - run the below command in command prompt cmd
    7d1 - keytool -exportcert -alias androiddebugkey -keystore "C:\Users\rageh\.android\debug.keystore" | "C:\Users\rageh\openssl\bin\openssl" sha1 -binary | "C:\Users\rageh\openssl\bin\openssl" base64
    7d2 - enter keystore password : 'same as my windows pin'
  7e - add the generated key Hash to 'Release Key Hashes' in facebook dashboard sequence
8 - and set single sign on to "yes" in facebook dashboard sequence
9 - create strings.xml in .../android/app/src/main/res/values/strings.xml
  9a - see TalkToHumanity for reference.
  9b - get AppID from facebookDev-dashboard-Settings-Basic
  9c - get facebook_client_token from facebookDev-dashboard-Settings-Advanced-Security-Client Token

10 - modify android/app/src/main/AndroidManifest.xml
  10a - add xmlns:tools="http://schemas.android.com/tools" line 3,, see TalkToHumanity
  10b - assure there are <uses-permission android:name="android.permission.INTERNET" /> line
  10c - add this line under the "uses-permission" <uses-permission android:name="com.google.android.gms.permission.AD_ID" tools:node="remove"/>
  10d - copy the last 16 lines in TalkToHumanity as is
11 - add flutter_facebook_auth package in pubspec.yaml
12 - add facebook sign-in method in authentication in firebase
  12a - get App ID & App secret from facebookDev-dashboard-Settings-Basic

 */

class FacebookAuthing {
  // --------------------
  FacebookAuthing.singleton();
  static final FacebookAuthing _singleton = FacebookAuthing.singleton();
  static FacebookAuthing get instance => _singleton;
  // -----------------------------------------------------------------------------

  /// AUDIO PLAYER SINGLETON

  // --------------------
  FacebookAuth _facebookAuth;
  FacebookAuth get facebookAuth => _facebookAuth ??= FacebookAuth.instance;
  static FacebookAuth getFacebookAuthInstance() => FacebookAuthing.instance.facebookAuth;
  // -----------------------------------------------------------------------------

  /// FACEBOOK AUTHENTICATION

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<UserCredential> signIn({
    Function(String error) onError,
    Function(LoginResult loginResult) passLoginResult,
    Function(FacebookAuthCredential facebookAuthCredential) passFacebookAuthCredential,
  }) async {
    UserCredential _userCredential;

    await tryAndCatch(
      invoker: 'signInByFacebook',
      onError: onError,
      functions: () async {

        final LoginResult _loginResult = await  getFacebookAuthInstance().login(
          // loginBehavior: ,
          // permissions: ['email'],
        );
        FacebookAuthCredential _facebookAuthCredential;

        if (_loginResult?.accessToken != null) {

          _facebookAuthCredential = FacebookAuthProvider.credential(_loginResult.accessToken.token);

          _userCredential = await Authing.getFirebaseAuth()
              .signInWithCredential(_facebookAuthCredential);
        }

        /// IF COULD NOT LOGIN AND ACCESS TOKEN == NULL
        else {
          blog('Facebook Access token is null');
        }

        /// PASS LOGIN RESULT
        if (passLoginResult != null) {
          passLoginResult(_loginResult);
        }

        /// PASS FACEBOOK AUTH CREDENTIAL
        if (passFacebookAuthCredential != null) {
          passFacebookAuthCredential(_facebookAuthCredential);
        }
      },
    );

    return _userCredential;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> signOut({
    Function(String error) onError,
  }) async {

    await tryAndCatch(
      invoker: 'Facebook signOut',
      onError: onError,
      functions: () async {

        await getFacebookAuthInstance().logOut();

        },
    );

  }
  // -----------------------------------------------------------------------------

  /// FACEBOOK USER DATA

  // --------------------
  /// TESTED : WORKS PERFECT
  static String getUserFacebookImageURLFromUserCredential(UserCredential cred){
    String _output;

    if (cred != null){

      if (cred.additionalUserInfo?.providerId == 'facebook.com'){
        final Map<String, dynamic> profileMap = cred.additionalUserInfo?.profile;
        if (profileMap != null){
          final picture = profileMap['picture'];
          if (picture != null){
            final data = picture['data'];
            if (data != null){
              _output = data['url'];
            }
          }
        }
      }


    }

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// BLOGGING

  // --------------------
  /// TESTED : WORKS PERFECT
  static void blogLoginResult({
    @required LoginResult loginResult,
    String invoker = 'blogLoginResult',
  }){

    if (loginResult == null){
      blog('blogLoginResult : the Facebook login result is null');
    }
    else {
      blog('blogLoginResult : the Facebook login result is :- ');
      blog('loginResult.status.name : ${loginResult.status?.name}');
      blog('loginResult.status.index : ${loginResult.status?.index}');
      blog('loginResult.accessToken.expires : ${loginResult.accessToken?.expires}');
      blog('loginResult.accessToken.lastRefresh : ${loginResult.accessToken?.lastRefresh}');
      blog('loginResult.accessToken.userId : ${loginResult.accessToken?.userId}');
      blog('loginResult.accessToken.token : ${loginResult.accessToken?.token}');
      blog('loginResult.accessToken.applicationId : ${loginResult.accessToken?.applicationId}');
      blog('loginResult.accessToken.graphDomain : ${loginResult.accessToken?.graphDomain}');
      blog('loginResult.accessToken.declinedPermissions : ${loginResult.accessToken?.declinedPermissions}');
      blog('loginResult.accessToken.grantedPermissions : ${loginResult.accessToken?.grantedPermissions}');
      blog('loginResult.accessToken.isExpired : ${loginResult.accessToken?.isExpired}');
      blog('loginResult.message : ${loginResult.message}');
    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static void blogFacebookAuthCredential({
    @required FacebookAuthCredential facebookAuthCredential,
    String invoker = 'blogFacebookAuthCredential',
  }){

    if (facebookAuthCredential == null){
      blog('blogLoginResult : the Facebook login result is null');
    }
    else {
      blog('blogLoginResult : the Facebook login result is :-');
      blog('facebookAuthCredential.idToken : ${facebookAuthCredential.idToken}');
      blog('facebookAuthCredential.rawNonce : ${facebookAuthCredential.rawNonce}');
      blog('facebookAuthCredential.secret : ${facebookAuthCredential.secret}');
      blog('facebookAuthCredential.token : ${facebookAuthCredential.token}');
      blog('facebookAuthCredential.accessToken : ${facebookAuthCredential.accessToken}');
      blog('facebookAuthCredential.providerId : ${facebookAuthCredential.providerId}');
      blog('facebookAuthCredential.signInMethod : ${facebookAuthCredential.signInMethod}');

    }

  }
  // -----------------------------------------------------------------------------
}
