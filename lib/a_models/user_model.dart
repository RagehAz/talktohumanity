import 'package:devicer/devicer.dart';
import 'package:flutter/material.dart';
import 'package:space_time/space_time.dart';
import 'package:talktohumanity/c_services/protocols/zoning_protocols.dart';
import 'package:authing/authing.dart';
/// => TAMAM
@immutable
class UserModel {
  // --------------------------------------------------------------------------
  const UserModel({
    @required this.id,
    @required this.name,
    @required this.email,
    @required this.signinMethod,
    @required this.zone,
    @required this.deviceID,
    @required this.image,
    @required this.createdAt,
  });
  // --------------------
  final String id;
  final String name;
  final String email;
  final SignInMethod signinMethod;
  final String zone;
  final String deviceID;
  final String image;
  final DateTime createdAt;
  // --------------------------------------------------------------------------

  /// CLONING

  // --------------------
  /// TESTED : WORKS PERFECT
  UserModel copyWith({
    String id,
    String name,
    String email,
    SignInMethod signinMethod,
    String zone,
    String deviceID,
    String image,
    DateTime createdAt,
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      signinMethod: signinMethod ?? this.signinMethod,
      zone: zone ?? this.zone,
      deviceID: deviceID ?? this.deviceID,
      image: image ?? this.image,
      createdAt: createdAt ?? this.createdAt,
    );
  }
  // --------------------------------------------------------------------------

  /// CYPHER

  // --------------------
  /// TESTED : WORKS PERFECT
  Map<String, dynamic> toMap({
    @required bool toJSON,
  }){
    return {
      'id': id,
      'name': name,
      'email': email,
      'signinMethod': AuthModel.cipherSignInMethod(signinMethod),
      'zone': zone,
      'deviceID': deviceID,
      'image': image,
      'createdAt': Timers.cipherTime(time: createdAt, toJSON: toJSON),
    };
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static UserModel decipher({
    @required Map<String, dynamic> map,
    @required bool fromJSON,
  }){
    UserModel _output;

    if (map != null){

      _output = UserModel(
          id: map['id'],
          name: map['name'],
          email: map['email'],
          signinMethod: AuthModel.decipherSignInMethod(map['signinMethod']),
          zone: map['zone'],
          deviceID: map['deviceID'],
          image: map['image'],
          createdAt: Timers.decipherTime(time: map['createdAt'], fromJSON: fromJSON),
      );

    }

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// CREATION

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<UserModel> createUserModelFromAuthModel({
    @required AuthModel authModel,
    String imageOverride,
  }) async {
    UserModel _output;

    if (authModel != null){

    _output = UserModel(
      id: authModel.id,
      name: authModel.name,
      email: authModel.email,
      signinMethod: authModel.signInMethod,
      zone: await ZoningProtocols.getZoneByIPApi(),
      deviceID: await DeviceChecker.getDeviceID(),
      image: imageOverride ?? authModel.imageURL,
      createdAt: DateTime.now(),
    );

    }
    return _output;
  }
  // -----------------------------------------------------------------------------

  /// EQUALITY

  // --------------------
  /// TESTED : WORKS PERFECT
  static bool checkUsersAreIdentical({
    @required UserModel user1,
    @required UserModel user2,
  }){
    bool _identical = false;

    if (user1 == null && user2 == null){
      _identical = true;
    }

    else if (user1 != null && user2 != null){

      if (
          user1.id == user2.id &&
          user1.name == user2.name &&
          user1.email == user2.email &&
          user1.signinMethod == user2.signinMethod &&
          user1.zone == user2.zone &&
          user1.deviceID == user2.deviceID &&
          user1.image == user2.image &&
          Timers.checkTimesAreIdentical(accuracy: TimeAccuracy.millisecond, time1: user1.createdAt, time2: user2.createdAt)
      ){
        _identical = true;
      }

    }

    return _identical;
  }
  // -----------------------------------------------------------------------------

  /// OVERRIDES

  // --------------------
   @override
   String toString() => '''
   id : $id,
   name : $name,
   email : $email,
   signinMethod : $signinMethod,
   zone : $zone,
   deviceID : $deviceID,
   image : $image,
   createdAt : $createdAt,
   ''';
  // --------------------
  @override
  bool operator == (Object other){

    if (identical(this, other)) {
      return true;
    }

    bool _areIdentical = false;
    if (other is UserModel){
      _areIdentical = checkUsersAreIdentical(
        user1: this,
        user2: other,
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
      signinMethod.hashCode^
      zone.hashCode^
      deviceID.hashCode^
      image.hashCode^
      createdAt.hashCode;
  // -----------------------------------------------------------------------------
}
