import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:prozone_app/features/provider/data/models/image_format_model.dart';
import 'package:prozone_app/features/provider/data/models/image_model.dart';
import 'package:prozone_app/features/provider/data/models/provider_model.dart';
import 'package:prozone_app/features/provider/data/models/provider_type_model.dart';
import 'package:prozone_app/features/provider/data/models/state_model.dart';

import '../../../../fixtures/fixture.dart';

main() {
  ProviderModel providerModelTest = ProviderModel(
    id: 2,
    name: "Reddington Hospital",
    activeStatus: "Active",
    address: "Somewhere in Lekki",
    description: "A Hospital that is red",
    rating: 5,
    state: StateModel(
      id: 1,
      name: "Lagos",
    ),
    providerTypeModel: ProviderTypeModel(
      id: 1,
      name: "Hospital",
    ),
    images: [
      ImageModel(
        id: 3,
        alternativeText: "",
        name: "hospital",
        caption: "",
        mediumImage: ImageFormatModel(
          url:
              "https://res.cloudinary.com/maxii/image/upload/v1594453523/medium_hospital_7507b92df8.jpg",
        ),
        smallImage: ImageFormatModel(
          url:
              "https://res.cloudinary.com/maxii/image/upload/v1594453523/small_hospital_7507b92df8.jpg",
        ),
        thumbNail: ImageFormatModel(
          url:
              "https://res.cloudinary.com/maxii/image/upload/v1594453523/thumbnail_hospital_7507b92df8.jpg",
        ),
      ),
    ],
  );
  test('should test if providerModel is a subclass of providerTypeEntity', () {
    expect(providerModelTest, isA<ProviderModel>());
  });
  group('JsonSerialization', () {
    test("should test is the provider class gotten from json response is valid",
        () {
      ProviderModel providerTypeModel = ProviderModel.fromMap(
        json.decode(
          fixture(
            "provider_fixture",
          ),
        ),
      );
      print(providerTypeModel.toJson());
      expect(providerTypeModel, equals(providerModelTest));
    });

    test('should test if the object converted to json is valid', () {
      expect(
          providerModelTest.toMap(),
          equals(
            json.decode(
              fixture(
                "provider_fixture",
              ),
            ),
          ));
    });
  });
}
