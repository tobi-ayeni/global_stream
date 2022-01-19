import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:global_stream/data/onboarding/local/category_response.dart';
import 'package:global_stream/data/onboarding/local/check_login_response.dart';
import 'package:global_stream/data/onboarding/local/error_response.dart';
import 'package:global_stream/data/onboarding/local/login_response.dart';
import 'package:global_stream/data/onboarding/local/matches_response.dart';
import 'package:global_stream/data/onboarding/repository/onboarding_repo_impl.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'onboarding_event.dart';

part 'onboarding_state.dart';

class OnboardingBloc extends Bloc<OnboardingEvent, OnboardingState> {
  final repository = OnBoardingRepoImpl();

  OnboardingBloc() : super(OnboardingInitial()) {
    on<LogInEvent>((event, emit) async {
      emit(Loading());
      try {
        var result = await repository.login(event.mobile, event.password);
        SharedPreferences? preferences = await SharedPreferences.getInstance();
        preferences.setString("id", result.data!.id!);

        emit(LogInSuccess(result));
      } catch (e, stack) {
        if (e is String) {
          emit(StringSuccess(e));
        } else {
          emit(ErrorResponseSuccess(e as ErrorResponse));
        }
      }
    });
    on<GetCategoryEvent>((event, emit) async {
      emit(Loading());
      try {
        var result = await repository.getCategory();
        emit(GetCategoriesSuccess(result));
      } catch (e, stack) {
        if (e is StringResponse) {
          emit(StringSuccess(e.message));
        } else {
          emit(ErrorResponseSuccess(e as ErrorResponse));
        }
        print(e);
      }
    });
    on<GetMatchEvent>((event, emit) async {
      emit(Loading());
      try {
        var result = await repository.getMatches(event.categoryId);
        emit(GetMatchesSuccess(result));
      } catch (e, stack) {
        if(e is String){
          emit(StringSuccess(e));
        }else{
          emit(ErrorResponseSuccess(e as ErrorResponse));
        }
      }
    });
    on<CheckLoginEvent>((event, emit) async {
      emit(CheckLoading());
      try {
        var result = await repository.checkLogin(event.deviceId);
        emit(CheckLogInSuccess(result));
      } catch (e, stack) {
        if(e is String){
          emit(StringSuccess(e));
        }else{
          emit(ErrorResponseSuccess(e as ErrorResponse));
        }
      }
    });
  }
}
