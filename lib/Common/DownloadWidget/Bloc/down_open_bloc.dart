// import 'dart:async';
// import 'dart:convert';
// import 'dart:io';
// import 'package:dio/dio.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:image_recovery/Common/DownloadWidget/Event/down_open_event.dart';
// import 'package:image_recovery/Common/DownloadWidget/State/down_open_state.dart';
// import 'package:open_file/open_file.dart';
// import 'package:path_provider/path_provider.dart';
//
//
// class DownLoadBloc extends Bloc<DownLoadEvent, DownLoadState> {
//
//   DownLoadBloc() : super(DownLoadStateInitial());
//
//   StreamController<double> controller = StreamController<double>();
//   Stream<double> get outCounter => controller.stream;
//   StreamSink<double> get outCounterSink => controller.sink;
//
//   @override
//   void dispose() {
//     controller.close();
//   }
//   @override
//   Stream<DownLoadState> mapEventToState(DownLoadEvent event) async* {
//     try {
//       if (event is DownLoadEventStart) {
//         String url=event.url;
//         var temp = url.split('/');
//         var fileName = temp[temp.length - 1];
//         final directory = await getApplicationDocumentsDirectory();
//         var savePath = '${directory.path}/${fileName}';
//         if (await File(savePath).exists()) {
//           yield DownLoadStateStart(true);
//         } else {
//           yield DownLoadStateStart(false);
//         }
//       }
//       if (event is DownLoadEventDownLoad) {
//         yield DownLoadStateProgress(0,null);
//         String URL = event.BASE_URL;
//         String url=event.url;
//         var dio = Dio();
//         dio.interceptors.add(LogInterceptor());
//         var temp = url.split('/');
//         var fileName = temp[temp.length - 1];
//         final directory = await getApplicationDocumentsDirectory();
//         var savePath = '${directory.path}/${fileName}';
//         var param = new Map<String, String>();
//         param['fileUrl'] = url;
//         param['fileName'] = fileName;
//         try {
//           Response response = await dio.post(URL,
//               onReceiveProgress:showDownloadProgress,
//               data: param,
//               options: Options(
//                   contentType: Headers.formUrlEncodedContentType,
//                   responseType: ResponseType.bytes,
//                   followRedirects: false,
//                   receiveTimeout: 0)
//           );
//           print(response.headers);
//           File file = File(savePath);
//           var raf = file.openSync(mode: FileMode.write);
//           raf.writeFromSync(response.data);
//           await raf.close();
//           OpenFile.open(savePath);
//           yield DownLoadStateProgress(100,savePath);
//         } catch (e) {
//           yield DownLoadStateFailure();
//         }
//       }
//       if (event is DownLoadEventOpen) {
//         //
//
//       }
//     } catch (exception) {
//       yield DownLoadStateFailure();
//     }
//   }
//   Future<String> download2(String BASE_URL, String url) async {
//     String URL = BASE_URL + '/api/DownloadFileAlfresco/';
//     //String URL =  "https://cdn.jsdelivr.net/gh/flutterchina/flutter-in-action@1.0/docs/imgs/book.jpg";;
//     url = 'Alfresco/HocMon/CPXD/49/2020/7/CPXD_49_20200715114132_bv(1).jpg';
//     var dio = Dio();
//     dio.interceptors.add(LogInterceptor());
//     var temp = url.split('/');
//     var fileName = temp[temp.length - 1];
//     //var fileName = 'book.jpg';
//     final directory = await getApplicationDocumentsDirectory();
//     var savePath = '${directory}/${fileName}';
//     var param = new Map<String, String>();
//     param['fileUrl'] = url;
//     param['fileName'] = fileName;
//     try {
//       Response response = await dio.post(URL,
//           onReceiveProgress: showDownloadProgress,
//           data: param,
//           options: Options(contentType: Headers.formUrlEncodedContentType)
//       );
//       print(response.headers);
//       File file = File(savePath);
//       var raf = file.openSync(mode: FileMode.write);
//       // response.data is List<int> type
//       raf.writeFromSync(response.data);
//       await raf.close();
//       return savePath;
//     } catch (e) {
//       print(e);
//       return 'ERROR';
//     }
//   }
//   showDownloadProgress(received, total) async{
//     if (total != -1) {
//       var value=(received / total * 100.0);
//       print((received / total * 100).toStringAsFixed(0) + "%");
//       var y= await Future.delayed(Duration(seconds: 1));
//       outCounterSink.add(value);
//       //yield DownLoadStateProgress(value,null);
//     }
//   }
// //  showDownloadProgress (received, total)async* {
// //    if (total != -1) {
// //      var value=(received / total * 100).toStringAsFixed(0);
// //      yield DownLoadStateProgress(value,null);
// //    }
// //  }
// }
