import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:prozone_app/features/provider/data/models/image_model.dart';
import 'package:prozone_app/features/provider/domain/repositories/provider_repository.dart';
import 'package:prozone_app/features/provider/domain/use_cases/upload_provider_images.dart';

import '../../../../fixtures/fixture.dart';

class MockProviderRepository extends Mock implements ProviderRepository {}

final ImageModel imageModel = ImageModel.fromMap(
  json.decode(
    fixture('image_fixture'),
  ),
);
main() {
  UploadProviderImagesUsecase uploadProviderImages;
  MockProviderRepository mockProviderRepository;
  setUp(() {
    mockProviderRepository = MockProviderRepository();
    uploadProviderImages = UploadProviderImagesUsecase(
      providerRepository: mockProviderRepository,
    );
  });

  test('should upload images to providerrepository', () async {
    when(mockProviderRepository
        .uploadProviderImages(providerId: '1', images: [])).thenAnswer(
      (_) async => Right(
        [imageModel],
      ),
    );
    final result = await uploadProviderImages('1', []);
    expect(result.isRight(), true);
    verify(mockProviderRepository.uploadProviderImages(
      providerId: '1',
      images: [],
    ));
    verifyNoMoreInteractions(mockProviderRepository);
  });
}
