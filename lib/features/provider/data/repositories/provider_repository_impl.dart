import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';
import 'package:prozone_app/core/errors/error.dart';
import 'package:prozone_app/core/errors/failure.dart';
import 'package:prozone_app/features/provider/data/data_sources/remote_datasource.dart';
import 'package:prozone_app/features/provider/domain/entities/provider_entity.dart';
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
}
