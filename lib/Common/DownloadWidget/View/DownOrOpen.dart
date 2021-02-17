// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:image_recovery/Common/DownloadWidget/Bloc/down_open_bloc.dart';
// import 'package:image_recovery/Common/DownloadWidget/Event/down_open_event.dart';
// import 'package:image_recovery/Common/DownloadWidget/State/down_open_state.dart';
// import 'package:percent_indicator/circular_percent_indicator.dart';
//
// class DownLoad extends StatelessWidget {
//   final String url;
//   final String BASE_URL;
//   bool IsHasFile;
//   DownLoad({
//     Key key,
//     this.BASE_URL,
//     this.url,
//   }) : super(key: key) {
//   }
//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<DownLoadBloc, DownLoadState>(
//       builder: (context, state) {
//         if(state is DownLoadStateInitial)
//           return Container();
//         else if (state is DownLoadStateStart) {
//           if (state.HasFile) {
//             return _getViewOpenFile(context);
//           } else {
//             return _getViewDowLoad(context);
//           }
//         } else if (state is DownLoadStateProgress) {
//           if (state.filePath == null) {
//             return _GetViewDowLoading();
//           } else {
//             return _getViewOpenFile(context);
//           }
//         } else if (state is DownLoadStateFailure) {
//           return _getViewFailure(context);
//         }
//         return Container();
//       },
//     );
//   }
//
//   Widget _getViewOpenFile(context) {
//     return GestureDetector(
//       onTap: () => {
//         //BlocProvider.of<DownLoadBloc>(context)..add(DownLoadEventDownLoad(this.BASE_URL,this.url))
//       },
//       child:  Container(
//         alignment: Alignment.center,
//         height: 20,
//         width: 40,
//         decoration: BoxDecoration(
//             color: Colors.green,
//             borderRadius: BorderRadius.only(
//               topLeft: Radius.circular(5),
//               topRight: Radius.circular(5),
//               bottomLeft: Radius.circular(5),
//               bottomRight: Radius.circular(5),
//             )
//         ),
//         padding: new EdgeInsets.only(top: 2, bottom: 2, left: 5),
//         child: Row(
//           children: [
//             Text('Mở', style: TextStyle(color: Colors.white, fontSize: 12),),
//             Icon(
//               Icons.open_in_browser,
//               color: Colors.black,
//               size: 13,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _getViewFailure(context) {
//     return GestureDetector(
//       onTap: () => {
//         BlocProvider.of<DownLoadBloc>(context)..add(DownLoadEventDownLoad(this.BASE_URL,this.url))
//       },
//       child:  Container(
//         alignment: Alignment.center,
//         height: 20,
//         width: 40,
//         decoration: BoxDecoration(
//             color: Color(0xfff55142),
//             borderRadius: BorderRadius.only(
//               topLeft: Radius.circular(5),
//               topRight: Radius.circular(5),
//               bottomLeft: Radius.circular(5),
//               bottomRight: Radius.circular(5),
//             )
//         ),
//         padding: new EdgeInsets.only(top: 2, bottom: 2, left: 5),
//         child: Row(
//           children: [
//             Text('Lỗi', style: TextStyle(color: Colors.white, fontSize: 12),),
//             Icon(
//               Icons.refresh,
//               color: Colors.black,
//               size: 13,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _getViewDowLoad(BuildContext context) {
//     return ClipOval(
//       child: Material(
//         color: Colors.white, // button color
//         child: InkWell(
//           child: SizedBox(
//               width: 20,
//               height: 20,
//               child: Icon(
//                 Icons.file_download,
//                 size: 15,
//               )),
//           onTap: () => {
//             BlocProvider.of<DownLoadBloc>(context)..add(DownLoadEventDownLoad(this.url,this.BASE_URL))
//           },
//         ),
//       ),
//     );
//   }
// }
//
// class _GetViewDowLoading extends StatelessWidget{
//
//   @override
//   Widget build(BuildContext context) {
//     return StreamBuilder<double>(
//         stream: context.bloc<DownLoadBloc>().outCounter,
//         initialData: 0,
//         builder: (BuildContext context, AsyncSnapshot<double> snapshot){
//           return Container(
//             width: 20,
//             height: 20,
//             color: Colors.transparent,
//             child: CircularPercentIndicator(
//               radius: 10.0,
//               lineWidth: 2.0,
//               percent: snapshot.data/100.0,
//               progressColor: Colors.green,
//             ),
//           );
//         }
//     );
//   }
// }