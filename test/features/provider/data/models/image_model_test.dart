import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:prozone_app/features/provider/data/models/image_model.dart';
import 'package:prozone_app/features/provider/domain/entities/image_entity.dart';

import '../../../../fixtures/fixture.dart';

void main() {
  ImageModel imageModel = ImageModel(
    id: 1,
    mediumImage: null,
    alternativeText: "Test Image",
    caption: "Test",
    name: "image model",
    smallImage: null,
    thumbNail: null,
  );
  test('should test is ImageModel is a subclass of ImageEnity', () {
    expect(imageModel, isA<ImageEntity>());
  });

  group("JsonSerializationTest", () {
    test(
        'should confirm if the image model was successfully converted from the json response',
        () {
      ImageModel imageModel = ImageModel.fromMap(
        json.decode(
          fixture('image_fixture'),
        ),
      );
      print(imageModel.toJson());
      expect(
        imageModel,
        isA<ImageModel>(),
      );
    });
  });
}
