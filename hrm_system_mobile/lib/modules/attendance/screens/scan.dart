import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:human_resource_management_system/core/enums/enums.dart';
import 'package:human_resource_management_system/modules/attendance/screens/scan_to_check_in.dart';
import 'package:human_resource_management_system/modules/attendance/screens/scan_to_check_out.dart';
import 'package:human_resource_management_system/modules/attendance/stores/current_attendance_store.dart';
import 'package:human_resource_management_system/modules/scan_to_login/stores/scan_to_login_store.dart';
import 'package:human_resource_management_system/utils/style/colors.dart';
import 'package:human_resource_management_system/utils/widgets/loading.dart';
import 'package:human_resource_management_system/utils/widgets/no_data.dart';
import 'package:provider/provider.dart';

class ScanScreen extends StatefulWidget {
  const ScanScreen({super.key});

  @override
  State<ScanScreen> createState() => _ScanScreenState();
}

class _ScanScreenState extends State<ScanScreen> {
  String _monthSelected() {
    int index = DateTime.now().month;
    if (index < 10) {
      return '0$index';
    } else {
      return index.toString();
    }
  }

  @override
  void initState() {
    super.initState();
    if (mounted) {
      Future.delayed(Duration.zero, () async {
        await context.read<CurrentAttendanceStore>().getCurrentAttendance(
            id: Provider.of<ScanToLoginStore>(context, listen: false)
                .userModel!
                .user!
                .id!,
            month: '${DateTime.now().year}-${_monthSelected()}');
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: const Text(
          'Scan Attendance',
          style: TextStyle(color: white),
        ),
      ),
      body: Observer(builder: (context) {
        LoadingStatus status = context.watch<CurrentAttendanceStore>().status;
        CurrentAttendanceStore currentAttendanceStore =
            context.watch<CurrentAttendanceStore>();
        switch (status) {
          case LoadingStatus.none:
          case LoadingStatus.loading:
            return const LoadingScreen();
          case LoadingStatus.error:
            return const NoDataScreen();
          case LoadingStatus.done:
            return Column(
              children: [
                const SizedBox(height: 20),
                GestureDetector(
                  onTap: () async {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) {
                        return ScanToCheckInScreen(
                          attendanceId: currentAttendanceStore.currentAttendance
                              .data?.attendance?.first.attendanceData?.id,
                        );
                      },
                    ));
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: 80,
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const ListTile(
                        leading: Icon(Icons.access_time_outlined,
                            size: 40, color: Colors.white),
                        title: Text(
                          "Check-In",
                          style: TextStyle(
                              fontWeight: FontWeight.w600, color: Colors.white),
                        ),
                        subtitle: Text(
                          "Check-in for your attendance.",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) {
                        return ScanToCheckOutScreen(
                            attendanceId: currentAttendanceStore
                                .currentAttendance
                                .data
                                ?.attendance
                                ?.first
                                .attendanceData
                                ?.id);
                      },
                    ));
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: 80,
                      decoration: BoxDecoration(
                        color: Colors.teal,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const ListTile(
                        leading: Icon(Icons.logout_outlined,
                            size: 40, color: Colors.white),
                        title: Text(
                          "Check-Out",
                          style: TextStyle(
                              fontWeight: FontWeight.w600, color: Colors.white),
                        ),
                        subtitle: Text(
                          "Check-out to complete your attendance.",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
        }
      }),
    );
  }
}
