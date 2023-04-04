import 'package:filers/filers.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mapper/mapper.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:talktohumanity/packages/lib/authing.dart';

@immutable
class AuthModel {
  // --------------------------------------------------------------------------
  const AuthModel({
    @required this.id,
    @required this.name,
    @required this.email,
    @required this.imageURL,
    @required this.signInMethod,
    @required this.data,
  });
  // --------------------------------------------------------------------------
  final String id;
  final String name;
  final String email;
  final String imageURL;
  final SignInMethod signInMethod;
  final Map<String, dynamic> data;
  // --------------------------------------------------------------------------

  /// CLONING

  // --------------------
  /// TESTED : WORKS PERFECT
  AuthModel copyWith({
    String id,
    String name,
    String email,
    String imageURL,
    SignInMethod signInMethod,
    Map<String, dynamic> data,
  }){
    return AuthModel(
        id: id ?? this.id,
        name: name ?? this.name,
        email: email ?? this.email,
        imageURL: imageURL ?? this.imageURL,
        signInMethod: signInMethod ?? this.signInMethod,
        data: data ?? this.data,
    );
  }
  // --------------------------------------------------------------------------

  /// CYPHER

  // --------------------
  ///
  Map<String, dynamic> toMap(){
    return {
      'id': id,
      'name': name,
      'email': email,
      'imageURL': imageURL,
      'signInMethod': cipherSignInMethod(signInMethod),
      'data': data,
    };
  }
  // --------------------
  ///
  static AuthModel decipher({
    @required Map<String, dynamic> map
  }){
    AuthModel _output;

    if (map != null){

      _output = AuthModel(
          id: map['id'],
          name: map['name'],
          email: map['email'],
          imageURL: map['imageURL'],
          signInMethod: decipherSignInMethod(map['signInMethod']),
          data: map['data'],
      );

    }

    return _output;
  }
  // --------------------------------------------------------------------------

  /// GETTERS

  // --------------------
  ///
  static AuthModel getAuthModelFromUserCredential({
    @required UserCredential cred,
    Map<String, dynamic> addData,
  }){
    AuthModel _output;

    if (cred != null){

      _output = AuthModel(
        id: cred.user?.uid,
        name: cred.user?.displayName,
        email: cred.user?.email,
        imageURL: Authing.getUserImageURLFromUserCredential(cred),
        signInMethod: Authing.getSignInMethodFromUser(user: cred.user),
        data: _createAuthModelDataMap(
          cred: cred,
          addData: addData,
        ),
      );

    }

    return _output;
  }
  // --------------------
  ///
  static Map<String, dynamic> _createAuthModelDataMap({
    @required UserCredential cred,
    @required Map<String, dynamic> addData,
  }) {

    Map<String, dynamic> _map = {
      'credential.user.emailVerified': cred.user?.emailVerified,
      'credential.user.isAnonymous': cred.user?.isAnonymous,
      'credential.user.metadata': cred.user?.metadata?.toString(),
      'credential.user.phoneNumber': cred.user?.phoneNumber,
      'credential.user.photoURL': cred.user?.photoURL,
      'credential.user.providerData': cred.user?.providerData?.map((e) => e.toString()),
      'credential.user.refreshToken': cred.user?.refreshToken,
      'credential.user.tenantId': cred.user?.tenantId,
      'credential.user.multiFactor': cred.user?.multiFactor?.toString(),
      'credential.credential.accessToken': cred.credential?.accessToken,
      'credential.credential.providerId': cred.credential?.providerId,
      'credential.credential.signInMethod': cred.credential?.signInMethod,
      'credential.credential.token': cred.credential?.token,
      'credential.additionalUserInfo.providerId': cred.additionalUserInfo?.providerId,
      'credential.additionalUserInfo.isNewUser': cred.additionalUserInfo?.isNewUser,
      'credential.additionalUserInfo.profile': Mapper.cleanNullPairs(map: cred.additionalUserInfo?.profile),
      'credential.additionalUserInfo.username': cred.additionalUserInfo?.username,
    };

    _map = Mapper.insertMapInMap(
      baseMap: _map,
      insert: addData,
      replaceDuplicateKeys: false,
    );

    return Mapper.cleanNullPairs(
      map: _map,
    );
  }
  // --------------------
  ///
  static AuthModel getAuthModelFromAppleCred({
    @required AuthorizationCredentialAppleID cred,
  }) {
    AuthModel _output;

    if (cred != null){

      _output = AuthModel(
        id: cred.userIdentifier,
        name: cred.givenName,
        email: cred.email,
        imageURL: null,
        signInMethod: SignInMethod.apple,
        data: {
          'authorizationCredentialAppleID.authorizationCode': cred.authorizationCode,
          'authorizationCredentialAppleID.familyName': cred.familyName,
          'authorizationCredentialAppleID.identityToken': cred.identityToken,
          'authorizationCredentialAppleID.state': cred.state,
        },
      );

    }

    return _output;
  }
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
      case SignInMethod.email: return 'email'; break;
      // case SignInMethod.phone: return 'phone'; break;
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
      case 'password': return SignInMethod.email; break;
      // case 'phone': return SignInMethod.phone; break;
      default: return Authing.getUserID() == null ? null : SignInMethod.anonymous;
    }

  }
  // --------------------------------------------------------------------------

  /// BLOGGING

  // --------------------
  /// TESTED : WORKS PERFECT
  static void blogAuthModel({
    @required AuthModel authModel
  }){

    if (authModel == null){
      blog('blogAuthModel : model is null');
    }

    else {
      blog('blogAuthModel: ---------------> START');
      blog('id : ${authModel.id}');
      blog('name : ${authModel.name}');
      blog('email : ${authModel.email}');
      blog('imageURL : ${authModel.imageURL}');
      blog('signInMethod : ${authModel.signInMethod}');
      Mapper.blogMap(authModel.data);
      blog('blogAuthModel: ---------------> END');
    }

  }
  // -----------------------------------------------------------------------------

  /// EQUALITY

  // --------------------
  /// TESTED : WORKS PERFECT
  static bool checkAuthModelsAreIdentical({
    @required AuthModel auth1,
    @required AuthModel auth2,
  }){
    bool _identical = false;

    if (auth1 == null && auth2 == null){
      _identical = true;
    }

    else if (auth1 != null && auth2 != null){

      if (
      auth1.id == auth2.id &&
      auth1.name == auth2.name &&
      auth1.email == auth2.email &&
      auth1.imageURL == auth2.imageURL &&
      auth1.signInMethod == auth2.signInMethod &&
      Mapper.checkMapsAreIdentical(map1: auth1.data, map2: auth2.data)
      ){
        _identical = true;
      }

    }

    return _identical;
  }
  // -----------------------------------------------------------------------------

  /// OVERRIDES

  // --------------------
  /*
   @override
   String toString() => 'MapModel(key: $key, value: ${value.toString()})';
   */
  // --------------------
  @override
  bool operator == (Object other){

    if (identical(this, other)) {
      return true;
    }

    bool _areIdentical = false;
    if (other is AuthModel){
      _areIdentical = checkAuthModelsAreIdentical(
        auth1: this,
        auth2: other,
      );
    }

    return _areIdentical;
  }
  // --------------------
  @override
  int get hashCode =>
      id.hashCode^
      name.hashCode^
      email.hashCode^
      imageURL.hashCode^
      signInMethod.hashCode^
      data.hashCode;
  // -----------------------------------------------------------------------------
}
