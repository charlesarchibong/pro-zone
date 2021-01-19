import 'package:dartz/dartz.dart';
import 'package:prozone_app/core/errors/failure.dart';
import 'package:prozone_app/features/provider/domain/entities/provider_entity.dart';

abstract class ProviderRepository {
  Future<Either<Failure, List<ProviderEntity>>> getProviders();
}
