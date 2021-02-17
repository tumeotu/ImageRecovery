import 'dart:io';
import 'dart:typed_data';

import 'package:photo_manager/photo_manager.dart';

class ModelImage{
  File file;
  Uint8List image;
  bool ticked= false;
  ModelImage(File file, Uint8List image)
  {
    this.image= image;
    this.file= file;
  }
}