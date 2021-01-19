import 'dart:convert';

import 'package:prozone_app/features/provider/domain/entities/provider_type_entity.dart';

class ProviderTypeModel extends ProviderTypeEntity {
  ProviderTypeModel({
    int id,
    String name,
  }) : super(
          id: id,
          name: name,
        );

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
    };
  }

  factory ProviderTypeModel.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return ProviderTypeModel(
      id: map['id'],
      name: map['name'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ProviderTypeModel.fromJson(String source) =>
      ProviderTypeModel.fromMap(json.decode(source));
}
