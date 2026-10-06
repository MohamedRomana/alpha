// ignore_for_file: unused_local_variable

import 'package:alpha/features/auth/register/data/register_repo.dart';
import 'package:alpha/features/users/chats/data/repo/chat_repo.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import '../../features/auth/login/data/login_repo.dart';
import '../networking/dio_factory.dart';

final getIt = GetIt.instance;

Future<void> setUpGetIt() async {
  Dio dio = DioFactory.getDio();

  getIt.registerLazySingleton<RegisterRepo>(() => RegisterRepo());

  getIt.registerLazySingleton<LogInRepo>(() => LogInRepo());

  getIt.registerLazySingleton<ChatRepo>(() => ChatRepo());
}
