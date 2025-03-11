import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import '../core/network_executor/dio_set_up.dart';
import '../core/network_executor/network_executor.dart';
import '../core/repository/language_repository.dart';
import '../core/repository/theme_repository.dart';
final sl = GetIt.instance;

class ServiceLocator {
  ServiceLocator._();

  static ServiceLocator get instance => ServiceLocator._();

  void init() {
    sl
      ..registerLazySingleton(getDioInstance)
      ..registerLazySingleton(AuthLocalDataSource.new)
      ..registerLazySingleton(() => NetworkExecutor(sl<Dio>()))
      ..registerLazySingleton(
            () => GlobalAuthCubit(sl<AuthRepository>()),
      )
      ..registerLazySingleton(
            () => BrandRepository(
          sl<NetworkExecutor>(),
        ),
      )
      ..registerLazySingleton(
            () => BillRepository(
          sl<NetworkExecutor>(),
        ),
      )
      ..registerLazySingleton(
            () => AuthRepository(
          sl<NetworkExecutor>(),
          sl<AuthLocalDataSource>(),
        ),
      )
      ..registerLazySingleton(
            () => ProductRepository(
          sl<NetworkExecutor>(),
        ),
      )
      ..registerLazySingleton<LanguageRepository>(
              () => LanguageRepositoryImpl())
      ..registerLazySingleton<ThemeModeRepository>(
              () => ThemeModeRepositoryImpl());

    sl.registerLazySingleton(() => StockRepository(sl<NetworkExecutor>()));
  }
}