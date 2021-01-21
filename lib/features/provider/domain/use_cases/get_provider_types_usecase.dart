import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:prozone_app/core/errors/failure.dart';
import 'package:prozone_app/features/provider/domain/entities/provider_type_entity.dart';
import 'package:prozone_app/features/provider/domain/repositories/provider_repository.dart';

class GetProviderTypesUsecase {
  final ProviderRepository providerRepository;

  GetProviderTypesUsecase({
    @required this.providerRepository,
  });

  Future<Either<Failure, List<ProviderTypeEntity>>> call() {
    return providerRepository.getProviderTypes();
  }
}
