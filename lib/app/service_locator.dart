import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:task_manager_ostad/feature/auth/presentation/blocs/forgot_password_verify_email_cubit.dart';
import 'package:task_manager_ostad/feature/auth/presentation/blocs/otp_verify_cubit.dart';
import 'package:task_manager_ostad/feature/auth/presentation/blocs/reset_password_cubit.dart';
import 'package:task_manager_ostad/feature/auth/presentation/blocs/sign_up_cubit.dart';
import 'package:task_manager_ostad/feature/auth/presentation/blocs/splash_screen_cubit.dart';
import 'package:task_manager_ostad/feature/task/presentation/add_task/presentation/blocs/add_new_task_cubit.dart';
import 'package:task_manager_ostad/feature/task/presentation/cancel_task/presentation/blocs/cancel_task_cubit.dart';
import 'package:task_manager_ostad/feature/task/presentation/complete_task/presentation/blocs/complete_task_cubit.dart';
import 'package:task_manager_ostad/feature/task/presentation/new_task/presentation/blocs/new_task_cubit.dart';

import '../core/network_executor/dio_set_up.dart';
import '../core/network_executor/network_executor.dart';
import '../core/repository/language_repository.dart';
import '../core/repository/theme_repository.dart';
import '../feature/auth/data/repositories/auth_local_data_source.dart';
import '../feature/auth/data/repositories/auth_repository.dart';
import '../feature/auth/presentation/blocs/log_in_cubit.dart';
import '../feature/common/presentation/blocs/global_auth_cubit.dart';
import '../feature/task/data/repositories/task_repository.dart';
import '../feature/task/presentation/progress_task/presentation/blocs/progress_task_cubit.dart';
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
            () => AuthRepository(sl<NetworkExecutor>(),sl<AuthLocalDataSource>()),
      )
      ..registerLazySingleton(
            () => ProgressTaskCubit(sl<TaskRepository>()),
      )

      ..registerLazySingleton(
            () => CompleteTaskCubit(sl<TaskRepository>()),
      )

      ..registerLazySingleton(
            () => NewTaskCubit(sl<TaskRepository>()),
      )

      ..registerLazySingleton(
            () => CancelTaskCubit(sl<TaskRepository>()),
      )
      ..registerLazySingleton(
            () => AddNewTaskCubit(sl<TaskRepository>()),
      )

      ..registerLazySingleton(
            () => LogInCubit(sl<AuthRepository>(),sl<GlobalAuthCubit>()),
      )
      ..registerLazySingleton(
            () => ForgotPasswordCubit(sl<AuthRepository>()),
      )
      ..registerLazySingleton(
            () => OtpVerifyCubit(sl<AuthRepository>()),
      )
      ..registerLazySingleton(
            () => ResetPasswordCubit(sl<AuthRepository>()),
      )
      ..registerLazySingleton(
            () => SplashCubit(sl<AuthRepository>()),
      )
      ..registerLazySingleton(
            () => SignUpCubit(sl<AuthRepository>()),
      )

      ..registerLazySingleton<LanguageRepository>(
              () => LanguageRepositoryImpl())
      ..registerLazySingleton<ThemeModeRepository>(
              () => ThemeModeRepositoryImpl());

  }
}