import 'dart:typed_data';

import 'package:flutter/widgets.dart';

class ImageResultDetect
{
  Uint8List ImageDetect;
  String age;
  String gender;
  String emotion;
  ImageResultDetect(Uint8List image, String age, String gender, String emotion)
  {
    this.ImageDetect= image;
    this.age= age;
    this.gender= gender;
    this.emotion= emotion;
  }
}