import 'package:connectivity/connectivity.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:dio/dio.dart';
import 'package:dio_http_cache/dio_http_cache.dart';
import 'package:get_it/get_it.dart';
import 'package:prozone_app/core/network/http_requester.dart';
import 'package:prozone_app/core/network/network_info.dart';

final sl = GetIt.instance;

Future<void> initDi() async {
  // final sharePreferences = await SharedPreferences.getInstance();

  sl.registerLazySingleton(
    () => Connectivity(),
  );

  sl.registerLazySingleton(
    () => Dio(),
  );

  sl.registerLazySingleton(
    () => HttpServiceRequester(
      dio: sl(),
      dioCacheManager: sl(),
    ),
  );

  sl.registerLazySingleton(
    () => DioCacheManager(
      CacheConfig(),
    ),
  );

  sl.registerLazySingleton<NetworkInfo>(
    () => NetworkInfoImpl(
      sl(),
    ),
  );
  sl.registerLazySingleton(() => DataConnectionChecker());
}
