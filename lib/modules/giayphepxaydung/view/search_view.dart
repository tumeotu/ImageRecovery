// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:get_it/get_it.dart';
// import 'package:image_recovery/modules/giayphepxaydung/bloc/search_view_bloc.dart';
// import 'package:image_recovery/modules/giayphepxaydung/event/search_view_event.dart';
// import 'package:image_recovery/modules/giayphepxaydung/model/googlemap_response.dart';
// import 'package:image_recovery/modules/giayphepxaydung/state/search_view_state.dart';
// import 'package:image_recovery/utils/navigations/navigation_datasource.dart';
// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'package:shared_preferences/shared_preferences.dart';
//
// class SearchViewHome extends StatefulWidget {
//   @override
//   _SearchViewHomeState createState() => new _SearchViewHomeState();
// }
//
// class _SearchViewHomeState extends State<SearchViewHome> {
//   final String HISTORY = 'HISTORY';
//   TextEditingController controller = new TextEditingController();
//   FocusNode _focusNode;
//   bool IsSearch = false;
//   bool IsFocus = false;
//   List<Results> _searchResult = null;
//   List<Results> _searchHistoryResult = [];
//   List<Results> _History = [];
//
//   @override
//   void initState() {
//     super.initState();
//     _focusNode = new FocusNode();
//     _focusNode.addListener(_onOnFocusNodeEvent);
//   }
//
//   _onOnFocusNodeEvent() {
//     if (!IsFocus) {
//       print('focus');
//       BlocProvider.of<SearchViewBloc>(context)
//         ..add(SearchViewEventGetDataHistory());
//     }
//     IsFocus = !IsFocus;
//   }
//
//   SearchAddress(String str) {
//     BlocProvider.of<SearchViewBloc>(context)..add(SearchViewEventGetData(str));
//   }
//
//   ClickItemSearch(int index) async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     String data = (prefs.getString(HISTORY));
//     print(data.toString());
//     if (data != null) {
//       List<Results> posts =
//           (json.decode(data) as List).map((i) => Results.fromJson(i)).toList();
//       final jsonResponse = jsonDecode(data);
//       _History = new List<Results>();
//       jsonResponse.forEach((v) {
//         _History.add(new Results.fromJson(v));
//       });
//     } else
//       _History = new List<Results>();
//     _History.add(_searchResult[index]);
//     _History = _History.toSet().toList();
//     await prefs.setString(HISTORY, jsonEncode(_History));
//     Navigator.pop(context, _searchResult[index]);
//   }
//
//   ClickItemHistory(int index) async {
//     Navigator.pop(context, _searchResult[index]);
//   }
//
//   ClickItemHistoryQuery(int index) async {
//     Navigator.pop(context, _searchHistoryResult[index]);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return new Scaffold(
//         body: new GestureDetector(
//             onTap: () {
//               _focusNode.unfocus();
//               //FocusScope.of(context).requestFocus(new FocusNode());
//             },
//             child: getCustomBody()));
//   }
//
//   getCustomBody() {
//     return BlocBuilder<SearchViewBloc, SearchViewState>(
//       builder: (context, state) {
//         if (state is SearchViewStateInitial) {
//         } else if (state is GetDataSearchSuccess) {
//           if (state.IsSearch) {
//             IsSearch = true;
//             _searchResult = state.response;
//           } else {
//             IsSearch = false;
//             _searchResult = state.response;
//           }
//         }
//         return new Column(
//           children: <Widget>[
//             new Container(
//               width: MediaQuery.of(context).size.width,
//               height: 60,
//               decoration: BoxDecoration(
//                   border: Border.all(
//                     width: 1,
//                     color: Color(0xffe6ebec),
//                   ),
//                   color: Colors.white,
//                   borderRadius: BorderRadius.all(Radius.circular(10.0) //
//                       )),
//               margin: new EdgeInsets.only(top: 55, left: 10, right: 10),
//               child: Row(
//                 children: [
//                   IconButton(
//                     icon: Icon(
//                       Icons.arrow_back,
//                       size: 25,
//                     ),
//                     onPressed: () {
//                       setState(() {
//                         GetIt.instance<NavigationDataSource>()
//                             .popNavigation(context);
//                       });
//                     },
//                   ),
//                   Container(
//                     width: MediaQuery.of(context).size.width - 120,
//                     height: 60,
//                     child: Padding(
//                       padding: const EdgeInsets.only(top: 5, left: 5),
//                       child: TextField(
//                         focusNode: _focusNode,
//                         onSubmitted: (String str) => SearchAddress(str),
//                         textInputAction: TextInputAction.search,
//                         style: new TextStyle(fontSize: 20),
//                         controller: controller,
//                         decoration: new InputDecoration(
//                             hintText: 'Tìm kiếm công trình',
//                             border: InputBorder.none),
//                         onChanged: onSearchTextChanged,
//                       ),
//                     ),
//                   ),
//                   IconButton(
//                     icon: Icon(
//                       Icons.clear,
//                       size: 25,
//                     ),
//                     onPressed: () {
//                       setState(() {
//                         controller.clear();
//                         onSearchTextChanged('');
//                       });
//                     },
//                   ),
//                 ],
//               ),
//             ),
//             getView(),
//           ],
//         );
//       },
//     );
//   }
//
//   getView() {
//     if (_searchResult != null) {
//       if (IsSearch) {
//         print('search');
//         return getViewTimKiem();
//       } else {
//         return getViewLichSu();
//       }
//     } else {
//       return Container();
//     }
//   }
//
//   getViewLichSu() {
//     return Expanded(
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Padding(
//             padding: const EdgeInsets.only(left: 16, top: 10),
//             child: Text(
//               'Lịch sử',
//               style: new TextStyle(
//                   fontWeight: FontWeight.bold,
//                   color: Color(0xff303444),
//                   fontSize: 16),
//             ),
//           ),
//           Expanded(
//             child: _searchHistoryResult.length != 0 ||
//                     controller.text.isNotEmpty
//                 ? new ListView.builder(
//                     padding: EdgeInsets.zero,
//                     itemCount: _searchHistoryResult.length,
//                     itemBuilder: (context, i) {
//                       return GestureDetector(
//                         onTap: () => ClickItemHistoryQuery(i),
//                         child: Container(
//                           margin:
//                               new EdgeInsets.only(top: 0, left: 10, right: 10),
//                           child: Row(
//                             children: [
//                               ClipOval(
//                                 child: Material(
//                                   color: Color(0xffe6ebec),
//                                   child: SizedBox(
//                                       width: 30,
//                                       height: 30,
//                                       child: Icon(
//                                         Icons.access_time,
//                                         size: 20,
//                                       )),
//                                 ),
//                               ),
//                               Padding(
//                                 padding: new EdgeInsets.all(5),
//                               ),
//                               Container(
//                                 width: MediaQuery.of(context).size.width - 60,
//                                 decoration: const BoxDecoration(
//                                   border: Border(
//                                     bottom: BorderSide(
//                                         width: 1.0, color: Color(0xFFe6ebec)),
//                                   ),
//                                 ),
//                                 padding:
//                                     new EdgeInsets.only(bottom: 15, top: 20),
//                                 child: Text.rich(
//                                   TextSpan(
//                                     style: TextStyle(color: Colors.black),
//                                     children: <InlineSpan>[
//                                       TextSpan(
//                                         text: _searchHistoryResult[i]
//                                             .formattedAddress,
//                                         style: TextStyle(
//                                             color: Color(0xff1f274a),
//                                             fontSize: 16,
//                                           fontWeight: FontWeight.bold
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               )
//                             ],
//                           ),
//                         ),
//                       );
//                     },
//                   )
//                 : new ListView.builder(
//                     padding: EdgeInsets.zero,
//                     itemCount: _searchResult.length,
//                     itemBuilder: (context, index) {
//                       return GestureDetector(
//                         onTap: () => ClickItemHistory(index),
//                         child: Container(
//                           margin:
//                               new EdgeInsets.only(top: 0, left: 10, right: 10),
//                           child: Row(
//                             children: [
//                               ClipOval(
//                                 child: Material(
//                                   color: Color(0xffe6ebec),
//                                   child: SizedBox(
//                                       width: 30,
//                                       height: 30,
//                                       child: Icon(
//                                         Icons.access_time,
//                                         size: 20,
//                                       )),
//                                 ),
//                               ),
//                               Padding(
//                                 padding: new EdgeInsets.all(5),
//                               ),
//                               Container(
//                                 width: MediaQuery.of(context).size.width - 60,
//                                 decoration: const BoxDecoration(
//                                   border: Border(
//                                     bottom: BorderSide(
//                                         width: 1.0, color: Color(0xFFe6ebec)),
//                                   ),
//                                 ),
//                                 padding:
//                                     new EdgeInsets.only(bottom: 15, top: 20),
//                                 child: Text.rich(
//                                   TextSpan(
//                                     style: TextStyle(color: Colors.black),
//                                     children: <InlineSpan>[
//                                       TextSpan(
//                                         text: _searchResult[index]
//                                             .formattedAddress,
//                                         style: TextStyle(
//                                             color: Color(0xff1f274a),
//                                             fontSize: 16,
//                                             fontWeight: FontWeight.bold
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               )
//                             ],
//                           ),
//                         ),
//                       );
//                     },
//                   ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   getViewTimKiem() {
//     return Expanded(
//       child: ListView.builder(
//         padding: EdgeInsets.zero,
//         itemCount: _searchResult.length,
//         itemBuilder: (context, index) {
//           return GestureDetector(
//             onTap: () => ClickItemSearch(index),
//             child: Container(
//               margin: new EdgeInsets.only(top: 0, left: 10, right: 10),
//               child: Row(
//                 children: [
//                   ClipOval(
//                     child: Material(
//                       color: Color(0xffe6ebec),
//                       child: SizedBox(
//                           width: 30,
//                           height: 30,
//                           child: Icon(
//                             Icons.map,
//                             size: 20,
//                           )),
//                     ),
//                   ),
//                   Padding(
//                     padding: new EdgeInsets.all(5),
//                   ),
//                   Container(
//                     width: MediaQuery.of(context).size.width - 60,
//                     decoration: const BoxDecoration(
//                       border: Border(
//                         bottom:
//                             BorderSide(width: 1.0, color: Color(0xFFe6ebec)),
//                       ),
//                     ),
//                     padding: new EdgeInsets.only(bottom: 15, top: 20),
//                     child: Text.rich(
//                       TextSpan(
//                         style: TextStyle(color: Colors.black),
//                         children: <InlineSpan>[
//                           TextSpan(
//                             text: _searchResult[index].formattedAddress,
//                             style: TextStyle(
//                                 color: Color(0xff1f274a),
//                                 fontWeight: FontWeight.bold,
//                                 fontSize: 16
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   )
//                 ],
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
//
//   onSearchTextChanged(String text) async {
//     _searchHistoryResult.clear();
//     if (text.isEmpty) {
//       setState(() {});
//       return;
//     }
//     _searchResult.forEach((userDetail) {
//       if (userDetail.formattedAddress.contains(text) ||
//           userDetail.formattedAddress.contains(text))
//         _searchHistoryResult.add(userDetail);
//     });
//     setState(() {});
//   }
// }
