import 'package:fake_autarization/screen/sign/state/login_screen.dart';
import 'package:fake_autarization/screen/sign/state/registration_screen.dart';
import 'package:fake_autarization/screen/sign/state/splesh_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/bloc/sign_bloc.dart';

class Sign extends StatefulWidget {
  const Sign({super.key});

  @override
  State<Sign> createState() => _SignState();
}

class _SignState extends State<Sign> {
  final bloc = SignBloc();

  @override
  void initState() {
    bloc.add(Loading());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignBloc, SignState>(
      bloc: bloc,
      listener: (context, state) {
        if (state is GoToHome) {
          Navigator.of(context).pushReplacementNamed('/home');
        }
      },
      child: BlocBuilder<SignBloc, SignState>(
        bloc: bloc,
        builder: (context, state) {
          if (state is Load) return const SpleshScreen();

          if (state is Login) {
            return LoginScreen(
              onTapSignIn: () => bloc.add(LoginEvent()),
              onTapSignUp: () => bloc.add(GoToRegistration()),
              textError: state.errorText,
            );
          }

          if (state is Registration) {
            return RegistrationScreen(
              onTapBack: () => bloc.add(GoToLogin()),
              onTapSignUp: () => bloc.add(RegistrationEvent()),
              textError: state.errorText,
            );
          }

          return const SpleshScreen();
        },
      ),
    );
  }
}
