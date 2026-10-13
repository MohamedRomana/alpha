// ignore_for_file: unused_local_variable

import 'package:alpha/features/users/chats/data/repo/chat_repo.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import '../networking/dio_factory.dart';

final getIt = GetIt.instance;

Future<void> setUpGetIt() async {
  Dio dio = DioFactory.getDio();


  getIt.registerLazySingleton<ChatRepo>(() => ChatRepo());
}
