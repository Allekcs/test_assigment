part of 'sign_bloc.dart';

@immutable
sealed class SignState {}

final class Load extends SignState {}

final class Login extends SignState {
  final String? errorText;

  Login({this.errorText});
}

final class Registration extends SignState {
  final String? errorText;

  Registration({this.errorText});
}

final class GoToHome extends SignState {}
