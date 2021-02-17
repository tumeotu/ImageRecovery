import 'package:image_recovery/modules/giayphepxaydung/model/giayphepxaydung.dart';
import 'package:image_recovery/modules/giayphepxaydung/model/googlemap_response.dart';

abstract class GiayPhepXayDungDataSource{
  Future<GiayPhepXayDung> getGiayPhepXayDung(String lat, String lng, String bankinh);
  Future<Results> getAddressFromLocation(String lat, String lng);
  Future<List<Results>> SearchAddress(String query);
  Future<String> DownLoadFile(String url);

}