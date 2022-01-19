class GetMatchesResponse {
  GetMatchesResponse({
    this.status,
    this.message,
    this.apiKey,
    this.apiSecret,
    this.domain,
    this.data,
  });

  int? status;
  String? message;
  String? apiKey;
  String? apiSecret;
  String? domain;
  List<GetMatchesData>? data;

  factory GetMatchesResponse.fromJson(Map<String, dynamic> json) => GetMatchesResponse(
    status: json["status"],
    message: json["message"],
    apiKey: json["api_key"],
    apiSecret: json["api_secret"],
    domain: json["domain"],
    data: List<GetMatchesData>.from(json["data"].map((x) => GetMatchesData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "api_key": apiKey,
    "api_secret": apiSecret,
    "domain": domain,
    "data": List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class GetMatchesData {
  GetMatchesData({
    this.streamId,
    this.category,
    this.meetingId,
    this.meetingPassword,
    this.matchName,
    this.streamUrl,
    this.streamkey,
    this.broadcastUrl,
    this.matchDate,
    this.matchTime,
    this.status,
    this.added,
    this.createdBy,
  });

  String? streamId;
  String? category;
  String? meetingId;
  String? meetingPassword;
  String? matchName;
  String? streamUrl;
  String? streamkey;
  String? broadcastUrl;
  DateTime? matchDate;
  String? matchTime;
  String? status;
  DateTime? added;
  dynamic createdBy;

  factory GetMatchesData.fromJson(Map<String, dynamic> json) => GetMatchesData(
    streamId: json["stream_id"],
    category: json["category"],
    meetingId: json["meeting_id"],
    meetingPassword: json["meeting_password"],
    matchName: json["match_name"],
    streamUrl: json["streamUrl"],
    streamkey: json["streamkey"],
    broadcastUrl: json["broadcastUrl"],
    matchDate: DateTime.parse(json["match_date"]),
    matchTime: json["match_time"],
    status: json["status"],
    added: DateTime.parse(json["added"]),
    createdBy: json["created_by"],
  );

  Map<String, dynamic> toJson() => {
    "stream_id": streamId,
    "category": category,
    "meeting_id": meetingId,
    "meeting_password": meetingPassword,
    "match_name": matchName,
    "streamUrl": streamUrl,
    "streamkey": streamkey,
    "broadcastUrl": broadcastUrl,
    "match_date": "${matchDate!.year.toString().padLeft(4, '0')}-${matchDate!.month.toString().padLeft(2, '0')}-${matchDate!.day.toString().padLeft(2, '0')}",
    "match_time": matchTime,
    "status": status,
    "added": added!.toIso8601String(),
    "created_by": createdBy,
  };
}
