import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class StateEntity extends Equatable {
  final int id;
  final String name;

  StateEntity({
    @required this.id,
    @required this.name,
  });

  @override
  List<Object> get props => [id, name];
}
