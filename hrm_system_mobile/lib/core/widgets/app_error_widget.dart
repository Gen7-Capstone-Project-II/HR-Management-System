// import 'dart:math';
// import 'package:flutter/material.dart';
// import 'package:fluttericon/typicons_icons.dart';
// import 'package:lottie/lottie.dart';
// import '../index.dart';

// ///
// /// [AppErrorWidget]
// ///
// class AppErrorWidget extends StatelessWidget {
//   final FlutterErrorDetails errorDetails;
//   final bool isProduction;

//   const AppErrorWidget({Key? key, required this.errorDetails, this.isProduction = false}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     double height = MediaQuery.of(context).size.height;
//     return Scaffold(
//       backgroundColor: Colors.green,
//       body: Stack(
//         children: [
//           Positioned(top: -height * .15, right: -MediaQuery.of(context).size.width * .45, child: const BezierContainer()),
//           SizedBox(
//             height: height,
//             child: Center(
//               child: SingleChildScrollView(
//                 child: Column(
//                   children: <Widget>[
//                     if (!isProduction)
//                       Text(
//                         errorDetails.summary.toString(),
//                       ),
//                     if (!isProduction)
//                       Text(
//                         "$errorDetails",
//                       ),
//                     UIHelper.verticalSpace(16),
//                     Text(
//                       "Something went wrong".toUpperCase(),
//                       style: const TextStyle(color: Colors.white, fontSize: 20),
//                     ),
//                     Container(
//                       child: Lottie.asset(AssetConst.ANIM_LOTTIE_APP_ERROR, height: 300, width: 300),
//                     ),
//                     UIHelper.verticalSpace(16),
//                     Container(
//                       padding: const EdgeInsets.symmetric(horizontal: 24),
//                       child: ElevatedButton(
//                         style: ElevatedButton.styleFrom(
//                           backgroundColor: Colors.white,
//                           shape: const StadiumBorder(),
//                           elevation: 0,
//                         ),
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             const Icon(Typicons.left_outline, color: Colors.green, size: 16),
//                             const SizedBox(width: 8),
//                             Text(
//                               I18NTranslations.of(context).text("message.go.to.homescreen"),
//                               style: const TextStyle(color: Colors.green),
//                             ),
//                           ],
//                         ),
//                         onPressed: () {
//                           // Navigator.of(context).pushNamedAndRemoveUntil(HomeTabScreen.routeName, (Route<dynamic> route) => false);
//                         },
//                       ),
//                     ),
//                     UIHelper.verticalSpace(16),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// ///
// /// [BezierContainer]
// ///
// class BezierContainer extends StatelessWidget {
//   const BezierContainer({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       child: Transform.rotate(
//         angle: -pi / 3.5,
//         child: ClipPath(
//           clipper: ClipPainter(),
//           child: Container(
//             height: MediaQuery.of(context).size.height * .5,
//             width: MediaQuery.of(context).size.width,
//             decoration: BoxDecoration(gradient: LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [Theme.of(context).primaryColorLight, Colors.green[300]!])),
//           ),
//         ),
//       ),
//     );
//   }
// }

// ///
// /// [ClipPainter]
// ///
// class ClipPainter extends CustomClipper<Path> {
//   @override
//   Path getClip(Size size) {
//     var height = size.height;
//     var width = size.width;
//     var path = Path();

//     path.lineTo(0, size.height);
//     path.lineTo(size.width, height);
//     path.lineTo(size.width, 0);

//     /// [Top Left corner]
//     var secondControlPoint = const Offset(0, 0);
//     var secondEndPoint = Offset(width * .2, height * .3);
//     path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy, secondEndPoint.dx, secondEndPoint.dy);

//     /// [Left Middle]
//     var fifthControlPoint = Offset(width * .3, height * .5);
//     var fiftEndPoint = Offset(width * .23, height * .6);
//     path.quadraticBezierTo(fifthControlPoint.dx, fifthControlPoint.dy, fiftEndPoint.dx, fiftEndPoint.dy);

//     /// [Bottom Left corner]
//     var thirdControlPoint = Offset(0, height);
//     var thirdEndPoint = Offset(width, height);
//     path.quadraticBezierTo(thirdControlPoint.dx, thirdControlPoint.dy, thirdEndPoint.dx, thirdEndPoint.dy);

//     path.lineTo(0, size.height);
//     path.close();

//     return path;
//   }

//   @override
//   bool shouldReclip(CustomClipper<Path> oldClipper) {
//     return true;
//   }
// }
