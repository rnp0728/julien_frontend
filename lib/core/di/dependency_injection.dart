import 'package:get_it/get_it.dart';
import 'package:julien/core/rest_client/rest_client.dart';
import 'package:julien/core/utils/persistent_manager.dart';
import 'package:julien/services/authentication/data/authentication_repository.dart';

final GetIt getIt = GetIt.instance;

class AppInjector {
  static Future<void> initializeDependencies() async {
    getIt
      ..registerSingleton<PersistentManager>(PersistentManager())
      ..registerSingleton<RestClientDio>(RestClientDio())
      ..registerSingleton<AuthenticationRepository>(
          AuthenticationRepositoryImpl(client: getIt<RestClientDio>()));
  }
}
