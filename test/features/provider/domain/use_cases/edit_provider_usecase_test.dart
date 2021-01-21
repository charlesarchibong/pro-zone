import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:prozone_app/features/provider/data/models/provider_model.dart';
import 'package:prozone_app/features/provider/domain/entities/provider_entity.dart';
import 'package:prozone_app/features/provider/domain/repositories/provider_repository.dart';
import 'package:prozone_app/features/provider/domain/use_cases/edit_provider_usecase.dart';

import '../../../../fixtures/fixture.dart';

class MockProviderRepository extends Mock implements ProviderRepository {}

final ProviderEntity providerEntity = ProviderModel.fromMap(
  json.decode(
    fixture('provider_fixture'),
  ),
);
main() {
  EditProviderUseCase editProviderUseCase;
  MockProviderRepository mockProviderRepository;
  setUp(() {
    mockProviderRepository = MockProviderRepository();
    editProviderUseCase = EditProviderUseCase(
      providerRepository: mockProviderRepository,
    );
  });

  test('should edit provider from providerrepository', () async {
    when(mockProviderRepository.updateProvider(any)).thenAnswer(
      (_) async => Right(
        providerEntity,
      ),
    );
    final result = await editProviderUseCase(providerEntity);
    expect(result.isRight(), true);
    verify(mockProviderRepository.updateProvider(any));
    verifyNoMoreInteractions(mockProviderRepository);
  });
}
