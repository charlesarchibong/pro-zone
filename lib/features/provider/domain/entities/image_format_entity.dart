import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class ImageFormatEntity extends Equatable {
  final String url;
  ImageFormatEntity({
    @required this.url,
  });
  @override
  List<Object> get props => [url];
}
