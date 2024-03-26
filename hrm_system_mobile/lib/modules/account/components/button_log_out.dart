import 'package:flutter/material.dart';
import 'package:human_resource_management_system/modules/login/sign_in.dart';
import 'package:human_resource_management_system/modules/scan_to_login/stores/scan_to_login_store.dart';
import 'package:provider/provider.dart';
import '../../../utils/style/colors.dart';

class ButtonLogOut extends StatefulWidget {
  const ButtonLogOut({super.key});

  @override
  State<ButtonLogOut> createState() => _ButtonLogOutState();
}

class _ButtonLogOutState extends State<ButtonLogOut> {
  @override
  void initState() {
    super.initState();
  }

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
            borderRadius: BorderRadius.circular(20.0), // Adjust the value as needed
          ),
        ),
        onPressed: () async {
          context.read<ScanToLoginStore>().signOut();
          // context.read<EmployeeDetailStore>().reset();
          // context.read<EmergencyContactStore>().reset();
          // context.read<AnnouncementStore>().reset();
          // context.read<AttendanceStore>().reset();
          // context.read<LeaveRequestStore>().reset();
          // context.read<LeaveTypeStore>().reset();
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const SignInScreen(),
            ),
          );
        },
        child: const Text(
          'Log Out  ',
          style: TextStyle(color: white),
        ),
      ),
    );
  }
}
