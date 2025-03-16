import 'package:dio/dio.dart';
import 'package:dio_smart_retry/dio_smart_retry.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../app/app_config/app_configurations.dart';
import '../../app/app_router.dart';
import '../../app/service_locator.dart';
import '../../feature/auth/data/repositories/auth_repository.dart';
import '../../feature/common/presentation/blocs/global_auth_cubit.dart';
import '../interceptors/refresh_token_interceptor.dart';
import 'dio_interceptor.dart';


Dio getDioInstance() {
  List<String> openUrls = [
    '${AppConfiguration.baseUrl}login',
  ];
  final dio = Dio(
    BaseOptions(
      connectTimeout: AppConfiguration.connectionTimeOut,
      receiveTimeout: AppConfiguration.receiveTimeOut,
      sendTimeout: AppConfiguration.sendTimeOut,
      baseUrl: AppConfiguration.baseUrl,
    ),
  );
  // dio.interceptors.addAll([
  //   DioInterceptor(),
  //   RetryInterceptor(
  //     dio: dio,
  //     logPrint: print,
  //     retries: 2,
  //     retryDelays: const [
  //       Duration(seconds: 5),
  //       Duration(seconds: 10),
  //     ],
  //   ),
  //   RefreshTokenInterceptor(
  //     dio: dio,
  //     openUrls: openUrls,
  //     onUnauthorized: () async {
  //       // await sl<GlobalAuthCubit>().logout();
  //       var context = AppRouter.globalKey.currentContext!;
  //       context.read<GlobalAuthCubit>().logout();
  //     },
  //     refreshToken: () async {
  //       final result = await _refreshToken();
  //       if (result) {
  //         return true;
  //       }
  //       return false;
  //     },
  //   ),
  // ]);

  dio.interceptors.addAll([
    DioInterceptor(),
    RetryInterceptor(
      dio: dio,
      logPrint: print,
      retries: 2,
      retryDelays: const [
        Duration(seconds: 5),
        Duration(seconds: 10),
      ],
    ),
  ]);


  return dio;
}

// Future<bool> _refreshToken() async {
//   final result = await sl<AuthRepository>().refreshToken(
//     GlobalAuthCubit.refreshToken,
//   );
//   return await result.fold(
//         (error) async {
//       return false;
//     },
//         (success) async {
//       var context = AppRouter.globalKey.currentContext!;
//       context.read<GlobalAuthCubit>().initialize();
//       return true;
//     },
//   );
// }