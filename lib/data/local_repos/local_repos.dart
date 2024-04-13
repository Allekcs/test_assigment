import 'package:fake_autarization/data/local_repos/user_rep.dart';
import 'package:fake_autarization/data/user_model.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:get_it/get_it.dart';

import 'local_user.dart';

void localReposInit() async {
  await Hive.initFlutter();
  await localUserReposInit();
  await userReposInit();

  GetIt.I.registerSingleton(User('', '', ''));
}
