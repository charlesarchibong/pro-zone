import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:prozone_app/features/provider/data/models/state_model.dart';
import 'package:prozone_app/features/provider/domain/entities/state_entity.dart';

import '../../../../fixtures/fixture.dart';

main() {
  StateModel stateModelTest = StateModel(
    id: 3,
    name: "Edo",
  );
  test('should test if providerTypeModel is a subclass of providerTypeEntity',
      () {
    expect(stateModelTest, isA<StateEntity>());
  });
  group('JsonSerialization', () {
    test("should test is the state class gotten from json response is valid",
        () {
      StateModel stateModel = StateModel.fromMap(
        json.decode(
          fixture(
            "state_fixture",
          ),
        ),
      );
      expect(stateModel, equals(stateModelTest));
    });

    test('should test if the object converted to json is valid', () {
      expect(
          stateModelTest.toMap(),
          equals(
            json.decode(
              fixture(
                "state_fixture",
              ),
            ),
          ));
    });
  });
}
