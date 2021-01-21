import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:prozone_app/features/provider/data/models/state_model.dart';
import 'package:prozone_app/features/provider/domain/repositories/provider_repository.dart';
import 'package:prozone_app/features/provider/domain/use_cases/get_states_usecase.dart';

import '../../../../fixtures/fixture.dart';

class MockProviderRepository extends Mock implements ProviderRepository {}

final StateModel stateModel = StateModel.fromMap(
  json.decode(
    fixture('state_fixture'),
  ),
);
main() {
  GetStatesUsecase getStatesUsecase;
  MockProviderRepository mockProviderRepository;
  setUp(() {
    mockProviderRepository = MockProviderRepository();
    getStatesUsecase = GetStatesUsecase(
      providerRepository: mockProviderRepository,
    );
  });

  test('should get states from providerrepository', () async {
    when(mockProviderRepository.getStates()).thenAnswer(
      (_) async => Right(
        [stateModel].toList(),
      ),
    );
    final result = await getStatesUsecase();
    expect(result.isRight(), true);
    verify(mockProviderRepository.getStates());
    verifyNoMoreInteractions(mockProviderRepository);
  });
}
