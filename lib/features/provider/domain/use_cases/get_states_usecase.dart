import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:prozone_app/core/errors/failure.dart';
import 'package:prozone_app/features/provider/domain/entities/state_entity.dart';
import 'package:prozone_app/features/provider/domain/repositories/provider_repository.dart';

class GetStatesUsecase {
  final ProviderRepository providerRepository;

  GetStatesUsecase({
    @required this.providerRepository,
  });

  Future<Either<Failure, List<StateEntity>>> call() {
    return providerRepository.getStates();
  }
}
