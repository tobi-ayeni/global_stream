import 'package:global_stream/data/onboarding/local/category_response.dart';
import 'package:global_stream/data/onboarding/local/check_login_response.dart';
import 'package:global_stream/data/onboarding/local/login_response.dart';
import 'package:global_stream/data/onboarding/local/matches_response.dart';

abstract class OnBoardingRepo{
  Future<LogInResponse> login(String mobile, String password);
  Future<GetCategoriesResponse> getCategory();
  Future<GetMatchesResponse> getMatches(String categoryId);
  Future<CheckLogInResponse> checkLogin(String deviceId);

}