import 'package:equatable/equatable.dart';
import 'package:image_recovery/modules/phananhtructuyen/models/media_phananh_model.dart';

class MediaPhanAnhState {
  final List<MediaPhanAnhModel> mediaPhanAnhs;
  final bool isSelectedMedia;

  const MediaPhanAnhState({this.mediaPhanAnhs, this.isSelectedMedia});

  MediaPhanAnhState initMediaPhanAnhs() {
    List<MediaPhanAnhModel> mediaPhanAnhs = [];
    mediaPhanAnhs.add(MediaPhanAnhModel(isShow: true));
    return MediaPhanAnhState(mediaPhanAnhs: mediaPhanAnhs);
  }

  MediaPhanAnhState cloneWith({mediaPhanAnhs, isSelectedMedia}) =>
      MediaPhanAnhState(
        mediaPhanAnhs: mediaPhanAnhs ?? this.mediaPhanAnhs,
        isSelectedMedia: isSelectedMedia ?? this.isSelectedMedia,
      );
}
