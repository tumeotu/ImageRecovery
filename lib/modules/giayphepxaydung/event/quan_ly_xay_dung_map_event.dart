// import 'package:equatable/equatable.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
//
// abstract class QLXDMapEvent extends Equatable {
//   @override
//   // TODO: implement props
//   List<Object> get props => [];
// }
// class QLXDMapEventStart extends QLXDMapEvent{}
// class QLXDMapEventGetData extends QLXDMapEvent{
//   final String lat;
//   final String lng;
//   final String bankinh;
//   QLXDMapEventGetData(this.lat, this.lng, this.bankinh);
// }
// class  QLXDMapEventSelectedMarker extends QLXDMapEvent{
//   final String lat;
//   final String lng;
//   final MarkerId ID;
//   QLXDMapEventSelectedMarker(this.lat, this.lng, this.ID);
// }
// class  QLXDMapEventLongClick extends QLXDMapEvent{
//   final LatLng location;
//   QLXDMapEventLongClick(this.location);
// }
// class QLXDMapEventPost extends QLXDMapEvent{
//   QLXDMapEventPost();
// }
// class QLXDMapEventDownLoadFile extends QLXDMapEvent{
//   final String url;
//   QLXDMapEventDownLoadFile(this.url);
// }