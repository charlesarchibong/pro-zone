import 'package:connectivity/connectivity.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:dio/dio.dart';
import 'package:dio_http_cache/dio_http_cache.dart';
import 'package:get_it/get_it.dart';
import 'package:prozone_app/core/network/http_requester.dart';
import 'package:prozone_app/core/network/network_info.dart';
import 'package:prozone_app/features/provider/data/data_sources/remote_datasource.dart';
import 'package:prozone_app/features/provider/data/repositories/provider_repository_impl.dart';
import 'package:prozone_app/features/provider/domain/repositories/provider_repository.dart';
import 'package:prozone_app/features/provider/domain/use_cases/create_provider_usecase.dart';
import 'package:prozone_app/features/provider/domain/use_cases/edit_provider_usecase.dart';
import 'package:prozone_app/features/provider/domain/use_cases/get_all_providers_usecase.dart';
import 'package:prozone_app/features/provider/domain/use_cases/get_provider_types_usecase.dart';
import 'package:prozone_app/features/provider/domain/use_cases/get_states_usecase.dart';
import 'package:prozone_app/features/provider/domain/use_cases/upload_provider_images.dart';
import 'package:prozone_app/features/provider/presentation/providers/service_provider.dart';

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
  sl.registerLazySingleton(
    () => DataConnectionChecker(),
  );
  sl.registerLazySingleton<ProviderRepository>(
    () => ProviderRepositoryImpl(
      remoteDataSource: sl(),
    ),
  );
  sl.registerLazySingleton<RemoteDataSource>(
    () => RemoteDataSourceImpl(
      httpServiceRequester: sl(),
      networkInfo: sl(),
    ),
  );

  sl.registerLazySingleton(
    () => CreateProviderUseCase(
      providerRepository: sl(),
    ),
  );
  sl.registerLazySingleton(
    () => GetAllProvidersUsecase(
      providerRepository: sl(),
    ),
  );
  sl.registerLazySingleton(
    () => GetProviderTypesUsecase(
      providerRepository: sl(),
    ),
  );
  sl.registerLazySingleton(
    () => GetStatesUsecase(
      providerRepository: sl(),
    ),
  );
  sl.registerLazySingleton(
    () => UploadProviderImagesUsecase(
      providerRepository: sl(),
    ),
  );
  sl.registerLazySingleton(
    () => EditProviderUseCase(
      providerRepository: sl(),
    ),
  );
  sl.registerLazySingleton(
    () => ServiceProvider(
      createProviderUseCase: sl(),
      getAllProvidersUsecase: sl(),
      getProviderTypesUsecase: sl(),
      getStatesUsecase: sl(),
      uploadProviderImagesUsecase: sl(),
      editProviderUseCase: sl(),
    ),
  );
}
