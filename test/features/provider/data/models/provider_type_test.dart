import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:prozone_app/features/provider/data/models/provider_type_model.dart';
import 'package:prozone_app/features/provider/domain/entities/provider_type_entity.dart';

import '../../../../fixtures/fixture.dart';

main() {
  ProviderTypeModel providerTypeModelTest = ProviderTypeModel(
    id: 1,
    name: "Hospital",
  );
  test('should test if providerTypeModel is a subclass of providerTypeEntity',
      () {
    expect(providerTypeModelTest, isA<ProviderTypeEntity>());
  });
  group('JsonSerialization', () {
    test(
        "should test is the providertype class gotten from json response is valid",
        () {
      ProviderTypeModel providerTypeModel = ProviderTypeModel.fromMap(
        json.decode(
          fixture(
            "provider_type_fixture",
          ),
        ),
      );
      expect(providerTypeModel, equals(providerTypeModelTest));
    });

    test('should test if the object converted to json is valid', () {
      expect(
          providerTypeModelTest.toMap(),
          equals(
            json.decode(
              fixture(
                "provider_type_fixture",
              ),
            ),
          ));
    });
  });
}
