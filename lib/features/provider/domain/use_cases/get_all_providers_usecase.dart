import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:prozone_app/core/errors/failure.dart';
import 'package:prozone_app/features/provider/domain/entities/provider_entity.dart';
import 'package:prozone_app/features/provider/domain/repositories/provider_repository.dart';

class GetAllProvidersUsecase {
  final ProviderRepository providerRepository;

  GetAllProvidersUsecase({
    @required this.providerRepository,
  });

  Future<Either<Failure, List<ProviderEntity>>> call() {
    return providerRepository.getProviders();
  }
}
