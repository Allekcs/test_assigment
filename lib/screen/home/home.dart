import 'package:fake_autarization/widget/standart_button.dart';
import 'package:fake_autarization/widget/standart_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../data/user_model.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    String name = GetIt.I<User>().login;

    void clearData() async {
      var localUser = await Hive.openBox('User');
      String login = await localUser.get('login');
      String password = await localUser.get('password');

      var userRepos = await Hive.openBox('UserRepos');
      userRepos.put(login, password);

      await localUser.put('login', '');
      await localUser.put('password', '');

      GetIt.I<User>().login = '';
      GetIt.I<User>().password = '';
      GetIt.I<User>().repeatPassword = '';
    }

    void onTapLogOut() {
      clearData();
      Navigator.of(context).pushReplacementNamed('/');
    }

    return StandartScaffold(
      children: [
        Expanded(
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Здравствуйте, $name, чай дохлебываем и уходим',
                  style: textTheme.headlineLarge,
                  textAlign: TextAlign.center,
                ),
                const Icon(
                  Icons.arrow_downward,
                  size: 350,
                ),
              ],
            ),
          ),
        ),
        StandartButton.warning(text: 'Выход', onTap: onTapLogOut),
      ],
    );
  }
}
