
class SocialKeys{

  const SocialKeys({
    this.facebookAppID,
    this.googleClientID,
    this.supportApple = false,
    this.supportEmail = false,
  });

  /// FROM FIREBASE CONSOLE - AUTH - GOOGLE - EDIT CONFIG
  final String googleClientID;
  final String facebookAppID;
  final bool supportApple;
  final bool supportEmail;

}
