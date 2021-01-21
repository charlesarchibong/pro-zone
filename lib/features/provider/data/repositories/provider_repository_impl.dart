import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:prozone_app/core/errors/error.dart';
import 'package:prozone_app/core/errors/failure.dart';
import 'package:prozone_app/features/provider/data/data_sources/remote_datasource.dart';
import 'package:prozone_app/features/provider/data/models/provider_model.dart';
import 'package:prozone_app/features/provider/data/models/provider_type_model.dart';
import 'package:prozone_app/features/provider/data/models/state_model.dart';
import 'package:prozone_app/features/provider/domain/entities/image_entity.dart';
import 'package:prozone_app/features/provider/domain/entities/provider_entity.dart';
import 'package:prozone_app/features/provider/domain/entities/provider_type_entity.dart';
import 'package:prozone_app/features/provider/domain/entities/state_entity.dart';
import 'package:prozone_app/features/provider/domain/repositories/provider_repository.dart';

class ProviderRepositoryImpl implements ProviderRepository {
  final RemoteDataSource remoteDataSource;
  ProviderRepositoryImpl({
    @required this.remoteDataSource,
  });
  @override
  Future<Either<Failure, List<ProviderEntity>>> getProviders(
      {String searchText}) async {
    try {
      return Right(await remoteDataSource.getProviders(searchText));
    } catch (e) {
      //print(e);
      if (e is NoInternetException) {
        return Left(
          NoInternetFailure(),
        );
      }
      if (e is DioError) {
        return Left(
          e.response == null
              ? ServerFailure(message: e.message)
              : ServerFailure(
                  message: e.response.data['message'] ?? 'Error occurred',
                ),
        );
      }
      return Left(UnknownFailure());
    }
  }

  @override
  Future<Either<Failure, List<StateEntity>>> getStates() async {
    try {
      return Right(await remoteDataSource.getStates());
    } catch (e) {
      //print(e);
      if (e is NoInternetException) {
        return Left(
          NoInternetFailure(),
        );
      }
      if (e is DioError) {
        return Left(
          e.response == null
              ? ServerFailure(message: e.message)
              : ServerFailure(
                  message: e.response.data['message'] ?? 'Error occurred',
                ),
        );
      }
      return Left(UnknownFailure());
    }
  }

  @override
  Future<Either<Failure, List<ProviderTypeEntity>>> getProviderTypes() async {
    try {
      return Right(await remoteDataSource.getProviderTypes());
    } catch (e) {
      //print(e);
      if (e is NoInternetException) {
        return Left(
          NoInternetFailure(),
        );
      }
      if (e is DioError) {
        return Left(
          e.response == null
              ? ServerFailure(message: e.message)
              : ServerFailure(
                  message: e.response.data['message'] ?? 'Error occurred',
                ),
        );
      }
      return Left(UnknownFailure());
    }
  }

  @override
  Future<Either<Failure, ProviderEntity>> createProvider(
      ProviderEntity providerEntity) async {
    try {
      ProviderModel providerModel = ProviderModel(
        activeStatus: providerEntity.activeStatus,
        address: providerEntity.address,
        description: providerEntity.description,
        id: providerEntity.id,
        images: providerEntity.images,
        name: providerEntity.name,
        providerTypeModel: ProviderTypeModel(
          id: providerEntity.providerTypeEntity.id,
          name: providerEntity.providerTypeEntity.name,
        ),
        rating: providerEntity.rating,
        state: StateModel(
          id: providerEntity.state.id,
          name: providerEntity.state.name,
        ),
      );
      return Right(await remoteDataSource.createProvider(providerModel));
    } catch (e) {
      //print(e);
      if (e is NoInternetException) {
        return Left(
          NoInternetFailure(),
        );
      }
      if (e is DioError) {
        return Left(
          e.response == null
              ? ServerFailure(message: e.message)
              : ServerFailure(
                  message: e.response.data['message'] ?? 'Error occurred',
                ),
        );
      }
      return Left(UnknownFailure());
    }
  }

  @override
  Future<Either<Failure, List<ImageEntity>>> uploadProviderImages(
      {String providerId, List<Asset> images}) async {
    try {
      return Right(
        await remoteDataSource.uploadProviderImages(
          images: images,
          providerId: providerId,
        ),
      );
    } catch (e) {
      //print(e);
      if (e is NoInternetException) {
        return Left(
          NoInternetFailure(),
        );
      }
      if (e is DioError) {
        return Left(
          e.response == null
              ? ServerFailure(message: e.message)
              : ServerFailure(
                  message: e.response.data['message'] ?? 'Error occurred',
                ),
        );
      }
      return Left(UnknownFailure());
    }
  }

  @override
  Future<Either<Failure, ProviderEntity>> updateProvider(
      ProviderEntity providerEntity) async {
    try {
      ProviderModel providerModel = ProviderModel(
        activeStatus: providerEntity.activeStatus,
        address: providerEntity.address,
        description: providerEntity.description,
        id: providerEntity.id,
        images: providerEntity.images,
        name: providerEntity.name,
        providerTypeModel: ProviderTypeModel(
          id: providerEntity.providerTypeEntity.id,
          name: providerEntity.providerTypeEntity.name,
        ),
        rating: providerEntity.rating,
        state: StateModel(
          id: providerEntity.state.id,
          name: providerEntity.state.name,
        ),
      );
      return Right(await remoteDataSource.updateProvider(providerModel));
    } catch (e) {
      //print(e);
      if (e is NoInternetException) {
        return Left(
          NoInternetFailure(),
        );
      }
      if (e is DioError) {
        return Left(
          e.response == null
              ? ServerFailure(message: e.message)
              : ServerFailure(
                  message: e.response.data['message'] ?? 'Error occurred',
                ),
        );
      }
      return Left(UnknownFailure());
    }
  }
}
