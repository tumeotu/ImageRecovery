import 'dart:io';
import 'dart:typed_data';

import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_recovery/data/apis/history_recover/HistoryDataSource.dart';
import 'package:image_recovery/pages/RecoverImageResult/model/ImageResult.dart';
import 'package:image_recovery/pages/home/model/ModelImage.dart';

abstract class HistoryRecoverEvent extends Equatable {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class HistoryRecoverEventStart extends HistoryRecoverEvent{
  int page;
  int ID;
  bool isGetDetail;
  BuildContext context;
  List<HistoryDatasourceModel> images;
  HistoryRecoverEventStart(this.page,this.ID ,this.isGetDetail, this.context,this.images);
}