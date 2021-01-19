import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:prozone_app/features/provider/domain/entities/image_entity.dart';
import 'package:prozone_app/features/provider/domain/entities/provider_type_entity.dart';
import 'package:prozone_app/features/provider/domain/entities/state_entity.dart';

class ProviderEntity extends Equatable {
  final int id;
  final String name;
  final String description;
  final int rating;
  final String address;
  final String activeStatus;
  final ProviderTypeEntity providerTypeEntity;
  final StateEntity state;
  final List<ImageEntity> images;

  ProviderEntity({
    @required this.id,
    @required this.name,
    this.description,
    @required this.rating,
    @required this.address,
    this.activeStatus,
    this.providerTypeEntity,
    this.state,
    this.images,
  });

  @override
  List<Object> get props => [
        id,
        name,
        description,
        rating,
        address,
        activeStatus,
        providerTypeEntity,
        state,
        images
      ];
}
