import 'dart:convert';

import 'package:prozone_app/features/provider/domain/entities/state_entity.dart';

class StateModel extends StateEntity {
  StateModel({
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

  factory StateModel.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return StateModel(
      id: map['id'],
      name: map['name'],
    );
  }

  String toJson() => json.encode(toMap());

  factory StateModel.fromJson(String source) =>
      StateModel.fromMap(json.decode(source));
}
