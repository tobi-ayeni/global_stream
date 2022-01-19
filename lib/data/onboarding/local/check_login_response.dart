
class CheckLogInResponse {
  CheckLogInResponse({
    this.status,
    this.logout,
    this.message,
  });

  int? status;
  int? logout;
  String? message;

  factory CheckLogInResponse.fromJson(Map<String, dynamic> json) => CheckLogInResponse(
    status: json["status"],
    logout: json["logout"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "logout": logout,
    "message": message,
  };
}
