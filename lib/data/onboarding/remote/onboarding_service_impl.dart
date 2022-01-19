import 'dart:convert';

import 'package:global_stream/data/onboarding/local/category_response.dart';
import 'package:global_stream/data/onboarding/local/check_login_response.dart';
import 'package:global_stream/data/onboarding/local/error_response.dart';
import 'package:global_stream/data/onboarding/local/login_response.dart';
import 'package:global_stream/data/onboarding/local/matches_response.dart';
import 'package:global_stream/data/onboarding/remote/onboarding_service.dart';
import 'package:global_stream/utils/strings.dart';
import 'package:http/http.dart' as http;

class OnBoardingServiceImpl extends OnBoardingService {
  late http.Response response;

  @override
  Future<LogInResponse> login(String mobile, String password) async {
    var url = "${baseUrl}login";
    // Map<String, String> headers = {
    //   'Content-Type': 'application/json',
    //   "Access-Control-Allow-Origin": "*",
    //   "Access-Control-Allow-Credentials": "true",
    //   "Access-Control-Allow-Headers":
    //       "Access-Control-Allow-Origin, Accept",
    //   "Access-Control-Allow-Methods": "POST, OPTIONS"
    // };

    Map<String, dynamic> body = {'mobile': mobile, 'password': password};

    try {
      response = await http
          .post(Uri.parse(url), body: jsonEncode(body))
          .timeout(requestDuration);
      var jsonResponse = jsonDecode(response.body);
      if (response.statusCode >= 300 && response.statusCode <= 520) {
        throw jsonResponse;
      } else if (jsonResponse["status"] == 0) {
        print("here");
        throw ErrorResponse.fromJson(jsonResponse);
      } else {
        return LogInResponse.fromJson(jsonResponse);
      }
    } catch (error, st) {
      print("error$error");
      print(st);
      if (error is Exception) {
        throw handleRequestError(error);
      } else {
        rethrow;
      }
    }
  }

  @override
  Future<GetCategoriesResponse> getCategory(String userId) async {
    var url = "${baseUrl}getCategory";
    Map<String, String> headers = {
      'Content-Type': 'application/json',
    };

    Map<String, dynamic> body = {
      'user_id': userId,
    };
    print(body);

    try {
      response = await http
          .post(Uri.parse(url), headers: headers, body: jsonEncode(body))
          .timeout(requestDuration);
      var jsonResponse = jsonDecode(response.body);
      if (response.statusCode >= 300 && response.statusCode <= 520) {
        throw jsonResponse;
      } else if (jsonResponse["status"] == 0) {
        print("here");
        throw ErrorResponse.fromJson(jsonResponse);
      } else {
        return GetCategoriesResponse.fromJson(jsonResponse);
      }
    } catch (error) {
      print("error$error");
      if (error is Exception) {
        throw handleRequestError(error);
      } else {
        rethrow;
      }
    }
  }

  @override
  Future<GetMatchesResponse> getMatches(String categoryId, String id) async {
    var url = "${baseUrl}getMatches";
    Map<String, String> headers = {
      'Content-Type': 'application/json',
    };

    Map<String, dynamic> body = {'category': categoryId, 'user_id': id};

    try {
      response = await http
          .post(Uri.parse(url), headers: headers, body: jsonEncode(body))
          .timeout(requestDuration);
      var jsonResponse = jsonDecode(response.body);
      if (response.statusCode >= 300 && response.statusCode <= 520) {
        throw jsonResponse;
      } else if (jsonResponse["status"] == 0) {
        print("here");
        throw ErrorResponse.fromJson(jsonResponse);
      } else {
        return GetMatchesResponse.fromJson(jsonResponse);
      }
    } catch (error) {
      print("error$error");
      if (error is Exception) {
        throw handleRequestError(error);
      } else {
        rethrow;
      }
    }
  }

  @override
  Future<CheckLogInResponse> checkLogin(String deviceId, String id) async {
    var url = "${baseUrl}check_login";
    Map<String, String> headers = {
      'Content-Type': 'application/json',
    };

    Map<String, dynamic> body = {'device_id': deviceId, 'user_id': id};

    try {
      response = await http
          .post(Uri.parse(url), headers: headers, body: jsonEncode(body))
          .timeout(requestDuration);
      var jsonResponse = jsonDecode(response.body);
      if (response.statusCode >= 300 && response.statusCode <= 520) {
        throw jsonResponse;
      } else if (jsonResponse["status"] == 0) {
        print("here");
        throw ErrorResponse.fromJson(jsonResponse);
      } else {
        return CheckLogInResponse.fromJson(jsonResponse);
      }
    } catch (error) {
      print("error$error");
      if (error is Exception) {
        throw handleRequestError(error);
      } else {
        rethrow;
      }
    }
  }
}
