
class GetCategoriesResponse {
  GetCategoriesResponse({
    this.status,
    this.message,
    this.apiKey,
    this.apiSecret,
    this.data,
    this.warning,
    this.message1,
  });

  int? status;
  String? message;
  String? apiKey;
  String? apiSecret;
  List<GetCategoriesData>? data;
  String? warning;
  String? message1;

  factory GetCategoriesResponse.fromJson(Map<String, dynamic> json) => GetCategoriesResponse(
    status: json["status"],
    message: json["message"],
    apiKey: json["api_key"],
    apiSecret: json["api_secret"],
    data: List<GetCategoriesData>.from(json["data"].map((x) => GetCategoriesData.fromJson(x))),
    warning: json["warning"],
    message1: json["message_1"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "api_key": apiKey,
    "api_secret": apiSecret,
    "data": List<dynamic>.from(data!.map((x) => x.toJson())),
    "warning": warning,
    "message_1": message1,
  };
}

class GetCategoriesData {
  GetCategoriesData({
    this.categoryId,
    this.categoryname,
    this.meetingId,
    this.meetingPassword,
    this.status,
    this.createdAt,
    this.createdBy,
  });

  String? categoryId;
  String? categoryname;
  String? meetingId;
  String? meetingPassword;
  String? status;
  DateTime? createdAt;
  String? createdBy;

  factory GetCategoriesData.fromJson(Map<String, dynamic> json) => GetCategoriesData(
    categoryId: json["category_id"],
    categoryname: json["categoryname"],
    meetingId: json["meeting_id"],
    meetingPassword: json["meeting_password"],
    status: json["status"],
    createdAt: DateTime.parse(json["created_at"]),
    createdBy: json["created_by"],
  );

  Map<String, dynamic> toJson() => {
    "category_id": categoryId,
    "categoryname": categoryname,
    "meeting_id": meetingId,
    "meeting_password": meetingPassword,
    "status": status,
    "created_at": createdAt!.toIso8601String(),
    "created_by": createdBy,
  };
}
