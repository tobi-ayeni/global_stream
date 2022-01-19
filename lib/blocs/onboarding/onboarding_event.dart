part of 'onboarding_bloc.dart';

@immutable
abstract class OnboardingEvent {}

class LogInEvent extends OnboardingEvent{
  final String mobile;
  final String password;

  LogInEvent(this.mobile, this.password);
}

class GetCategoryEvent extends OnboardingEvent{}

class GetMatchEvent extends OnboardingEvent{
  final String categoryId;

  GetMatchEvent(this.categoryId);
}

class CheckLoginEvent extends OnboardingEvent{
  final String deviceId;

  CheckLoginEvent(this.deviceId);
}
