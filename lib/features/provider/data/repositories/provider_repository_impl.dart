import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:prozone_app/core/errors/error.dart';
import 'package:prozone_app/core/errors/failure.dart';
import 'package:prozone_app/features/provider/data/data_sources/remote_datasource.dart';
import 'package:prozone_app/features/provider/data/models/provider_model.dart';
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
  Future<Either<Failure, List<ProviderEntity>>> getProviders() async {
    try {
      return Right(await remoteDataSource.getProviders());
    } catch (e) {
      print(e);
      if (e is NoInternetException) {
        return Left(
          NoInternetFailure(),
        );
      }
      if (e is DioError) {
        return Left(
          ServerFailure(
            message: e.response.data['message'],
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
      print(e);
      if (e is NoInternetException) {
        return Left(
          NoInternetFailure(),
        );
      }
      if (e is DioError) {
        return Left(
          ServerFailure(
            message: e.response.data['message'],
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
      print(e);
      if (e is NoInternetException) {
        return Left(
          NoInternetFailure(),
        );
      }
      if (e is DioError) {
        return Left(
          ServerFailure(
            message: e.response.data['message'],
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
        providerTypeModel: providerEntity.providerTypeEntity,
        rating: providerEntity.rating,
        state: providerEntity.state,
      );
      return Right(await remoteDataSource.createProvider(providerModel));
    } catch (e) {
      print(e);
      if (e is NoInternetException) {
        return Left(
          NoInternetFailure(),
        );
      }
      if (e is DioError) {
        return Left(
          ServerFailure(
            message: e.response.data['message'],
          ),
        );
      }
      return Left(UnknownFailure());
    }
  }

  @override
  Future<Either<Failure, ImageEntity>> uploadProviderImages(
      {String providerId, List<Asset> images}) async {
    try {
      return Right(
        await remoteDataSource.uploadProviderImages(
          images: images,
          providerId: providerId,
        ),
      );
    } catch (e) {
      print(e);
      if (e is NoInternetException) {
        return Left(
          NoInternetFailure(),
        );
      }
      if (e is DioError) {
        return Left(
          ServerFailure(
            message: e.response.data['message'],
          ),
        );
      }
      return Left(UnknownFailure());
    }
  }
}
