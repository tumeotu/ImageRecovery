import 'dart:io';

import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class PhotoViewerWidget extends StatefulWidget {
  final String pathFile;
  final String urlFile;

  PhotoViewerWidget({Key key, this.pathFile, this.urlFile}) : super(key: key);

  @override
  _PhotoViewerWidgetState createState() => _PhotoViewerWidgetState();
}

class _PhotoViewerWidgetState extends State<PhotoViewerWidget> {
  @override
  Widget build(BuildContext context) {
    ImageProvider imageProvider;
    if (widget.pathFile.isNotEmpty) {
      imageProvider = FileImage(File(widget.pathFile));
    } else {
      imageProvider = NetworkImage(widget.urlFile);
    }
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Container(
                child: PhotoView(
              minScale: PhotoViewComputedScale.contained,
              maxScale: PhotoViewComputedScale.covered * 2.5,
              imageProvider: imageProvider,
            )),
            Container(
              child: Align(
                alignment: Alignment.topLeft,
                child: FlatButton(
                  onPressed: () => Navigator.pop(context),
                  shape: RoundedRectangleBorder(
                      borderRadius:
                      BorderRadius.all(Radius.circular(10.0))),
                  color: Colors.black26,
                  child: Text(
                    "Trở về",
                    style: TextStyle(
                        color: Colors.white, fontSize: 16.0),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
