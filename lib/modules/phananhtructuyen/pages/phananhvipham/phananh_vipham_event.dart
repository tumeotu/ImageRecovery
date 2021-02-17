import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';

abstract class PhanAnhViPhamEvent extends Equatable {
  const PhanAnhViPhamEvent();

  @override
  List<Object> get props => [];
}

class PhanAnhViPhamEventSelectMedia extends PhanAnhViPhamEvent {
  final ImageSource source;
  const PhanAnhViPhamEventSelectMedia(this.source);

  @override
  List<Object> get props => [source];
}

class PhanAnhViPhamEventSubmit extends PhanAnhViPhamEvent {}
