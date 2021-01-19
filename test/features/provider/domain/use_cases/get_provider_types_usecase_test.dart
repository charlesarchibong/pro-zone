import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:prozone_app/features/provider/data/models/provider_type_model.dart';
import 'package:prozone_app/features/provider/domain/repositories/provider_repository.dart';
import 'package:prozone_app/features/provider/domain/use_cases/get_provider_types_usecase.dart';

import '../../../../fixtures/fixture.dart';

class MockProviderRepository extends Mock implements ProviderRepository {}

final ProviderTypeModel providerTypeModel = ProviderTypeModel.fromMap(
  json.decode(
    fixture('provider_type_fixture'),
  ),
);
main() {
  GetProviderTypesUsecase getProviderTypesUsecase;
  MockProviderRepository mockProviderRepository;
  setUp(() {
    mockProviderRepository = MockProviderRepository();
    getProviderTypesUsecase = GetProviderTypesUsecase(
      providerRepository: mockProviderRepository,
    );
  });

  test('should get provider types from providerrepository', () async {
    when(mockProviderRepository.getProviderTypes()).thenAnswer(
      (_) async => Right(
        [providerTypeModel].toList(),
      ),
    );
    final result = await getProviderTypesUsecase();
    expect(result.isRight(), true);
    verify(mockProviderRepository.getProviderTypes());
    verifyNoMoreInteractions(mockProviderRepository);
  });
}
