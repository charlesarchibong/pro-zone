import 'dart:convert';

import 'package:prozone_app/features/provider/domain/entities/image_format_entity.dart';

class ImageFormatModel extends ImageFormatEntity {
  ImageFormatModel({
    String url,
  }) : super(
          url: url,
        );

  Map<String, dynamic> toMap() {
    return {
      'url': url,
    };
  }

  factory ImageFormatModel.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return ImageFormatModel(
      url: map['url'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ImageFormatModel.fromJson(String source) =>
      ImageFormatModel.fromMap(json.decode(source));
}
