import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:human_resource_management_system/utils/style/colors.dart';

class PlashScreen extends StatelessWidget {
  const PlashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          children: [
            const SizedBox(height: 100),
            Container(
                // height: 100,
                padding: const EdgeInsets.only(right: 50, left: 50, bottom: 30),
                child: const Center(
                    child: Image(
                        image: AssetImage('assets/images/Logo_crop.png')))),
            const SizedBox(
              child: Center(
                child: Text(
                  'Human Resource Management System',
                  style: TextStyle(
                      color: Color(0xff006C51), fontWeight: FontWeight.bold),
                ),
              ),
            )
          ],
        ),
        Column(
          children: [
            ClipPath(
              clipper: WaveClipperTwo(reverse: true),
              child: Container(
                height: 200,
                color: primaryColor,
                // child: Center(child: Text("WaveClipperTwo(reverse: true)")),
              ),
            ),
          ],
        ),
      ],
    ));
  }
}
