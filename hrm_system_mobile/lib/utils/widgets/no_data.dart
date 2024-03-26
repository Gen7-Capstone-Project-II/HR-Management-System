import 'package:flutter/material.dart';
import 'package:human_resource_management_system/utils/style/colors.dart';
import 'package:lottie/lottie.dart';

class NoDataScreen extends StatelessWidget {
  const NoDataScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            LottieBuilder.asset(
              'assets/animations/no_data.json',
              width: 150,
            ),
            const Text(
              'No data found!',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: primaryColor,
              ),
            )
          ],
        ),
      ),
    );
  }
}
