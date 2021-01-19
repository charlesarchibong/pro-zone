import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:prozone_app/features/provider/data/models/image_format_model.dart';
import 'package:prozone_app/features/provider/domain/entities/image_format_entity.dart';

import '../../../../fixtures/fixture.dart';

main() {
  ImageFormatModel imageFormatModelTest = ImageFormatModel(
    url:
        'https://res.cloudinary.com/maxii/image/upload/v1594183736/large_FVRH_Exterior_e1391182892802_325e660fdd.jpg',
  );
  test('should test if ImageFormatModel is a subclass of ImageFormatEntity',
      () {
    expect(imageFormatModelTest, isA<ImageFormatEntity>());
  });
  group('JsonSerialization', () {
    test(
        "should test is the imageformat class gotten from json response is valid",
        () {
      ImageFormatModel imageFormatModel = ImageFormatModel.fromMap(
        json.decode(
          fixture(
            "image_format_fixture",
          ),
        ),
      );
      expect(imageFormatModel, equals(imageFormatModelTest));
    });

    test('should test if the object converted to json is valid', () {
      expect(
          imageFormatModelTest.toMap(),
          equals(
            json.decode(
              fixture(
                "image_format_fixture",
              ),
            ),
          ));
    });
  });
}
