import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:prozone_app/features/provider/domain/entities/image_format_entity.dart';

class ImageEntity extends Equatable {
  final int id;
  final String name;
  final String alternativeText;
  final String caption;
  final ImageFormatEntity smallImage;
  final ImageFormatEntity mediumImage;
  final ImageFormatEntity thumbNail;

  ImageEntity({
    @required this.name,
    @required this.id,
    this.alternativeText,
    this.caption,
    @required this.mediumImage,
    @required this.smallImage,
    @required this.thumbNail,
  });

  @override
  List<Object> get props => [
        name,
        id,
        alternativeText,
        caption,
        smallImage,
        mediumImage,
        thumbNail,
      ];
}
