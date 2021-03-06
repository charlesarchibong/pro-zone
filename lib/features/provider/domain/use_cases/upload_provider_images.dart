import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:prozone_app/core/errors/failure.dart';
import 'package:prozone_app/features/provider/domain/entities/image_entity.dart';
import 'package:prozone_app/features/provider/domain/repositories/provider_repository.dart';

class UploadProviderImagesUsecase {
  final ProviderRepository providerRepository;

  UploadProviderImagesUsecase({
    @required this.providerRepository,
  });

  Future<Either<Failure, List<ImageEntity>>> call(
      String providerId, List<Asset> images) {
    return providerRepository.uploadProviderImages(
      providerId: providerId,
      images: images,
    );
  }
}
