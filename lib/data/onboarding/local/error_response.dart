import 'dart:async';
import 'dart:io';

import 'package:http/http.dart';

String handleRequestError(Exception e) {
  if (e is SocketException) {
    return "No internet connection, please try again";
  } else if (e is TimeoutException) {
    return "Request timed out, please try again, or check your Connection";
  } else if (e is FormatException || e is ClientException) {
    return "Something went wrong, please try again";
  } else {
    return e.toString();
  }
}

class ErrorResponse{
  final int? status;
  final String? message;


  ErrorResponse({this.status, this.message});

  factory ErrorResponse.fromJson(Map<String, dynamic> json) => ErrorResponse(
    status: json["status"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
  };

}

class StringResponse{
  final String message;


  StringResponse(this.message);

  @override
  String toString() {
    return 'StringResponse{message: $message}';
  }
}
