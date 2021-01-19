import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class ProviderTypeEntity extends Equatable {
  final int id;
  final String name;

  ProviderTypeEntity({
    @required this.id,
    @required this.name,
  });

  @override
  List<Object> get props => [id, name];
}
