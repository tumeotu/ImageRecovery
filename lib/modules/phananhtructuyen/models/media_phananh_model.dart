import 'package:equatable/equatable.dart';

class MediaPhanAnhModel extends Equatable {
  final String pathFile;
  final String urlFile;
  final bool isLoading;
  final bool isShow;
  final String typeFile;

  const MediaPhanAnhModel(
      {this.pathFile,
      this.urlFile,
      this.isLoading,
      this.isShow,
      this.typeFile});

  MediaPhanAnhModel copyWith(
          {pathFile, urlFile, isLoading, isShow, typeFile}) =>
      MediaPhanAnhModel(
          pathFile: pathFile ?? this.pathFile,
          urlFile: urlFile ?? this.urlFile,
          isLoading: isLoading ?? this.isLoading,
          isShow: isShow ?? this.isShow,
          typeFile: typeFile ?? this.typeFile);

  @override
  List<Object> get props => [pathFile, urlFile, isLoading, isShow, typeFile];
}
