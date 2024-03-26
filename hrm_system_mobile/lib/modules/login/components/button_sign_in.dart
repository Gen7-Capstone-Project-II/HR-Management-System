import 'package:flutter/material.dart';
import 'package:human_resource_management_system/my_home.dart';

import '../../../utils/style/colors.dart';

class ButtonSignIn extends StatelessWidget {
  const ButtonSignIn({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 30, right: 30),
      height: 50,
      width: double.infinity, // Set to your desired width
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(20.0), // Adjust the value as needed
          ),
        ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const MyHome(),
            ),
          );
        },
        child: const Text(
          'Sign In  ',
          style: TextStyle(color: white),
        ),
      ),
    );
  }
}
