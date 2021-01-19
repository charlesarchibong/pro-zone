import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:prozone_app/features/provider/data/models/provider_model.dart';
import 'package:prozone_app/features/provider/domain/entities/provider_entity.dart';
import 'package:prozone_app/features/provider/domain/repositories/provider_repository.dart';
import 'package:prozone_app/features/provider/domain/use_cases/create_provider_usecase.dart';

import '../../../../fixtures/fixture.dart';

class MockProviderRepository extends Mock implements ProviderRepository {}

final ProviderEntity providerEntity = ProviderModel.fromMap(
  json.decode(
    fixture('provider_fixture'),
  ),
);
main() {
  CreateProviderUseCase createProviderUseCase;
  MockProviderRepository mockProviderRepository;
  setUp(() {
    mockProviderRepository = MockProviderRepository();
    createProviderUseCase = CreateProviderUseCase(
      providerRepository: mockProviderRepository,
    );
  });

  test('should create provider from providerrepository', () async {
    when(mockProviderRepository.createProvider(any)).thenAnswer(
      (_) async => Right(
        providerEntity,
      ),
    );
    final result = await createProviderUseCase(providerEntity);
    expect(result.isRight(), true);
    verify(mockProviderRepository.createProvider(any));
    verifyNoMoreInteractions(mockProviderRepository);
  });
}
