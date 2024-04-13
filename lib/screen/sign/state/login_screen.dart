import 'package:fake_autarization/data/user_model.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import '../../../widget/standart_button.dart';
import '../../../widget/standart_scaffold.dart';
import '../../../widget/text_input.dart';

class LoginScreen extends StatefulWidget {
  final Function() onTapSignIn;
  final Function() onTapSignUp;
  final String? textError;

  const LoginScreen({
    super.key,
    required this.onTapSignIn,
    required this.onTapSignUp,
    this.textError,
  });

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final loginController = TextEditingController();
  final passwordController = TextEditingController();

  final loginFocusNode = FocusNode();
  final passwordFocusNode = FocusNode();

  bool isFocusTextInput = false;

  void onTapSignIn() {
    GetIt.I<User>().login = loginController.text;
    GetIt.I<User>().password = passwordController.text;

    widget.onTapSignIn();
  }

  void onTapSignUp() {
    GetIt.I<User>().login = loginController.text;
    GetIt.I<User>().password = '';

    widget.onTapSignUp();
  }

  void focusTextInputEvent() => setState(
        () => isFocusTextInput = !isFocusTextInput,
      );

  @override
  void initState() {
    loginController.text = GetIt.I<User>().login;

    loginFocusNode.addListener(() => focusTextInputEvent());
    passwordFocusNode.addListener(() => focusTextInputEvent());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return StandartScaffold(
      children: [
        Text(
          'Вход',
          style: textTheme.headlineLarge,
        ),
        const SizedBox(height: 32),
        TextInput(
          focusNode: loginFocusNode,
          controller: loginController,
          textStyle: textTheme.headlineSmall,
          labelText: 'Логин',
        ),
        const SizedBox(height: 16),
        TextInput.obscuring(
          focusNode: passwordFocusNode,
          controller: passwordController,
          textStyle: textTheme.headlineSmall,
          labelText: 'Пароль',
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
        StandartButton(text: 'Войти', onTap: onTapSignIn),
        const SizedBox(height: 8),
        if (!isFocusTextInput)
          StandartButton.secondary(
            text: 'Зарегистрироваться',
            onTap: onTapSignUp,
          ),
      ],
    );
  }
}
