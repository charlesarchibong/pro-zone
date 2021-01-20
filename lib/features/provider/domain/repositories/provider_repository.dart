import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:prozone_app/core/errors/failure.dart';
import 'package:prozone_app/features/provider/domain/entities/image_entity.dart';
import 'package:prozone_app/features/provider/domain/entities/provider_entity.dart';
import 'package:prozone_app/features/provider/domain/entities/provider_type_entity.dart';
import 'package:prozone_app/features/provider/domain/entities/state_entity.dart';

abstract class ProviderRepository {
  Future<Either<Failure, List<ProviderEntity>>> getProviders();
  Future<Either<Failure, List<StateEntity>>> getStates();
  Future<Either<Failure, ImageEntity>> uploadProviderImages({
    @required String providerId,
    List<Asset> images,
  });
  Future<Either<Failure, List<ProviderTypeEntity>>> getProviderTypes();
  Future<Either<Failure, ProviderEntity>> createProvider(
    ProviderEntity providerEntity,
  );
}
