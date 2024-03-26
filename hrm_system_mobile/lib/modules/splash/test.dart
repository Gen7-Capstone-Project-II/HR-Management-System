// import 'package:flutter/material.dart';
// import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
// import 'package:human_resource_management_system/utils/style/colors.dart';

// class HomeScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         body: Column(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         Column(
//           children: [
//             SizedBox(
//               height: 100,
//             ),
//             Container(
//                 // height: 100,
//                 padding: EdgeInsets.only(right: 50, left: 50, bottom: 30),
//                 child: Center(
//                     child: Image(
//                         image: AssetImage('assets/images/Logo_crop.png')))),
//             SizedBox(
//               child: Center(
//                   child: Text(
//                 'Human Resource Management System',
//                 style: TextStyle(
//                     color: Color(0xff006C51), fontWeight: FontWeight.bold),
//               )),
//             )
//           ],
//         ),
//         Column(
//           children: [
//             ClipPath(
//               clipper: WaveClipperTwo(reverse: true),
//               child: Container(
//                 height: 200,
//                 color: Color(0xff006C51),
//                 // child: Center(child: Text("WaveClipperTwo(reverse: true)")),
//               ),
//             ),
//           ],
//         ),
//       ],
//     ));
//   }
// }



//       // body: ListView(
//       //   children: <Widget>[
//       //     ClipPath(
//       //       clipper: DiagonalPathClipperOne(),
//       //       child: Container(
//       //         height: 120,
//       //         color: Colors.red,
//       //         child: Center(child: Text("DiagonalPathClipper()")),
//       //       ),
//       //     ),
//       //   ],
//       // ),
//       // Stack(
//       //   children: <Widget>[
//       //     // Other widgets in the stack, if any
//       //     Positioned(
//       //       bottom: 0,
//       //       left: 0,
//       //       right: 0,
//       //       child: Container(
//       //         height: 200, // Adjust the height of the square as needed
//       //         // color: Colors.blue, // Change the color as needed
//       //         child: ClipPath(
//       //           clipper: WaveClipperTwo(reverse: true),
//       //           child: Container(
//       //             height: 120,
//       //             color: Colors.green,
//       //             // child: Center(child: Text("WaveClipperTwo(reverse: true)")),
//       //           ),
//       //         ),
//       //       ),
//       //     )
//       //   ],
//       // ),