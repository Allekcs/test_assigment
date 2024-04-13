import 'package:hive_flutter/hive_flutter.dart';

Future<Box> localUserReposInit() async {
  final localUserBox = await Hive.openBox('User');

  if (localUserBox.get('login') == null) {
    localUserBox.put('login', '');
  }

  if (localUserBox.get('password') == null) {
    localUserBox.put('password', '');
  }

  return localUserBox;
}
