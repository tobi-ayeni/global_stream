part of 'onboarding_bloc.dart';

@immutable
abstract class OnboardingState {}

class OnboardingInitial extends OnboardingState {}

class Loading extends OnboardingState {}

class CheckLoading extends OnboardingState {}

class LogInSuccess extends OnboardingState {
  final LogInResponse response;

  LogInSuccess(this.response);
}

class GetCategoriesSuccess extends OnboardingState {
  final GetCategoriesResponse response;

  GetCategoriesSuccess(this.response);
}

class GetMatchesSuccess extends OnboardingState {
  final GetMatchesResponse response;

  GetMatchesSuccess(this.response);
}

class StringSuccess extends OnboardingState {
  final String response;

  StringSuccess(this.response);
}

class CheckLogInSuccess extends OnboardingState {
  final CheckLogInResponse response;

  CheckLogInSuccess(this.response);
}




class ErrorResponseSuccess extends OnboardingState {
  final ErrorResponse response;

  ErrorResponseSuccess(this.response);
}
