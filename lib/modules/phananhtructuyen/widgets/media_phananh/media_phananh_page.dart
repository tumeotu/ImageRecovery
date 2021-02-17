import 'dart:io';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_recovery/constants.dart';
import 'package:image_recovery/modules/phananhtructuyen/models/media_phananh_model.dart';
import 'package:image_recovery/modules/phananhtructuyen/pages/phananhvipham/phananh_vipham.dart';
import 'package:image_recovery/modules/phananhtructuyen/widgets/widget.dart';

class MediaPhanAnhPage extends StatelessWidget {
  final BuildContext phanAnhContext;

  const MediaPhanAnhPage({this.phanAnhContext});

  @override
  Widget build(BuildContext context) {
    /// width = (screen width - (padding 10 right and left)) / 3 item max
    double width = (MediaQuery.of(context).size.width - (10.0 + 10.0)) / 3;
    return BlocBuilder<MediaPhanAnhCubit, MediaPhanAnhState>(
        builder: (context, state) {
      int length = state.mediaPhanAnhs.length;

      this
          .phanAnhContext
          .bloc<PhanAnhViPhamCubit>()
          .mediasSelected(state.mediaPhanAnhs);
      return Container(
        height: 68,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: length,
          itemBuilder: (context, index) => SizedBox(
            width: width,
            child: Container(
              margin: (index < length - 1)
                  ? EdgeInsets.only(right: 8.0)
                  : EdgeInsets.zero,
              child: _MediaItem(
                index: index,
                mediaPhanAnh: state.mediaPhanAnhs.elementAt(index),
              ),
            ),
          ),
        ),
      );
    });
  }
}

class _MediaItem extends StatelessWidget {
  final index;
  final MediaPhanAnhModel mediaPhanAnh;

  const _MediaItem({this.index, this.mediaPhanAnh});

  @override
  Widget build(BuildContext context) {
    Widget widgetImage;
    if (mediaPhanAnh?.pathFile?.isNotEmpty == true) {
      Widget imageFile;
      if (mediaPhanAnh.typeFile != "mp4") {
        imageFile = Image.file(File(mediaPhanAnh.pathFile), fit: BoxFit.cover);
      } else {
        imageFile = Image(
            image: AssetImage(video_default_image), fit: BoxFit.fitHeight);
      }
      widgetImage = ClipRRect(
        borderRadius: BorderRadius.circular(8.0),
        child: imageFile,
      );
    } else if (mediaPhanAnh?.isLoading == true) {
      widgetImage = Center(
        child: CircularProgressIndicator(),
      );
    } else {
      widgetImage = Icon(Icons.camera_alt, color: Color(0xff9fabb1));
    }

    return GestureDetector(
      onTap: () => mediaSelection(
          index: index,
          buildContext: context,
          pathFile: mediaPhanAnh?.pathFile,
          typeFile: mediaPhanAnh?.typeFile),
      child: Stack(
        children: <Widget>[
          Opacity(
            opacity: 0.3499999940395355,
            child: Container(
                decoration: new BoxDecoration(
              color: Color(0xff9fabb1),
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                    color: Color(0x00000000),
                    offset: Offset(0, 3),
                    blurRadius: 6,
                    spreadRadius: 0)
              ],
            )),
          ),
          Positioned.fill(
            child: widgetImage,
          ),
        ],
      ),
    );
  }

  Future mediaSelection(
      {int index,
      BuildContext buildContext,
      String pathFile,
      String typeFile}) async {
    /// pathFile is null: chưa chọn file
    if (pathFile == null) {
      showDialog(
          context: buildContext,
          builder: (context) {
            return Dialog(
              child: Container(
                height: 192,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      "Chọn chức năng",
                      style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    FlatButton(
                      onPressed: () => buildContext
                          .bloc<MediaPhanAnhCubit>()
                          .showMediaSelection(
                              index: index,
                              context: buildContext,
                              loaiChucNang: MediaPhanAnhLoaiChucNang.Camera),
                      child: Container(
                        child: Row(

                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.camera_alt,
                              size: 30,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              "Chụp hình",
                              style: TextStyle(fontSize: 18.0),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Divider(
                      height: 1,
                      color: Colors.black,
                      indent: 55,
                    ),
                    FlatButton(
                      onPressed: () => buildContext
                          .bloc<MediaPhanAnhCubit>()
                          .showMediaSelection(
                              index: index,
                              context: buildContext,
                              loaiChucNang: MediaPhanAnhLoaiChucNang.Album),
                      child: Container(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.perm_media,
                              size: 30,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              "Album",
                              style: TextStyle(fontSize: 18.0),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Divider(
                      height: 1,
                      color: Colors.black,
                      indent: 55,
                    ),
                    FlatButton(
                      onPressed: () => buildContext
                          .bloc<MediaPhanAnhCubit>()
                          .showMediaSelection(
                              index: index,
                              context: buildContext,
                              loaiChucNang: MediaPhanAnhLoaiChucNang.Video),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.video_call,
                            size: 30,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            "Quay phim",
                            style: TextStyle(fontSize: 18.0),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          });
    } else {
      showDialog(
          context: buildContext,
          builder: (context) {
            return Dialog(
              child: Container(
                height: 140,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      "Chọn chức năng",
                      style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    FlatButton(
                      onPressed: () => buildContext
                          .bloc<MediaPhanAnhCubit>()
                          .viewMedia(
                              index: index,
                              context: buildContext,
                              pathFile: pathFile,
                              typeFile: typeFile),
                      child: Container(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.folder_open,
                              size: 30,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              "Xem tập tin",
                              style: TextStyle(fontSize: 18.0),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Divider(
                      height: 1,
                      color: Colors.black,
                      indent: 55,
                    ),
                    FlatButton(
                      onPressed: () => buildContext
                          .bloc<MediaPhanAnhCubit>()
                          .removeMedia(index: index),
                      child: Container(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.remove_circle_outline,
                              size: 30,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              "Xóa tập tin",
                              style: TextStyle(fontSize: 18.0),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          });
    }
  }
}
