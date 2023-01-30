class AccessToken {
  AccessToken({
    required this.type,
    required this.username,
    required this.applicationName,
    required this.clientId,
    required this.tokenType,
    required this.accessToken,
    required this.expiresIn,
    required this.state,
    required this.scope,
  });

  String type;
  String username;
  String applicationName;
  String clientId;
  String tokenType;
  String accessToken;
  int expiresIn;
  String state;
  String scope;

  factory AccessToken.fromJson(Map<String, dynamic> json) => AccessToken(
        type: json["type"],
        username: json["username"],
        applicationName: json["application_name"],
        clientId: json["client_id"],
        tokenType: json["token_type"],
        accessToken: json["access_token"],
        expiresIn: json["expires_in"],
        state: json["state"],
        scope: json["scope"],
      );
}
