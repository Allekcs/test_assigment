import 'package:bloc/bloc.dart';
import 'package:fake_autarization/data/user_model.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:meta/meta.dart';

part 'sign_event.dart';
part 'sign_state.dart';

class SignBloc extends Bloc<SignEvent, SignState> {
  SignBloc() : super(Load()) {
    on<Loading>((event, emit) async {
      emit(Load());
      await Future.delayed(const Duration(seconds: 2));

      var settings = await Hive.openBox('User');
      String login = await settings.get('login');

      if (login != '') {
        GetIt.I<User>().login = login;
        emit(GoToHome());
      } else {
        emit(Login());
      }
    });

    on<LoginEvent>((event, emit) async {
      String login = GetIt.I<User>().login;
      String password = GetIt.I<User>().password;

      var userRepos = await Hive.openBox('UserRepos');
      final originPassword = await userRepos.get(login);

      if (password != originPassword || login == '' || password == '') {
        emit(Login(errorText: 'Неверый логин или пароль'));
        return;
      }

      emit(GoToHome());
    });

    on<RegistrationEvent>((event, emit) async {
      String login = GetIt.I<User>().login;
      String password = GetIt.I<User>().password;
      String repeatPassword = GetIt.I<User>().repeatPassword;

      String errorText = '';

      if (login.length < 3) {
        errorText += 'Логин должен быть длинее 3х символов\n';
      }

      if (!RegExp(r"^[a-zA-Z0-9]+$").hasMatch(login)) {
        errorText += 'Логин должен состоять из символов: 0-9, a-z, A-Z\n';
      }

      if (password.length < 6) {
        errorText += 'Пароль должен быть длинее 6ти символов\n';
      }

      if (!RegExp(r"^[a-zA-Z0-9]+$").hasMatch(password)) {
        errorText += 'Пароль должен состоять из символов: 0-9, a-z, A-Z\n';
      }

      if (password != repeatPassword) {
        errorText += 'Пароли не совпадают\n';
      }

      if (errorText != '') {
        emit(Registration(errorText: errorText));
        return;
      }

      var localUser = await Hive.openBox('User');
      await localUser.put('login', login);
      await localUser.put('password', password);

      emit(GoToHome());
    });

    on<GoToRegistration>((event, emit) async {
      emit(Registration());
    });

    on<GoToLogin>((event, emit) async {
      emit(Login());
    });
  }
}
