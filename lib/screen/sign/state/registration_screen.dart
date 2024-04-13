import 'package:fake_autarization/widget/standart_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import '../../../data/user_model.dart';
import '../../../widget/standart_button.dart';
import '../../../widget/standart_scaffold.dart';
import '../../../widget/text_input.dart';

class RegistrationScreen extends StatefulWidget {
  final Function() onTapBack;
  final Function() onTapSignUp;
  final String? textError;

  const RegistrationScreen({
    super.key,
    required this.onTapBack,
    required this.onTapSignUp,
    this.textError,
  });

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final loginController = TextEditingController();
  final passwordController = TextEditingController();
  final repeatedPasswordController = TextEditingController();

  void onTapBack() {
    GetIt.I<User>().login = loginController.text;
    GetIt.I<User>().password = '';
    GetIt.I<User>().repeatPassword = '';

    widget.onTapBack();
  }

  void onTapSignUp() {
    GetIt.I<User>().login = loginController.text;
    GetIt.I<User>().password = passwordController.text;
    GetIt.I<User>().repeatPassword = repeatedPasswordController.text;

    widget.onTapSignUp();
  }

  @override
  void initState() {
    loginController.text = GetIt.I<User>().login;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return StandartScaffold(
      appBar: StandartAppBar(
        onTapBack: onTapBack,
      ),
      children: [
        Text(
          'Регистрация',
          style: textTheme.headlineLarge,
        ),
        const SizedBox(height: 32),
        TextInput(
          controller: loginController,
          textStyle: textTheme.headlineSmall,
          labelText: 'Логин',
        ),
        const SizedBox(height: 16),
        TextInput.obscuring(
          controller: passwordController,
          textStyle: textTheme.headlineSmall,
          labelText: 'Пароль',
        ),
        const SizedBox(height: 16),
        TextInput.obscuring(
          controller: repeatedPasswordController,
          textStyle: textTheme.headlineSmall,
          labelText: 'Повторынй пароль',
        ),
        const SizedBox(height: 24),
        if (widget.textError != null)
          Text(
            widget.textError!,
            style: textTheme.bodyLarge!.copyWith(
              color: Theme.of(context).colorScheme.error,
            ),
          ),
        const Spacer(),
        StandartButton(
          text: 'Зарегистрироваться',
          onTap: onTapSignUp,
        ),
      ],
    );
  }
}
