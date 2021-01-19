import 'dart:convert';

import 'package:prozone_app/features/provider/data/models/image_model.dart';
import 'package:prozone_app/features/provider/data/models/provider_type_model.dart';
import 'package:prozone_app/features/provider/data/models/state_model.dart';
import 'package:prozone_app/features/provider/domain/entities/provider_entity.dart';

class ProviderModel extends ProviderEntity {
  final int id;
  final String name;
  final String description;
  final int rating;
  final String address;
  final String activeStatus;
  final ProviderTypeModel providerTypeModel;
  final StateModel state;
  final List<ImageModel> images;
  ProviderModel({
    this.id,
    this.name,
    this.description,
    this.rating,
    this.address,
    this.activeStatus,
    this.providerTypeModel,
    this.state,
    this.images,
  }) : super(
          address: address,
          id: id,
          name: name,
          rating: rating,
          activeStatus: activeStatus,
          description: description,
          images: images,
          providerTypeEntity: providerTypeModel,
          state: state,
        );

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'rating': rating,
      'address': address,
      'active_status': activeStatus,
      'provider_type': providerTypeModel?.toMap(),
      'state': state?.toMap(),
      'images': images?.map((x) => x?.toMap())?.toList(),
    };
  }

  factory ProviderModel.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return ProviderModel(
      id: map['id'],
      name: map['name'],
      description: map['description'],
      rating: map['rating'],
      address: map['address'],
      activeStatus: map['active_status'],
      providerTypeModel: ProviderTypeModel.fromMap(map['provider_type']),
      state: StateModel.fromMap(map['state']),
      images: List<ImageModel>.from(
        map['images']?.map(
          (x) => ImageModel.fromMap(x),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory ProviderModel.fromJson(String source) => ProviderModel.fromMap(
        json.decode(source),
      );
}
