import 'dart:typed_data';

import 'package:flutter/widgets.dart';

class ImageResult
{
  Uint8List OldImage;
  Uint8List NewImage;
  double currentWidth=100.0;
  double startWidth=40.0;
  double startDx;
  double dx=0.0;
  double minWidth=48.0;
  GlobalKey keyRed = GlobalKey();
  ImageResult(Uint8List oldImage, Uint8List newImage)
  {
    this.OldImage= oldImage;
    this.NewImage= newImage;
  }
}