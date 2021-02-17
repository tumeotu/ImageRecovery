import 'package:image_recovery/data/apis/history_recover/HistoryDataSource.dart';

class Group{
  int count;
  List<HistoryDatasourceModel> items;
  Group(this.count, this.items)
  {
    this.items= items;
    this.count= count;
  }
}