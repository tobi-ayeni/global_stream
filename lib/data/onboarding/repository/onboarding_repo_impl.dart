import 'package:global_stream/data/onboarding/local/category_response.dart';
import 'package:global_stream/data/onboarding/local/check_login_response.dart';
import 'package:global_stream/data/onboarding/local/error_response.dart';
import 'package:global_stream/data/onboarding/local/login_response.dart';
import 'package:global_stream/data/onboarding/local/matches_response.dart';
import 'package:global_stream/data/onboarding/remote/onboarding_service.dart';
import 'package:global_stream/data/onboarding/remote/onboarding_service_impl.dart';
import 'package:global_stream/data/onboarding/repository/onboarding_repo.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnBoardingRepoImpl extends OnBoardingRepo {
  late OnBoardingService onBoardingService;
  late SharedPreferences preferences;

  OnBoardingRepoImpl() {
    onBoardingService = OnBoardingServiceImpl();
  }

  @override
  Future<LogInResponse> login(String mobile, String password) async {
    try {
      return await onBoardingService.login(mobile, password);
    } catch (e, st) {
      if(e is String){
        throw StringResponse(e);
      }else{
        print(e);
        rethrow;
      }
    }
  }

  @override
  Future<GetCategoriesResponse> getCategory() async {
    preferences = await SharedPreferences.getInstance();

    try {
      return await onBoardingService.getCategory(preferences.getString("id")!);
    } catch (e, st) {
      if(e is String){
        throw StringResponse(e);
      }else{
        print(e);
        rethrow;
      }
    }
  }

  @override
  Future<GetMatchesResponse> getMatches(String categoryId) async {
    preferences = await SharedPreferences.getInstance();

    try {
      return await onBoardingService.getMatches(categoryId, preferences.getString("id")!);
    } catch (e, st) {
      if(e is String){
        throw StringResponse(e);
      }else{
        print(e);
        rethrow;
      }
    }
  }

  @override
  Future<CheckLogInResponse> checkLogin(String deviceId) async{
    preferences = await SharedPreferences.getInstance();

    try {
      return await onBoardingService.checkLogin(deviceId, preferences.getString("id")!);
    } catch (e, st) {
      if(e is String){
        throw StringResponse(e);
      }else{
        print(e);
        rethrow;
      }
    }
  }
}
