import 'dart:io';

import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:image_recovery/constants.dart';
import 'package:image_recovery/data/apis/quanlyxaydung/qlxd_datasource.dart';
import 'package:image_recovery/modules/giayphepxaydung/model/giayphepxaydung.dart';
import 'package:image_recovery/modules/giayphepxaydung/model/googlemap_response.dart';
import 'package:image_recovery/utils/networks/network_datasource.dart';
import 'package:path_provider/path_provider.dart';

final getIt = GetIt.instance;

class GiayPhepXayDungResponse extends GiayPhepXayDungDataSource {
  NetworkDataSource network;

  GiayPhepXayDungResponse() {
    this.network = getIt.get<NetworkDataSource>();
  }

  @override
  Future<GiayPhepXayDung> getGiayPhepXayDung(
      String lat, String lng, String bankink) async {
    try {
      //final url = BASE_URL + '/api/GiayPhepXayDungOnMap';
      final url = 'http://192.168.1.124:8001/ServiceAPI/api/ThongTinQLXDOnMap';
      var param = new Map<String, String>();
      param['TamHinhTronX'] = lat.toString();
      param['TamHinhTronY'] = lng.toString();
      param['BanKinh'] = bankink.toString();
      final data = await network.post(Uri.parse(url), body: param);
      GiayPhepXayDung giayphepxaydung = GiayPhepXayDung.fromJson(data);
      return giayphepxaydung;
    } catch (Exception) {
      print(Exception);
      return null;
    }
  }

  @override
  Future<Results> getAddressFromLocation(String lat, String lng) async {
    try {
      final url = 'https://maps.googleapis.com/maps/api/geocode/json?'
          'latlng=${lat},${lng}&key=AIzaSyCHVIiGmYCcSD5IhlvCypNAOh_IhUMeqcs';
      var param = new Map<String, String>();
      final data = await network.post(Uri.parse(url), body: param);
      AddressFromLocation location = AddressFromLocation.fromJson(data);
      if (location != null) {
        if (location.results != null) {
          return location?.results[0];
        }
      }
      return null;
    } catch (Exception) {
      print(Exception);
      return null;
    }
  }

  @override
  Future<List<Results>> SearchAddress(String query) async {
    try {
      final url = 'https://maps.googleapis.com/maps/api/place/textsearch/json?'
          'query=${query}&key=AIzaSyCHVIiGmYCcSD5IhlvCypNAOh_IhUMeqcs';
      var param = new Map<String, String>();
      final data = await network.post(Uri.parse(url), body: param);
      AddressFromLocation location = AddressFromLocation.fromJson(data);
      if (location != null) {
        if (location.results != null) {
          return location?.results;
        }
      }
      return null;
    } catch (Exception) {
      print(Exception);
      return null;
    }
  }

  @override
  Future<String> DownLoadFile(String url) async {
    String URL = BASE_URL + '/api/DownloadFileAlfresco/';
    //String URL =  "https://cdn.jsdelivr.net/gh/flutterchina/flutter-in-action@1.0/docs/imgs/book.jpg";;
    url = 'Alfresco/HocMon/CPXD/49/2020/7/CPXD_49_20200715114132_bv(1).jpg';
    var dio = Dio();
    dio.interceptors.add(LogInterceptor());
    var temp = url.split('/');
    var fileName = temp[temp.length - 1];
    //var fileName = 'book.jpg';
    final directory = await getApplicationDocumentsDirectory();
    var savePath = '${directory}/${fileName}';
    var param = new Map<String, String>();
    param['fileUrl'] = url;
    param['fileName'] = fileName;
    try {
      Response response = await dio.post(URL,
          onReceiveProgress: showDownloadProgress,
          data: param,
          options: Options(contentType: Headers.formUrlEncodedContentType)
      );
//      Response response = await dio.get(
//        URL,
//        onReceiveProgress: showDownloadProgress,
//        //Received data with List<int>
//        options: Options(
//            responseType: ResponseType.bytes,
//            followRedirects: false,
//            receiveTimeout: 0),
//      );
      print(response.headers);
      File file = File(savePath);
      var raf = file.openSync(mode: FileMode.write);
      // response.data is List<int> type
      raf.writeFromSync(response.data);
      await raf.close();
    } catch (e) {
      print(e);
    }
  }

  void showDownloadProgress(received, total) {
    if (total != -1) {
      print((received / total * 100).toStringAsFixed(0) + "%");
    }
  }
}
