import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:human_resource_management_system/core/stores/connectivity_store/connectivity_store.dart';
import 'package:human_resource_management_system/modules/announcement/stores/announcement_store.dart';
import 'package:human_resource_management_system/modules/attendance/stores/attendance_store.dart';
import 'package:human_resource_management_system/modules/attendance/stores/current_attendance_store.dart';
import 'package:human_resource_management_system/modules/employee_detail/stores/emergency_contact_store.dart';
import 'package:human_resource_management_system/modules/employee_detail/stores/employee_detail_store.dart';
import 'package:human_resource_management_system/modules/leave_request/stores/leave_request_store.dart';
import 'package:human_resource_management_system/modules/leave_request/stores/leave_type_store.dart';
import 'package:human_resource_management_system/modules/mission/stores/mission_store.dart';
import 'package:human_resource_management_system/modules/mission/stores/mission_type_store.dart';
import 'package:human_resource_management_system/modules/overtime/stores/over_time_store.dart';
import 'package:human_resource_management_system/modules/scan_to_login/stores/scan_to_login_store.dart';
import 'package:human_resource_management_system/modules/user/stores/auth_store.dart';
import 'package:human_resource_management_system/splash_screen.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  if (kReleaseMode) {
    debugPrint = (message, {wrapWidth}) {};
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(create: (_) => ConnectivityStore()),
        Provider(create: (_) => AuthStore()),
        Provider(create: (_) => EmployeeDetailStore()),
        Provider(create: (_) => EmergencyContactStore()),
        Provider(create: (_) => AnnouncementStore()),
        Provider(create: (_) => AttendanceStore()),
        Provider(create: (_) => CurrentAttendanceStore()),
        Provider(create: (_) => LeaveRequestStore()),
        Provider(create: (_) => LeaveTypeStore()),
        Provider(create: (_) => ScanToLoginStore()),
        Provider(create: (_) => OverTimeStore()),
        Provider(create: (_) => MissionStore()),
        Provider(create: (_) => MissionTypeStore()),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'HRM SYSTEM',
        home: SplashScreen(),
      ),
    );
  }
}
