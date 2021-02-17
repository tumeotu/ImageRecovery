// import 'dart:async';
// import 'dart:io';
//
// import 'package:dio/dio.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/gestures.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:get_it/get_it.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:image_recovery/Common/DownloadWidget/Bloc/down_open_bloc.dart';
// import 'package:image_recovery/Common/DownloadWidget/Event/down_open_event.dart';
// import 'package:image_recovery/Common/DownloadWidget/View/DownOrOpen.dart';
// import 'package:image_recovery/modules/giayphepxaydung/bloc/quan_ly_xay_dung_map_bloc.dart';
// import 'package:image_recovery/modules/giayphepxaydung/event/quan_ly_xay_dung_map_event.dart';
// import 'package:image_recovery/modules/giayphepxaydung/model/giayphepxaydung.dart';
// import 'package:image_recovery/modules/giayphepxaydung/model/googlemap_response.dart';
// import 'package:image_recovery/modules/giayphepxaydung/model/thongtingiayphep.dart';
// import 'package:image_recovery/modules/giayphepxaydung/state/quan_ly_xay_dung_map_state.dart';
// import 'package:image_recovery/modules/phananhtructuyen/widgets/progress_loading.dart';
// import 'package:image_recovery/routes.dart';
// import 'package:image_recovery/utils/navigations/navigation_datasource.dart';
// import 'package:intl/intl.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
//
// class QLXDMapHome extends StatefulWidget {
//   @override
//   _QLXDMapHomeState createState() => _QLXDMapHomeState();
// }
//
// class _QLXDMapHomeState extends State<QLXDMapHome>
//     with SingleTickerProviderStateMixin {
//
//   AnimationController controller;
//   Animation<Offset> offset;
//   double index = 0.0;
//   BitmapDescriptor IconSelected;
//   BitmapDescriptor IconGPXD;
//   BitmapDescriptor IconPAKP;
//   ScrollController itemScrollController = ScrollController();
//   final ItemPositionsListener itemPositionListener =
//       ItemPositionsListener.create();
//   GoogleMapController _controller;
//   static final CameraPosition _VietInfo = CameraPosition(
//     target: LatLng(10.810583, 106.709145),
//     zoom: 14.4746,
//   );
//   bool _resize = false;
//   double _height = 300;
//   double _heightParent = 150;
//   int duration = 400;
//   int time = 500;
//   Map<MarkerId, Marker> ListMarkers = <MarkerId, Marker>{};
//   MarkerId selectedMarker;
//   List<ThongTinGiayPheps> thongTinGiayPheps;
//   ThongTinGiayPheps thongTinGiayPhepsSelected;
//   GiayPhepXayDung giayPhepXayDung;
//   bool IsLongClick = false;
//   LatLng locationLongClick;
//   Results AddressLongClick;
//   MapType mapType = MapType.normal;
//   final _navigation = GetIt.instance.get<NavigationDataSource>();
//   ///Method
//   @override
//   void initState() {
//     super.initState();
//     //double index = ((MediaQuery.of(context).size.height*2/5))/(106+(MediaQuery.of(context).size.height*2/5));
//     controller =
//         AnimationController(vsync: this, duration: Duration(milliseconds: 500));
//     offset = Tween<Offset>(begin: Offset(0.0, 0.7), end: Offset(0.0, 0.0))
//         .animate(controller);
//     getIcons();
//   }
//
//   getIcons() async {
//     var iconGPXD = await BitmapDescriptor.fromAssetImage(
//         ImageConfiguration(devicePixelRatio: 1.5),
//         "images/icon_marker_gpxd.png");
//     var iconPAKP = await BitmapDescriptor.fromAssetImage(
//         ImageConfiguration(devicePixelRatio: 1.5),
//         "images/icon_marker_pakp.png");
//     var iconSelected = await BitmapDescriptor.fromAssetImage(
//         ImageConfiguration(devicePixelRatio: 1.5),
//         "images/icon_marker_selected.png");
//     setState(() {
//       this.IconGPXD = iconGPXD;
//       this.IconSelected = iconSelected;
//       this.IconPAKP = iconPAKP;
//     });
//   }
//
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         body: _getCustomBody(),
//       ),
//     );
//   }
//
//   OnCreate(GoogleMapController controller) {
//     _controller = controller;
//   }
//
//   _moveCamera(LatLng location) {
//     _controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
//         target: location, zoom: 17.0)));
//   }
//
//   OnSelectdItemGPXD(int index) {
//     setState(() => {thongTinGiayPhepsSelected = thongTinGiayPheps[index]});
//     final String markerIdVal = 'GPXD_${thongTinGiayPhepsSelected.id}';
//     final MarkerId markerId = MarkerId(markerIdVal);
//     _moveCamera(new LatLng(
//         thongTinGiayPhepsSelected.gpSLat, thongTinGiayPhepsSelected.gpSLng));
//     BlocProvider.of<QLXDMapBloc>(context)
//       ..add(QLXDMapEventSelectedMarker(
//           thongTinGiayPhepsSelected.gpSLat.toString(),
//           thongTinGiayPhepsSelected.gpSLng.toString(),
//           markerId));
//   }
//
//   _NaviationToSearchPage() async {
//    Results params = await _navigation.pushNavigation<Results>(NamePage.search_view_page);
//    var location = new LatLng(params.geometry.location.lat, params.geometry.location.lng);
//    _moveCamera(location);
//    BlocProvider.of<QLXDMapBloc>(context)..add(QLXDMapEventLongClick(location));
//   }
//
//   _addMarker(GetDataSuccess state) async {
//     ListMarkers.clear();
//     if (state.response != null) {
//       thongTinGiayPheps = state.response.thongTinGiayPheps;
//       state.response.thongTinGiayPheps.forEach((element) async {
//         final String markerIdVal = 'GPXD_${element.id}';
//         final MarkerId markerId = MarkerId(markerIdVal);
//         BitmapDescriptor icon;
//         if (state.SelectecMarker != null) {
//           if (state.SelectecMarker.value == markerIdVal) {
//             print("xxx");
//             icon = IconSelected;
//           } else {
//             icon = IconGPXD;
//           }
//         } else {
//           icon = IconGPXD;
//         }
//         final Marker marker = Marker(
//           icon: icon,
//           markerId: markerId,
//           position: LatLng(
//             element.gpSLat,
//             element.gpSLng,
//           ),
//           onTap: () {
//             print(markerId);
//             _onMarkerTapped(markerId);
//           },
//           onDragEnd: (LatLng position) {
//             print(position.toString());
//             _onMarkerDragEnd(markerId, position);
//           },
//         );
//         ListMarkers[markerId] = marker;
//       });
//       state.response.phanAnhXayDungKPs.forEach((element) async {
//         final String markerIdVal = 'PAKP_${element.id}';
//         final MarkerId markerId = MarkerId(markerIdVal);
//         BitmapDescriptor icon;
//         if (state.SelectecMarker != null) {
//           if (state.SelectecMarker.value == markerIdVal) {
//             icon = IconSelected;
//           } else {
//             icon = IconPAKP;
//           }
//         } else {
//           icon = IconPAKP;
//         }
//         final Marker marker = Marker(
//           icon: icon,
//           markerId: markerId,
//           position: LatLng(
//             element.gpSLat,
//             element.gpSLng,
//           ),
//           onTap: () {
//             print(markerId.toString());
//             _onMarkerTapped(markerId);
//           },
//           onDragEnd: (LatLng position) {
//             print(position.toString());
//             _onMarkerDragEnd(markerId, position);
//           },
//         );
//         ListMarkers[markerId] = marker;
//       });
//     } else {
//       thongTinGiayPheps = new List();
//     }
//     if (state.location != null) {
//       final String markerIdVal = 'IDPHANANH';
//       final MarkerId markerId = MarkerId(markerIdVal);
//       final Marker marker = Marker(
//         icon: IconSelected,
//         markerId: markerId,
//         position: LatLng(
//           state.location.latitude,
//           state.location.longitude,
//         ),
//       );
//       ListMarkers[markerId] = marker;
//     }
//   }
//
//   ShowAndCloseList() {
//     switch (controller.status) {
//       case AnimationStatus.completed:
//         controller.reverse();
//         break;
//       case AnimationStatus.dismissed:
//         controller.forward();
//         break;
//       default:
//     }
//     setState(() {
//       _resize = !_resize;
//       if (!_resize) {
//         time = 15000;
//         duration = 15000;
//         index = ((MediaQuery.of(context).size.height * 2 / 5)) /
//             (106 + (MediaQuery.of(context).size.height * 2 / 5));
//         _heightParent = MediaQuery.of(context).size.height * 2 / 5 + 12;
//         _height = MediaQuery.of(context).size.height * 2 / 16;
//       } else {
//         duration = 0;
//         _heightParent = MediaQuery.of(context).size.height * 2 / 5 + 12;
//         _height = MediaQuery.of(context).size.height * 2 / 16;
//       }
//     });
//   }
//
//   _onMarkerTapped(MarkerId markerId) {
//     BlocProvider.of<QLXDMapBloc>(context)
//       ..add(QLXDMapEventSelectedMarker(
//           ListMarkers[markerId].position.latitude.toString(),
//           ListMarkers[markerId].position.longitude.toString(),
//           markerId));
//     for (int i = 0; i < thongTinGiayPheps.length; i++) {
//       var value = markerId.value.split('_');
//       if (value[1] == thongTinGiayPheps[i].id.toString()) {
//         _moveCamera(new LatLng(
//             thongTinGiayPheps[i].gpSLat, thongTinGiayPheps[i].gpSLng));
//         thongTinGiayPhepsSelected = thongTinGiayPheps[i];
//         itemScrollController.animateTo(i * (MediaQuery.of(context).size.width),
//             duration: new Duration(seconds: 1), curve: Curves.ease);
//         break;
//       }
//     }
//   }
//
//   _onMarkerDragEnd(MarkerId markerId, LatLng position) {}
//
//   _LongClick(LatLng location) {
//     BlocProvider.of<QLXDMapBloc>(context)..add(QLXDMapEventLongClick(location));
//   }
//
//   DongThemPhanAnh() {
//     BlocProvider.of<QLXDMapBloc>(context)..add(QLXDMapEventLongClick(null));
//   }
//
//   MoveToMyLocation() async {
//     Position position = await Geolocator()
//         .getLastKnownPosition(desiredAccuracy: LocationAccuracy.high);
//     print('AAA' + position.toString());
//     _moveCamera(new LatLng(position.latitude, position.longitude));
//   }
//
//   ThemPhanAnhLongClick() {
//     // location: locationLongClick
//     // address khi longclick: AddressLongClick
//   }
//
//   ThemPhanAnhGiayPhep(int index) {
//     // giay phep can them phan anh: thongTinGiayPheps[index]
//   }
//
//   ChangeTypeMap() {
//     setState(() {
//       if (mapType == MapType.normal) {
//         mapType = MapType.satellite;
//       } else {
//         mapType = MapType.normal;
//       }
//     });
//   }
//
//   LichSuPhanAnh(int index) {
//     print('Co');
//   }
//
//   DownloadFile(int index, int indexfile) async {
//     BlocProvider.of<QLXDMapBloc>(context)..add(
//         QLXDMapEventDownLoadFile(thongTinGiayPheps[index].fileGiayPheps[indexfile].fileUrl));
//   }
//
//   _getCustomBody() {
//     return BlocBuilder<QLXDMapBloc, QLXDMapState>(
//       builder: (context, state) {
//         if (state is QLXDMapStateInitial) {
//           _heightParent = MediaQuery.of(context).size.height * 2 / 5 + 12;
//           return ProgressLoading();
//         } else if (state is GetDataSuccess) {
//           if (state.location != null) {
//             AddressLongClick = state.results;
//             locationLongClick = state.location;
//             IsLongClick = true;
//           } else
//             IsLongClick = false;
//           _addMarker(state);
//         }
//         return Stack(
//           children: [
//             GoogleMap(
//               mapType: mapType==MapType.normal?MapType.normal:MapType.satellite,
//               initialCameraPosition: _VietInfo,
//               onMapCreated: OnCreate,
//               myLocationEnabled: true,
//               myLocationButtonEnabled: false,
//               zoomControlsEnabled: false,
//               markers: Set<Marker>.of(ListMarkers.values),
//               onLongPress: (LatLng location) => _LongClick(location),
//             ),
//             Container(
//               margin: new EdgeInsets.only(top: 40, left: 20, right: 20),
//               padding: new EdgeInsets.only(left: 5),
//               width: MediaQuery.of(context).size.width,
//               height: 60,
//               decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.all(
//                       Radius.circular(10.0) //         <--- border radius here
//                       )),
//               child: Row(
//                 children: [
//                   IconButton(
//                     icon: Icon(Icons.arrow_back),
//                     onPressed: () {
//                       setState(() {
//                         GetIt.instance<NavigationDataSource>()
//                             .popNavigation(context);
//                       });
//                     },
//                   ),
//                   Expanded(
//                     child: RichText(
//                         text: TextSpan(
//                             text: 'Tìm kiếm vị trí...',
//                             style:
//                                 new TextStyle(color: Colors.grey, fontSize: 19),
//                             recognizer: TapGestureRecognizer()
//                               ..onTap = () {
//                                 _NaviationToSearchPage();
//                               })),
//                   ),
//                 ],
//               ),
//             ),
//             Positioned(
//               bottom: 0,
//               child: _getListView(),
//             ),
//           ],
//         );
//       },
//     );
//   }
//
//   _getListView() {
//     if (IsLongClick) {
//       print(locationLongClick.toString());
//       switch (controller.status) {
//         case AnimationStatus.completed:
//           controller.reverse();
//           break;
//         case AnimationStatus.dismissed:
//           controller.reverse();
//           break;
//         default:
//       }
//       return Container(
//         width: MediaQuery.of(context).size.width - 32,
//         margin: new EdgeInsets.all(16),
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(8),
//         ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.end,
//           children: [
//             Container(
//               height: 50,
//               width: MediaQuery.of(context).size.width,
//               child: Stack(
//                 children: [
//                   Align(
//                     alignment: Alignment.bottomRight,
//                     child: ClipOval(
//                       child: Material(
//                         color: Colors.white, // button color
//                         child: InkWell(
//                           child: SizedBox(
//                               width: 50,
//                               height: 50,
//                               child: Icon(
//                                 Icons.my_location,
//                                 size: 26,
//                               )),
//                           onTap: () => MoveToMyLocation(),
//                         ),
//                       ),
//                     ),
//                   ),
//                   Align(
//                       alignment: Alignment.bottomLeft,
//                       child: GestureDetector(
//                         onTap: () => ChangeTypeMap(),
//                         child: Image.asset(mapType == MapType.normal
//                             ? 'images/icon_bando.png'
//                             : 'images/icon_vetinh.png'),
//                       )),
//                 ],
//               ),
//             ),
//             Padding(
//               padding: new EdgeInsets.only(bottom: 10),
//             ),
//             Container(
//               width: MediaQuery.of(context).size.width,
//               height: 158,
//               decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.only(
//                       topLeft: Radius.circular(10),
//                       topRight: Radius.circular(10))),
//               child: Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Stack(
//                   children: [
//                     Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Padding(
//                             padding:
//                                 new EdgeInsets.only(top: 5, left: 5, right: 5),
//                             child: Text(
//                               'Đã thả ghim',
//                               style: new TextStyle(
//                                   fontWeight: FontWeight.bold,
//                                   fontSize: 18,
//                                   color: Color(0xff1f274a)),
//                             )),
//                         Padding(
//                           padding: const EdgeInsets.all(5),
//                           child: Text.rich(
//                             TextSpan(
//                               style: TextStyle(color: Colors.black),
//                               children: <InlineSpan>[
//                                 TextSpan(
//                                   text: 'Vị trí tại: ',
//                                   style: TextStyle(
//                                       color: Color(0xff1f274a), fontSize: 16),
//                                 ),
//                                 TextSpan(
//                                   text: AddressLongClick.formattedAddress,
//                                   style: TextStyle(
//                                       color: Color(0xff1f274a), fontSize: 16),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         )
//                       ],
//                     ),
//                     Padding(
//                       padding: new EdgeInsets.only(top: 5, left: 5, right: 5),
//                     ),
//                     Align(
//                       alignment: Alignment.bottomCenter,
//                       child: Column(
//                         mainAxisSize: MainAxisSize.min,
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Row(
//                             children: [
//                               Expanded(
//                                 child: Padding(
//                                     padding: new EdgeInsets.only(
//                                         top: 5, left: 5, right: 5, bottom: 3),
//                                     child: ConstrainedBox(
//                                       constraints: const BoxConstraints(
//                                           minWidth: double.infinity),
//                                       child: FlatButton(
//                                         shape: new RoundedRectangleBorder(
//                                             borderRadius:
//                                                 new BorderRadius.circular(8.0)),
//                                         color: Color(0xffec4033),
//                                         onPressed: () => ThemPhanAnhLongClick(),
//                                         padding: new EdgeInsets.all(10),
//                                         child: Text(
//                                           'Phản ánh',
//                                           style: new TextStyle(
//                                               fontSize: 16,
//                                               color: Colors.white),
//                                         ),
//                                       ),
//                                     )),
//                                 flex: 1,
//                               ),
//                               Expanded(
//                                 child: Padding(
//                                     padding: new EdgeInsets.only(
//                                         top: 5, left: 5, right: 5, bottom: 3),
//                                     child: new OutlineButton(
//                                         borderSide: BorderSide(
//                                             color: Colors.grey, width: 1.5),
//                                         child: Padding(
//                                           padding: new EdgeInsets.all(10),
//                                           child: Text(
//                                             'Đóng',
//                                             style: new TextStyle(
//                                                 fontSize: 16,
//                                                 color: Colors.grey),
//                                           ),
//                                         ),
//                                         onPressed: () => DongThemPhanAnh(),
//                                         shape: new RoundedRectangleBorder(
//                                             borderRadius:
//                                                 new BorderRadius.circular(8)))),
//                                 flex: 1,
//                               ),
//                             ],
//                           ),
//                         ],
//                       ),
//                     )
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       );
//     } else {
//       if (thongTinGiayPheps == null)
//         return Text(
//           'Không có dữ liệu',
//           style: new TextStyle(color: Colors.red),
//         );
//       else if (thongTinGiayPheps.length == 0) {
//         return Text(
//           'Không có dữ liệu',
//           style: new TextStyle(color: Colors.red),
//         );
//       } else {
//         return Align(
//           alignment: Alignment.bottomCenter,
//           child: SlideTransition(
//             position: offset,
//             child: Container(
//               width: MediaQuery.of(context).size.width,
//               decoration: BoxDecoration(
//                 color: Colors.transparent,
//                 borderRadius: BorderRadius.circular(8),
//               ),
//               child: Column(
//                 mainAxisSize: MainAxisSize.max,
//                 crossAxisAlignment: CrossAxisAlignment.end,
//                 children: [
//                   Container(
//                     height: 50,
//                     width: MediaQuery.of(context).size.width-32,
//                     margin: new EdgeInsets.only(left: 16, right: 16),
//                     child: Stack(
//                       children: [
//                         Align(
//                           alignment: Alignment.bottomRight,
//                           child: ClipOval(
//                             child: Material(
//                               color: Colors.white, // button color
//                               child: InkWell(
//                                 child: SizedBox(
//                                     width: 50,
//                                     height: 50,
//                                     child: Icon(
//                                       Icons.my_location,
//                                       size: 26,
//                                     )),
//                                 onTap: () => MoveToMyLocation(),
//                               ),
//                             ),
//                           ),
//                         ),
//                         Align(
//                             alignment: Alignment.bottomLeft,
//                             child: GestureDetector(
//                               onTap: () => ChangeTypeMap(),
//                               child: Image.asset(mapType == MapType.normal
//                                   ? 'images/icon_bando.png'
//                                   : 'images/icon_vetinh.png'),
//                             )),
//                       ],
//                     ),
//                   ),
//                   Padding(
//                     padding: new EdgeInsets.only(bottom: 5),
//                   ),
//                   Container(
//                     height: _heightParent,
//                     width: MediaQuery.of(context).size.width,
//                     decoration: BoxDecoration(
//                         color: Colors.white,
//                         borderRadius: BorderRadius.only(
//                             topLeft: Radius.circular(20),
//                             topRight: Radius.circular(20))),
//                     child: Column(
//                       mainAxisSize: MainAxisSize.min,
//                       children: [
//                         Expanded(
//                           child: GestureDetector(
//                             child: Container(
//                                 margin: EdgeInsets.only(
//                                     left: 5, right: 5, bottom: 5),
//                                 decoration: BoxDecoration(
//                                     color: Colors.transparent,
//                                     borderRadius:
//                                         BorderRadius.all(Radius.circular(10))),
//                                 child: Column(
//                                   mainAxisAlignment: MainAxisAlignment.center,
//                                   children: <Widget>[
//                                     Icon(
//                                       _resize==true?Icons.keyboard_arrow_down:Icons.keyboard_arrow_up,
//                                       size: 30,
//                                       color: Colors.black,
//                                     ),
//                                     Text(
//                                       'CÔNG TRÌNH XUNG QUANH',
//                                       style: new TextStyle(
//                                           fontWeight: FontWeight.bold,
//                                           fontSize: 16,
//                                           color: Color(0xff1f274a)),
//                                     ),
//                                   ],
//                                 )),
//                             onTap: () {
//                               ShowAndCloseList();
//                             },
//                           ),
//                         ),
//                         Container(
//                             width: MediaQuery.of(context).size.width,
//                             height: (_heightParent - 58),
//                             child: ListView.builder(
//                               scrollDirection: Axis.horizontal,
//                               itemCount: thongTinGiayPheps.length,
//                               controller: itemScrollController,
//                               itemBuilder: (context, index) {
//                                 var color = Colors.white;
//                                 return GestureDetector(
//                                   onTap: () => OnSelectdItemGPXD(index),
//                                   child: ClipRRect(
//                                     borderRadius: BorderRadius.only(
//                                         topLeft: Radius.circular(10.0),
//                                         topRight: Radius.circular(10.0)),
//                                     child: Container(
//                                       margin: new EdgeInsets.all(10),
//                                       height: (_heightParent - 48),
//                                       width: MediaQuery.of(context).size.width -
//                                           20,
//                                       decoration: BoxDecoration(
//                                         color: Color(0xffffffff),
//                                         border: Border.all(
//                                             width: thongTinGiayPhepsSelected
//                                                         ?.id ==
//                                                     thongTinGiayPheps[index].id
//                                                 ? 1
//                                                 : 0,
//                                             color: thongTinGiayPhepsSelected
//                                                         ?.id ==
//                                                     thongTinGiayPheps[index].id
//                                                 ? Color(0xffec4033d)
//                                                 : Colors.white),
//                                         borderRadius: BorderRadius.only(
//                                             topLeft: Radius.circular(11),
//                                             topRight: Radius.circular(11),
//                                             bottomLeft: Radius.circular(10),
//                                             bottomRight: Radius.circular(10)),
//                                         boxShadow: [
//                                           BoxShadow(
//                                             color: Colors.grey.withOpacity(0.5),
//                                             spreadRadius: 1,
//                                             blurRadius: 1,
//                                             offset: Offset(0,
//                                                 2), // changes position of shadow
//                                           ),
//                                         ],
//                                       ),
//                                       child: Stack(
//                                         children: [
//                                           Column(
//                                             crossAxisAlignment:
//                                                 CrossAxisAlignment.start,
//                                             children: [
//                                               ClipRRect(
//                                                 borderRadius: BorderRadius.only(
//                                                     topLeft:
//                                                         Radius.circular(10.0),
//                                                     topRight:
//                                                         Radius.circular(10.0)),
//                                                 child: Container(
//                                                   height: _height,
//                                                   child: _getListFile(index),
//                                                 ),
//                                               ),
//                                               Column(
//                                                 mainAxisAlignment:
//                                                     MainAxisAlignment
//                                                         .spaceBetween,
//                                                 mainAxisSize: MainAxisSize.max,
//                                                 children: [
//                                                   Padding(
//                                                     padding:
//                                                         new EdgeInsets.only(
//                                                             top: 5,
//                                                             left: 5,
//                                                             right: 5),
//                                                     child: RichText(
//                                                       text: TextSpan(
//                                                         style:
//                                                             DefaultTextStyle.of(
//                                                                     context)
//                                                                 .style,
//                                                         children: <TextSpan>[
//                                                           TextSpan(
//                                                               text:
//                                                                   'Công trình tại: ',
//                                                               style:
//                                                                   new TextStyle(
//                                                                       fontSize:
//                                                                           16)),
//                                                           TextSpan(
//                                                               text:
//                                                                   thongTinGiayPheps[
//                                                                           index]
//                                                                       .diaChi,
//                                                               style: TextStyle(
//                                                                   fontWeight:
//                                                                       FontWeight
//                                                                           .bold,
//                                                                   fontSize:
//                                                                       16)),
//                                                         ],
//                                                       ),
//                                                     ),
//                                                   ),
//                                                 ],
//                                               ),
//                                             ],
//                                           ),
//                                           Align(
//                                             alignment: Alignment.bottomCenter,
//                                             child: Column(
//                                               mainAxisSize: MainAxisSize.min,
//                                               crossAxisAlignment:
//                                                   CrossAxisAlignment.start,
//                                               children: [
//                                                 Row(
//                                                   children: [
//                                                     Expanded(
//                                                       child: Padding(
//                                                         padding:
//                                                             new EdgeInsets.only(
//                                                                 top: 5,
//                                                                 left: 5,
//                                                                 right: 5),
//                                                         child: RichText(
//                                                           text: TextSpan(
//                                                             style: DefaultTextStyle
//                                                                     .of(context)
//                                                                 .style,
//                                                             children: <
//                                                                 TextSpan>[
//                                                               TextSpan(
//                                                                   text: 'SGP: ',
//                                                                   style: new TextStyle(
//                                                                       fontSize:
//                                                                           16,
//                                                                       color: Color(
//                                                                           0xff9fabb1))),
//                                                               TextSpan(
//                                                                   text: thongTinGiayPheps[
//                                                                           index]
//                                                                       .soGiayPhep,
//                                                                   style: new TextStyle(
//                                                                       fontSize:
//                                                                           16,
//                                                                       color: Color(
//                                                                           0xff079bd2))),
//                                                             ],
//                                                           ),
//                                                         ),
//                                                       ),
//                                                       flex: 1,
//                                                     ),
//                                                     Expanded(
//                                                       child: Padding(
//                                                         padding:
//                                                             new EdgeInsets.only(
//                                                                 top: 5,
//                                                                 left: 5,
//                                                                 right: 5),
//                                                         child: RichText(
//                                                           text: TextSpan(
//                                                             style: DefaultTextStyle
//                                                                     .of(context)
//                                                                 .style,
//                                                             children: <
//                                                                 TextSpan>[
//                                                               TextSpan(
//                                                                   text:
//                                                                       'Ngày cấp: ',
//                                                                   style: new TextStyle(
//                                                                       fontSize:
//                                                                           16,
//                                                                       color: Color(
//                                                                           0xff9fabb1))),
//                                                               TextSpan(
//                                                                   text: DateFormat(
//                                                                           'dd/MM/yyyy')
//                                                                       .format(thongTinGiayPheps[
//                                                                               index]
//                                                                           .ngayCap),
//                                                                   style: TextStyle(
//                                                                       fontWeight:
//                                                                           FontWeight
//                                                                               .bold,
//                                                                       fontSize:
//                                                                           16)),
//                                                             ],
//                                                           ),
//                                                         ),
//                                                       ),
//                                                       flex: 1,
//                                                     )
//                                                   ],
//                                                 ),
//                                                 Padding(
//                                                   padding: new EdgeInsets.only(
//                                                       top: 5,
//                                                       left: 5,
//                                                       right: 5),
//                                                   child: RichText(
//                                                     text: TextSpan(
//                                                       style:
//                                                           DefaultTextStyle.of(
//                                                                   context)
//                                                               .style,
//                                                       children: <TextSpan>[
//                                                         TextSpan(
//                                                             text:
//                                                                 'Lưu ý: Thời gian hết hạn 1 năm kể từ ngày cấp.',
//                                                             style: new TextStyle(
//                                                                 fontSize: 13,
//                                                                 color: Colors
//                                                                     .red)),
//                                                       ],
//                                                     ),
//                                                   ),
//                                                 ),
//                                                 Row(
//                                                   children: [
//                                                     Expanded(
//                                                       child: Padding(
//                                                           padding:
//                                                               new EdgeInsets
//                                                                       .only(
//                                                                   top: 5,
//                                                                   left: 5,
//                                                                   right: 5,
//                                                                   bottom: 3),
//                                                           child: ConstrainedBox(
//                                                             constraints:
//                                                                 const BoxConstraints(
//                                                                     minWidth: double
//                                                                         .infinity),
//                                                             child: FlatButton(
//                                                               shape: new RoundedRectangleBorder(
//                                                                   borderRadius:
//                                                                       new BorderRadius
//                                                                               .circular(
//                                                                           8.0)),
//                                                               color: Color(
//                                                                   0xffec4033),
//                                                               onPressed: () =>
//                                                                   ThemPhanAnhGiayPhep(
//                                                                       index),
//                                                               padding:
//                                                                   new EdgeInsets
//                                                                       .all(10),
//                                                               child: Text(
//                                                                 'Phản ánh',
//                                                                 style: new TextStyle(
//                                                                     fontSize:
//                                                                         16,
//                                                                     color: Colors
//                                                                         .white),
//                                                               ),
//                                                             ),
//                                                           )),
//                                                       flex: 1,
//                                                     ),
//                                                     Expanded(
//                                                       child: Padding(
//                                                           padding: new EdgeInsets
//                                                                   .only(
//                                                               top: 5,
//                                                               left: 5,
//                                                               right: 5,
//                                                               bottom: 3),
//                                                           child:
//                                                               new OutlineButton(
//                                                                   borderSide: BorderSide(
//                                                                       color: Color(thongTinGiayPheps[index].isPhanAnh==true?0xffec4033:0xff9fabb1),
//                                                                       width:
//                                                                           1.5),
//                                                                   child:
//                                                                       Padding(
//                                                                     padding:
//                                                                         new EdgeInsets.all(
//                                                                             10),
//                                                                     child: Text(
//                                                                       'Xem lịch sử',
//                                                                       style: new TextStyle(
//                                                                           fontSize:
//                                                                               16,
//                                                                           color:
//                                                                           Color(thongTinGiayPheps[index].isPhanAnh==true?0xffec4033:0xff9fabb1)),
//                                                                     ),
//                                                                   ),
//                                                                   onPressed:()=>thongTinGiayPheps[index].isPhanAnh==true?LichSuPhanAnh(index):{},
//                                                                   shape: new RoundedRectangleBorder(
//                                                                       borderRadius:
//                                                                           new BorderRadius.circular(
//                                                                               8)))),
//                                                       flex: 1,
//                                                     ),
//                                                   ],
//                                                 ),
//                                               ],
//                                             ),
//                                           )
//                                         ],
//                                       ),
//                                     ),
//                                   ),
//                                 );
//                               },
//                             ))
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         );
//       }
//     }
//   }
//
//   _getListFile(int index) {
//     bool flag = true;
//     if (thongTinGiayPheps[index].fileGiayPheps.length == 0) {
//       flag = false;
//     } else if (thongTinGiayPheps[index].fileGiayPheps.length == null) {
//       flag = false;
//     }
//     if (flag == false) {
//       return Row(
//         children: [
//           Expanded(
//             child: ClipRRect(
//               borderRadius: BorderRadius.only(
//                   topLeft: Radius.circular(10.0),
//                   topRight: Radius.circular(10.0)),
//               child: Container(
//                 width: (MediaQuery.of(context).size.width - 23) / 2,
//                 height: (MediaQuery.of(context).size.height * 2 / 15),
//                 decoration: BoxDecoration(
//                     color: Color(0xffeff3f5),
//                     borderRadius: BorderRadius.only(
//                       topLeft: Radius.circular(10),
//                       topRight: Radius.circular(10),
//                     )),
//                 child: Stack(
//                   children: [
//                     Container(
//                       width: (MediaQuery.of(context).size.width - 23) / 2,
//                       height: (MediaQuery.of(context).size.height * 2 / 15),
//                       child: Image.asset('images/icon_giayphep.png',
// //                           fit: BoxFit.cover),
// //                     ),
//                     Align(
//                       alignment: Alignment.center,
//                       child: Column(
//                         children: [
//                           Padding(
//                             padding: new EdgeInsets.only(
//                                 top: (MediaQuery.of(context).size.height *
//                                         2 /
//                                         15) /
//                                     5),
//                           ),
//                           Container(
//                             width: 40,
//                             height: 36,
//                             child: Image.asset('images/icon_null.png',
//                                 fit: BoxFit.cover),
//                           ),
//                           Padding(padding: new EdgeInsets.only(top: 2)),
//                           Text(
//                             'Chưa có giấy phép',
//                             style: new TextStyle(
//                                 color: Colors.white, fontSize: 14),
//                           )
//                         ],
//                       ),
//                     )
//                   ],
//                 ),
//               ),
//             ),
//             flex: 1,
//           ),
//           Padding(
//             padding: new EdgeInsets.all(1),
//           ),
//           Expanded(
//             child: ClipRRect(
//               borderRadius: BorderRadius.only(
//                   topLeft: Radius.circular(10.0),
//                   topRight: Radius.circular(10.0)),
//               child: Container(
//                 width: (MediaQuery.of(context).size.width - 23) / 2,
//                 height: (MediaQuery.of(context).size.height * 2 / 15),
//                 decoration: BoxDecoration(
//                     color: Color(0xffeff3f5),
//                     borderRadius: BorderRadius.only(
//                       topLeft: Radius.circular(10),
//                       topRight: Radius.circular(10),
//                     )),
//                 child: Stack(
//                   children: [
//                     Container(
//                       width: (MediaQuery.of(context).size.width - 23) / 2,
//                       height: (MediaQuery.of(context).size.height * 2 / 15),
//                       child: Image.asset('images/icon_banve.png',
//                           fit: BoxFit.cover),
//                     ),
//                     Align(
//                       alignment: Alignment.center,
//                       child: Column(
//                         children: [
//                           Padding(
//                             padding: new EdgeInsets.only(
//                                 top: (MediaQuery.of(context).size.height *
//                                         2 /
//                                         15) /
//                                     5),
//                           ),
//                           Container(
//                             width: 40,
//                             height: 36,
//                             child: Image.asset('images/icon_null.png',
//                                 fit: BoxFit.cover),
//                           ),
//                           Padding(padding: new EdgeInsets.only(top: 2)),
//                           Text(
//                             'Chưa có bản vẽ',
//                             style: new TextStyle(
//                                 color: Colors.white, fontSize: 14),
//                           )
//                         ],
//                       ),
//                     )
//                   ],
//                 ),
//               ),
//             ),
//             flex: 1,
//           ),
//         ],
//       );
//     } else {
//       return ListView.builder(
//         scrollDirection: Axis.horizontal,
//         itemCount: thongTinGiayPheps[index].fileGiayPheps.length,
//         itemBuilder: (context, indexfile) {
//           return ClipRRect(
//             borderRadius: BorderRadius.only(
//                 topLeft: Radius.circular(10.0),
//                 topRight: Radius.circular(10.0)),
//             child: Container(
//               margin: new EdgeInsets.only(
//                   right: indexfile ==
//                           thongTinGiayPheps[index].fileGiayPheps.length - 1
//                       ? 0
//                       : 3),
//               width: ((MediaQuery.of(context).size.width - 23) / 2),
//               decoration: BoxDecoration(
//                 color: Color(0xffeff3f5),
//                 borderRadius: BorderRadius.only(
//                   topLeft: Radius.circular(10),
//                   topRight: Radius.circular(10),
//                 ),
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.grey.withOpacity(0.04),
//                     spreadRadius: 0.05,
//                     blurRadius: 0,
//                     offset: Offset(0, 2), // changes position of shadow
//                   ),
//                 ],
//               ),
//               child: Column(
//                 children: [
//                   ClipRRect(
//                     borderRadius: BorderRadius.only(
//                         topLeft: Radius.circular(10.0),
//                         topRight: Radius.circular(10.0)),
//                     child: Container(
//                       width: (MediaQuery.of(context).size.width - 23) / 2,
//                       height: (MediaQuery.of(context).size.height * 2 / 15) *
//                           (5 / 7),
//                       decoration: BoxDecoration(
//                           color: Color(0xffeff3f5),
//                           borderRadius: BorderRadius.only(
//                             topLeft: Radius.circular(10),
//                             topRight: Radius.circular(10),
//                           )),
//                       child: Image.asset(
//                           thongTinGiayPheps[index]
//                                       .fileGiayPheps[indexfile]
//                                       .loaiFile ==
//                                   'BANVE'
//                               ? 'images/icon_banve.png'
//                               : 'images/icon_giayphep.png',
//                           fit: BoxFit.cover),
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.only(top: 2, right: 5, left: 5),
//                     child: Row(
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       children: [
//                         Text(thongTinGiayPheps[index]
//                             .fileGiayPheps[indexfile].tenFile),
//                         Spacer(),
//                         getViewDownLoadWidget(index,indexfile),
//                       ],
//                     ),
//                   )
//                 ],
//               ),
//             ),
//           );
//         },
//       );
//     }
//   }
//
//   getViewDownLoadWidget(int index, int indexfile)
//   {
//    return BlocProvider<DownLoadBloc>(
//       create: (context) => DownLoadBloc()..add(DownLoadEventStart(thongTinGiayPheps[index]
//           .fileGiayPheps[indexfile].fileUrl)),
//       child: DownLoad(BASE_URL: 'http://192.168.1.124:8001/ServiceAPI/api/DownloadFileAlfresco/'
//         ,url: thongTinGiayPheps[index]
//             .fileGiayPheps[indexfile].fileUrl,
//       ),
//     );
//   }
//
// }
