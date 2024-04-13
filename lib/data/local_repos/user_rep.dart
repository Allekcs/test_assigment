import 'package:hive_flutter/hive_flutter.dart';

Future<Box> userReposInit() async {
  final localUserReposBox = await Hive.openBox('UserRepos');

  // login -- password
  localUserReposBox.put('', '');

  return localUserReposBox;
}
