import 'package:flutter/material.dart';
import 'package:human_resource_management_system/modules/scan_to_login/screen/scan_to_login_screen.dart';
import 'package:human_resource_management_system/utils/style/colors.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: _buildBody(context),
    );
  }
}

Widget _buildBody(BuildContext context) {
  // print(ScanToLoginStore().readCache());
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Center(child: Image.asset('assets/images/scan_qr_image.jpg')),
      const SizedBox(height: 24),
      const SizedBox(height: 16),
      // Center(
      //   child: Padding(
      //     padding: const EdgeInsets.symmetric(horizontal: 16),
      //     child: ElevatedButton(
      //       style: ElevatedButton.styleFrom(
      //         primary: primaryColor,
      //         shape: RoundedRectangleBorder(
      //           borderRadius: BorderRadius.circular(50),
      //         ),
      //       ),
      //       onPressed: () {
      //         Navigator.of(context).push(MaterialPageRoute(
      //           builder: (context) => const LoginScreen(),
      //         ));
      //       },
      //       child: const SizedBox(
      //         width: double.infinity,
      //         height: 45,
      //         child: Center(
      //           child: Text(
      //             'Login',
      //             style: TextStyle(fontSize: 16, color: Colors.white),
      //           ),
      //         ),
      //       ),
      //     ),
      //   ),
      // ),
      // const SizedBox(height: 16),
      // Center(
      //   child: Padding(
      //     padding: const EdgeInsets.symmetric(horizontal: 16),
      //     child: ElevatedButton(
      //       style: ElevatedButton.styleFrom(
      //         backgroundColor: primaryColor,
      //         shape: RoundedRectangleBorder(
      //           borderRadius: BorderRadius.circular(50),
      //         ),
      //       ),
      //       onPressed: () {
      //         Navigator.of(context).push(MaterialPageRoute(
      //           builder: (context) => const LoginScreen(),
      //         ));
      //       },
      //       child: const SizedBox(
      //         width: double.infinity,
      //         height: 45,
      //         child: Center(
      //           child: Text(
      //             'Login',
      //             style: TextStyle(fontSize: 16, color: Colors.white),
      //           ),
      //         ),
      //       ),
      //     ),
      //   ),
      // ),
      const SizedBox(height: 16),
      Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: primaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50),
              ),
            ),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const ScanToLoginScreen(),
              ));
            },
            child: const SizedBox(
              width: double.infinity,
              height: 45,
              child: Center(
                child: Text(
                  'Scan QR Code to Login',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ),
          ),
        ),
      ),
    ],
  );
}
