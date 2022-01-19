
class LogInResponse {
  LogInResponse({
    this.status,
    this.message,
    this.data,
  });

  int? status;
  String? message;
  LogInResponseData? data;

  factory LogInResponse.fromJson(Map<String, dynamic> json) => LogInResponse(
    status: json["status"],
    message: json["message"],
    data: LogInResponseData.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data!.toJson(),
  };
}

class LogInResponseData {
  LogInResponseData({
    this.id,
    this.adminId,
    this.firstName,
    this.lastName,
    this.fullName,
    this.image,
    this.mobile,
    this.email,
    this.password,
    this.planCusId,
    this.otp,
    this.referral,
    this.deviceId,
    this.deviceName,
    this.deviceType,
    this.deviceToken,
    this.status,
    this.userType,
    this.createdAt,
    this.updatedAt,
    this.createdBy,
    this.loginStatus,
  });

  String? id;
  dynamic adminId;
  String? firstName;
  String? lastName;
  String? fullName;
  String? image;
  String? mobile;
  String? email;
  String? password;
  String? planCusId;
  String? otp;
  String? referral;
  String? deviceId;
  String? deviceName;
  String? deviceType;
  dynamic deviceToken;
  String? status;
  String? userType;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? createdBy;
  String? loginStatus;

  factory LogInResponseData.fromJson(Map<String, dynamic> json) => LogInResponseData(
    id: json["id"],
    adminId: json["admin_id"],
    firstName: json["first_name"],
    lastName: json["last_name"],
    fullName: json["full_name"],
    image: json["image"],
    mobile: json["mobile"],
    email: json["email"],
    password: json["password"],
    planCusId: json["plan_cus_id"],
    otp: json["otp"],
    referral: json["referral"],
    deviceId: json["device_id"],
    deviceName: json["device_name"],
    deviceType: json["device_type"],
    deviceToken: json["device_token"],
    status: json["status"],
    userType: json["user_type"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    createdBy: json["created_by"],
    loginStatus: json["login_status"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "admin_id": adminId,
    "first_name": firstName,
    "last_name": lastName,
    "full_name": fullName,
    "image": image,
    "mobile": mobile,
    "email": email,
    "password": password,
    "plan_cus_id": planCusId,
    "otp": otp,
    "referral": referral,
    "device_id": deviceId,
    "device_name": deviceName,
    "device_type": deviceType,
    "device_token": deviceToken,
    "status": status,
    "user_type": userType,
    "created_at": createdAt!.toIso8601String(),
    "updated_at": updatedAt!.toIso8601String(),
    "created_by": createdBy,
    "login_status": loginStatus,
  };

  @override
  String toString() {
    return 'LogInResponseData{id: $id, adminId: $adminId, firstName: $firstName, lastName: $lastName, fullName: $fullName, image: $image, mobile: $mobile, email: $email, password: $password, planCusId: $planCusId, otp: $otp, referral: $referral, deviceId: $deviceId, deviceName: $deviceName, deviceType: $deviceType, deviceToken: $deviceToken, status: $status, userType: $userType, createdAt: $createdAt, updatedAt: $updatedAt, createdBy: $createdBy, loginStatus: $loginStatus}';
  }
}
