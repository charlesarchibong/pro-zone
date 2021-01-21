import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:prozone_app/core/errors/failure.dart';
import 'package:prozone_app/features/provider/domain/entities/provider_entity.dart';
import 'package:prozone_app/features/provider/domain/repositories/provider_repository.dart';

class EditProviderUseCase {
  final ProviderRepository providerRepository;

  EditProviderUseCase({
    @required this.providerRepository,
  });

  Future<Either<Failure, ProviderEntity>> call(ProviderEntity providerEntity) {
    return providerRepository.updateProvider(providerEntity);
  }
}
