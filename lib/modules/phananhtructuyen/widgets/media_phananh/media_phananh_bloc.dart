import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_recovery/constants.dart';
import 'package:image_recovery/modules/phananhtructuyen/models/media_phananh_model.dart';
import 'package:image_recovery/modules/phananhtructuyen/widgets/widget.dart';
import 'package:image_recovery/routes.dart';
import 'package:image_recovery/utils/navigations/navigation_datasource.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

class MediaPhanAnhCubit extends Cubit<MediaPhanAnhState> {
  final ImagePicker picker;
  final NavigationDataSource navigationDataSource;
  final int maxFile;

  MediaPhanAnhCubit(
      {this.picker, this.navigationDataSource, this.maxFile = 3})
      : assert(picker != null),
        super(MediaPhanAnhState().initMediaPhanAnhs());

  void showMediaSelection(
      {int index,
      BuildContext context,
      MediaPhanAnhLoaiChucNang loaiChucNang}) async {
    String pathFile;
    switch (loaiChucNang) {
      case MediaPhanAnhLoaiChucNang.Camera:
        PickedFile pickedFile =
            await picker.getImage(source: ImageSource.camera);

        Navigator.pop(context);

        pathFile = pickedFile.path;

        break;
      case MediaPhanAnhLoaiChucNang.Album:
        PickedFile pickedFile =
            await picker.getImage(source: ImageSource.gallery);

        Navigator.pop(context);

        pathFile = pickedFile.path;

        break;

      case MediaPhanAnhLoaiChucNang.Video:
        final response = await navigationDataSource
            .pushNavigation<String>(NamePage.camera_widget);

        Navigator.pop(context);

        pathFile = response;
        break;
    }

    if (pathFile == null) return;

    try {
      var filename = pathFile.split('/').last;
      var typeFile = pathFile.split('.').last;

      /// nhỏ hơn (maxFile - 1) để chặn k add media mới

      /// get media trước
      List<MediaPhanAnhModel> medias = state.mediaPhanAnhs;
      medias[index] = medias.elementAt(index).copyWith(isLoading: true);

      ///max k cho add nữa
      if (index < (maxFile - 1)) {
        medias..add(MediaPhanAnhModel(isShow: true));
      }

      emit(state.cloneWith(
        mediaPhanAnhs: medias,
      ));

      http.ByteStream stream = await uploadFile(pathFile, filename);
      if (stream != null) {
        stream.transform(utf8.decoder).listen((value) {
          medias[index] = medias.elementAt(index).copyWith(
              pathFile: pathFile,
              typeFile: typeFile,
              urlFile: value,
              isLoading: false);

          emit(state.cloneWith(
            mediaPhanAnhs: medias,
          ));
        });
      } else {
        medias[index] = medias.elementAt(index).copyWith(isLoading: false);

        if (index < (maxFile - 1)) {
          medias..removeAt(index + 1);
        }

        emit(state.cloneWith(
          mediaPhanAnhs: medias,
        ));
      }
    } on Exception catch (ex) {
      print("lỗi $ex");
    }
  }

  void viewMedia(
      {int index,
      BuildContext context,
      String pathFile,
      String typeFile}) async {
    if (typeFile != 'mp4') {
      final Map<String, dynamic> param = {"pathFile": pathFile};
      await navigationDataSource.pushNavigation(NamePage.photoviewer_widget,
          params: param);

      Navigator.pop(context);
    } else {
      final Map<String, dynamic> param = {"pathFile": pathFile};
      await navigationDataSource.pushNavigation(NamePage.videoplayer_widget,
          params: param);

      Navigator.pop(context);
    }
  }

  void removeMedia({int index, BuildContext context}) {
    List<MediaPhanAnhModel> medias = state.mediaPhanAnhs;
    medias..removeAt(index);

    emit(state.cloneWith(
      mediaPhanAnhs: medias,
    ));
    // for (int i = 0; i < medias.length; i++) {
    //   if (i < index) {
    //   } else if (i == index) {
    //     medias..removeAt(i);
    //   } else {
    //     var item = medias.elementAt(i);
    //     medias
    //       ..removeAt(i)
    //       ..insert(i - 1, item);
    //   }
    // }
    Navigator.pop(context);
  }

  Future<http.ByteStream> uploadFile(String path, String filename) async {

    var postUri = Uri.parse('URL_UPLOADFILE');
    var request = new http.MultipartRequest("POST", postUri);
    request.fields['PhanLoai'] = 'VPTT';

    Uri uri = Uri(path: path);
    request.files.add(new http.MultipartFile.fromBytes(
        'file', await File.fromUri(uri).readAsBytes(),
        filename: filename));

    try {
      http.StreamedResponse streamedResponse = await request.send();
      if (streamedResponse.statusCode != 200) {
        return null;
      }
      return streamedResponse.stream;
    } catch (e) {}
  }
}
