part of 'sign_bloc.dart';

@immutable
sealed class SignEvent {}

final class Loading extends SignEvent {}

final class LoginEvent extends SignEvent {}

final class RegistrationEvent extends SignEvent {}

final class GoToRegistration extends SignEvent {}

final class GoToLogin extends SignEvent {}
