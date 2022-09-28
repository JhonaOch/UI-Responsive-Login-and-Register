import 'dart:convert';

SessionResponse sessionResponseFromJson(String str) =>
    SessionResponse.fromJson(json.decode(str));

String sessionResponseToJson(SessionResponse data) =>
    json.encode(data.toJson());

class SessionResponse {
  SessionResponse({
    this.accessToken,
    //this.refreshToken,
    this.createAt,
  });

  String? accessToken;
  String? refreshToken;
  DateTime? createAt;

  factory SessionResponse.fromJson(Map<String, dynamic> json) =>
      SessionResponse(
        accessToken: json["accessToken"],
        //refreshToken: json["refreshToken"],
        createAt: DateTime.parse(json["createAt"]),
      );

  Map<String, dynamic> toJson() => {
        "accessToken": accessToken,
        //"refreshToken": refreshToken,
        "createAt": createAt.toString(),
      };
}
