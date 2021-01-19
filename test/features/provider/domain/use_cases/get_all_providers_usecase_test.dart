import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:prozone_app/features/provider/data/models/provider_model.dart';
import 'package:prozone_app/features/provider/domain/entities/provider_entity.dart';
import 'package:prozone_app/features/provider/domain/repositories/provider_repository.dart';
import 'package:prozone_app/features/provider/domain/use_cases/get_all_providers_usecase.dart';

import '../../../../fixtures/fixture.dart';

class MockProviderRepository extends Mock implements ProviderRepository {}

final ProviderEntity providerEntity = ProviderModel.fromMap(
  json.decode(
    fixture('provider_fixture'),
  ),
);
main() {
  GetAllProvidersUsecase getAllProvidersUsecase;
  MockProviderRepository mockProviderRepository;
  setUp(() {
    mockProviderRepository = MockProviderRepository();
    getAllProvidersUsecase = GetAllProvidersUsecase(
      providerRepository: mockProviderRepository,
    );
  });

  test('should get providers from providerrepository', () async {
    when(mockProviderRepository.getProviders()).thenAnswer(
      (_) async => Right(
        [providerEntity].toList(),
      ),
    );
    final result = await getAllProvidersUsecase();
    expect(result.isRight(), true);
    verify(mockProviderRepository.getProviders());
    verifyNoMoreInteractions(mockProviderRepository);
  });
}
