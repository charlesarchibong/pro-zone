import 'dart:convert';

import 'package:prozone_app/features/provider/data/models/image_format_model.dart';
import 'package:prozone_app/features/provider/domain/entities/image_entity.dart';

class ImageModel extends ImageEntity {
  final int id;
  final String name;
  final String alternativeText;
  final String caption;
  final ImageFormatModel smallImage;
  final ImageFormatModel mediumImage;
  final ImageFormatModel thumbNail;
  ImageModel({
    this.id,
    this.name,
    this.alternativeText,
    this.caption,
    this.smallImage,
    this.mediumImage,
    this.thumbNail,
  }) : super(
          id: id,
          mediumImage: mediumImage,
          name: name,
          smallImage: smallImage,
          thumbNail: thumbNail,
          alternativeText: alternativeText,
          caption: caption,
        );

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'alternativeText': alternativeText,
      'caption': caption,
      'formats': {
        'small': smallImage?.toMap(),
        'medium': mediumImage?.toMap(),
        'thumbnail': thumbNail?.toMap(),
      },
    };
  }

  factory ImageModel.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return ImageModel(
      id: map['id'],
      name: map['name'],
      alternativeText: map['alternativeText'],
      caption: map['caption'],
      smallImage: ImageFormatModel.fromMap(map['formats']['small']),
      mediumImage: ImageFormatModel.fromMap(map['formats']['medium']),
      thumbNail: ImageFormatModel.fromMap(map['formats']['thumbnail']),
    );
  }

  String toJson() => json.encode(toMap());

  factory ImageModel.fromJson(String source) =>
      ImageModel.fromMap(json.decode(source));
}

class ImageModelList {
  final List<ImageModel> list;

  ImageModelList({this.list});

  factory ImageModelList.fromJson(List parsedJson) {
    List<ImageModel> list =
        parsedJson.map((i) => ImageModel.fromMap(i)).toList();
    return ImageModelList(list: list);
  }
}
