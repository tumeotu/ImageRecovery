// import 'dart:io';
//
// import 'package:flutter/material.dart';
//
// class VideoPlayerWidget extends StatefulWidget {
//   final String pathFile;
//   final String urlFile;
//
//   VideoPlayerWidget({Key key, this.pathFile, this.urlFile}) : super(key: key);
//
//   @override
//   _VideoPlayerWidgetState createState() => _VideoPlayerWidgetState();
// }
//
// class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
//   Future<void> _initializeVideoPlayerFuture;
//   bool isVisiableButton = true;
//
//   @override
//   void initState() {
//     if (widget.pathFile.isNotEmpty == true) {
//       _controller = VideoPlayerController.file(File(widget.pathFile));
//     } else {
//       _controller = VideoPlayerController.network(widget.urlFile);
//     }
//     _initializeVideoPlayerFuture = _controller.initialize().then((_) {
//       _controller.setLooping(true);
//       setState(() {});
//     });
//     _controller
//       ..addListener(() {
//         setState(() {});
//       });
//     super.initState();
//   }
//
//   @override
//   void dispose() {
//     _controller.removeListener(() {});
//     _controller.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     const iconSize = 50.0;
//     return Scaffold(
//       body: SafeArea(
//         child: Container(
//           color: Colors.black,
//           alignment: Alignment.center,
//           child: FutureBuilder(
//             future: _initializeVideoPlayerFuture,
//             builder: (context, snapshot) {
//               if (snapshot.connectionState == ConnectionState.done) {
//                 // If the VideoPlayerController has finished initialization, use
//                 // the data it provides to limit the aspect ratio of the video.
//                 return AspectRatio(
//                   aspectRatio: _controller.value.aspectRatio,
//                   // Use the VideoPlayer widget to display the video.
//                   child: Stack(
//                     children: [
//                       GestureDetector(
//                           onTap: () => isVisiableButton =
//                               _controller.value.isPlaying
//                                   ? !isVisiableButton
//                                   : isVisiableButton,
//                           child: VideoPlayer(_controller)),
//                       Visibility(
//                         visible: isVisiableButton,
//                         child: Container(
//                           margin: EdgeInsets.only(left: 5.0),
//                           child: Align(
//                             alignment: Alignment.topLeft,
//                             child: FlatButton(
//                               onPressed: () => Navigator.pop(context),
//                               shape: RoundedRectangleBorder(
//                                   borderRadius:
//                                       BorderRadius.all(Radius.circular(10.0))),
//                               color: Colors.black26,
//                               child: Text(
//                                 "Trở về",
//                                 style: TextStyle(
//                                     color: Colors.white, fontSize: 16.0),
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                       Visibility(
//                         visible: isVisiableButton,
//                         child: Align(
//                           alignment: Alignment.center,
//                           child: FlatButton(
//                             shape: CircleBorder(),
//                             color: Colors.black26,
//                             child: Icon(
//                               _controller.value.isPlaying
//                                   ? Icons.pause
//                                   : Icons.play_arrow,
//                               size: 80.0,
//                               color: Colors.white,
//                             ),
//                             onPressed: () {
//                               setState(() {
//                                 _controller.value.isPlaying
//                                     ? _controller.pause()
//                                     : _controller.play();
//                                 setState(() {});
//                               });
//                             },
//                           ),
//                         ),
//                       )
//                     ],
//                   ),
//                 );
//               } else {
//                 // If the VideoPlayerController is still initializing, show a
//                 // loading spinner.
//                 return Center(child: CircularProgressIndicator());
//               }
//             },
//           ),
//         ),
//       ),
// //      floatingActionButton: FloatingActionButton(
// //        onPressed: () {
// //          // Wrap the play or pause in a call to `setState`. This ensures the
// //          // correct icon is shown.
// //          setState(() {
// //            // If the video is playing, pause it.
// //            if (_controller.value.isPlaying) {
// //              _controller.pause();
// //            } else {
// //              // If the video is paused, play it.
// //              _controller.play();
// //            }
// //          });
// //        },
// //        // Display the correct icon depending on the state of the player.
// //        child: Icon(
// //          _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
// //        ),
// //      ), // This trailing comma makes auto-formatting nicer for build methods.
//     );
//   }
// }
