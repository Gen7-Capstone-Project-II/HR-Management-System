import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:human_resource_management_system/core/enums/enums.dart';
import 'package:human_resource_management_system/modules/attendance/stores/current_attendance_store.dart';
import 'package:human_resource_management_system/modules/employee_detail/stores/employee_detail_store.dart';
import 'package:human_resource_management_system/modules/scan_to_login/stores/scan_to_login_store.dart';
import 'package:human_resource_management_system/modules/announcement/screens/announcement.dart';
import 'package:human_resource_management_system/utils/style/colors.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:human_resource_management_system/utils/widgets/loading.dart';
import 'package:human_resource_management_system/utils/widgets/no_data.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:flutter_profile_picture/flutter_profile_picture.dart';

import '../../modules/attendance/screens/attendance.dart';
import '../../modules/employee_detail/screens/personal.dart';
import '../../modules/leave_request/screens/leave.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<String> months = [
    '',
    'January',
    'Febuary',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'December'
  ];

  final List<String> days = [
    '',
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
    'Sunday'
  ];
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
    Future.delayed(Duration.zero, () async {
      await context.read<CurrentAttendanceStore>().getCurrentAttendance(
          id: Provider.of<ScanToLoginStore>(context, listen: false)
              .userModel!
              .user!
              .id!,
          month: '${DateTime.now().year}-${_monthSelected()}');
    });
  }

  @override
  Widget build(BuildContext context) {
    EmployeeDetailStore store = context.watch<EmployeeDetailStore>();
    return Scaffold(
      appBar: AppBar(
        leading: const Padding(
          padding: EdgeInsets.only(left: 10),
          child: Image(
            image: AssetImage('assets/images/Logo_crop.png'),
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.notifications_active),
            iconSize: 24,
          ),
        ],
      ),
      body: RefreshIndicator(
          child: _buildLoadingStatus(store),
          // child: _buildBody(context, store),
          onRefresh: () async {
            if (mounted) {
              context.read<EmployeeDetailStore>().getEmployeeDetails(
                  Provider.of<ScanToLoginStore>(context, listen: false)
                      .userModel!
                      .user!
                      .id!);
            }
          }),
    );
  }

  Widget _buildLoadingStatus(EmployeeDetailStore store) {
    return Observer(
      builder: (context) {
        LoadingStatus status = context.watch<EmployeeDetailStore>().status;
        switch (status) {
          case LoadingStatus.none:
          case LoadingStatus.loading:
            return const LoadingScreen();
          case LoadingStatus.error:
            return const NoDataScreen();
          case LoadingStatus.done:
            return _buildBody(context, store);
        }
      },
    );
  }

  Widget _buildBody(BuildContext context, EmployeeDetailStore store) {
    return Column(
      children: [
        const SizedBox(height: 20),
        _buildProfile(store),
        Padding(
          padding: const EdgeInsets.all(16),
          child: Container(
            height: 1,
            color: Colors.grey.shade400,
          ),
        ),
        _buildCardSection(context),
        _buildAttendanceShow()
      ],
    );
  }

  Widget _buildCardSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InkWell(
              onTap: () async {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Personal()),
                );
              },
              child: buildCard(label: 'Personal', icon: FontAwesomeIcons.user),
            ),
            const SizedBox(width: 8),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Attendance()),
                );
              },
              child: buildCard(
                  label: 'Attendance', icon: FontAwesomeIcons.clipboardUser),
            )
          ],
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Leave()),
                );
              },
              child:
                  buildCard(label: 'Leave', icon: FontAwesomeIcons.tableList),
            ),
            const SizedBox(width: 8),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Announcement()),
                );
              },
              child: buildCard(
                  label: 'Announcement', icon: FontAwesomeIcons.bullhorn),
            )
          ],
        ),
      ],
    );
  }

  Widget buildCard({required String label, required IconData icon}) {
    return SizedBox(
      width: 160, // Adjust width as needed
      height: 100, // Adjust height as needed
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        elevation: 4,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FaIcon(
              icon,
              color: primaryColor,
              size: 30,
            ),
            const SizedBox(
              height: 4.0,
            ),
            Text(
              label,
              style: const TextStyle(
                  color: primaryColor, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfile(EmployeeDetailStore store) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const SizedBox(width: 25),
        ProfilePicture(
          name:
              "${store.employeeDetails.data?.firstName} ${store.employeeDetails.data?.lastName}",
          radius: 40,
          fontsize: 20,
          // img: "$fileBaseUrl${store.employeeDetails.data!.attachment ?? ""}",
        ),
        const SizedBox(width: 25),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "${store.employeeDetails.data?.firstName} ${store.employeeDetails.data?.lastName}",
              style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: primaryColor),
            ),
            const SizedBox(height: 7),
            Text(
              '${store.employeeDetails.data?.user?.idEmp}',
              style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.normal,
                  color: Color(0xff828282)),
            ),
            const SizedBox(height: 7),
            Text(
              '${store.employeeDetails.data?.position?.positionName}',
              style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.normal,
                  color: Color(0xff828282)),
            ),
          ],
        )
      ],
    );
  }

  Widget timeStatus({required String label, required Color color}) {
    return Column(
      children: [
        Text(label),
        const SizedBox(height: 5),
        Container(
          width: 25,
          height: 25,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
            border: Border.all(
              color: Colors.grey, // Stroke color
              width: 3, // Stroke width
            ),
          ),
        )
      ],
    );
  }

  Widget _buildAttendanceShow() {
    CurrentAttendanceStore store = context.watch<CurrentAttendanceStore>();
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 16.0),
          child: Column(
            children: [
              // _buildAttendance(),
              // const SizedBox(height: 16),
              Padding(
                padding:
                    const EdgeInsets.only(right: 35.0, left: 35.0, top: 12.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Today Attendance',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Attendance()),
                        );
                      },
                      child: const Text(
                        'View All',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10.0),
              _buildBoxCheckIn(store),
              const SizedBox(height: 4.0),
              _buildBoxCheckOut(store)
            ],
          ),
        ),
        // calendarToday(),
      ],
    );
  }

  Widget calendarToday() {
    return Padding(
      padding: const EdgeInsets.only(top: 16, left: 8),
      child: Container(
        height: 140,
        width: 115,
        decoration: BoxDecoration(
            color: secondaryColor, borderRadius: BorderRadius.circular(8)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
                width: 115,
                padding: const EdgeInsets.symmetric(vertical: 8),
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                  color: primaryColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(8.0),
                    topRight: Radius.circular(8.0),
                  ),
                ),
                child: Text(
                  months[DateTime.now().month],
                  style: const TextStyle(color: white, fontSize: 16),
                )),
            Text(
              DateTime.now().day.toString(),
              style: const TextStyle(fontSize: 48, fontWeight: FontWeight.w500),
            ),
            Text(days[DateTime.now().weekday]),
          ],
        ),
      ),
    );
  }

  Widget timeCheckIn({
    required String label,
    required String time,
    required Color color,
  }) {
    return Container(
      height: 35,
      width: 215,
      color: secondaryColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Center(child: Text(label)),
          const SizedBox(width: 10),
          Text('$time am'),
          const SizedBox(width: 10),
          Container(
            width: 20,
            height: 20,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
              border: Border.all(
                color: Colors.grey, // Stroke color
                width: 3, // Stroke width
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildBoxCheckIn(CurrentAttendanceStore store) {
    return SizedBox(
      height: 70,
      width: 325,
      child: Card(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
            side: const BorderSide(
              color: primaryColor,
              width: 1.0,
            )),
        child: Padding(
          padding: const EdgeInsets.only(left: 16.0, right: 16.0),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Row(
              children: [
                const Icon(
                  Icons.input_outlined,
                  color: primaryColor,
                ),
                const SizedBox(width: 16),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Check In',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(DateFormat.yMMMEd('en_US')
                        .format(store.currentAttendance.data!.date!))
                  ],
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                store.currentAttendance.data?.attendance?.first.attendanceData
                            ?.timeIn ==
                        null
                    ? const Text('_:_ AM',
                        style: TextStyle(fontWeight: FontWeight.bold))
                    : Text(
                        DateFormat('h:mm a').format(store.currentAttendance
                            .data!.attendance!.first.attendanceData!.timeIn!),
                        style: const TextStyle(fontWeight: FontWeight.bold)),
              ],
            ),
          ]),
        ),
      ),
    );
  }

  Widget _buildBoxCheckOut(CurrentAttendanceStore store) {
    return SizedBox(
      height: 70,
      width: 325,
      child: Card(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
            side: const BorderSide(
              color: primaryColor,
              width: 1.0,
            )),
        child: Padding(
          padding: const EdgeInsets.only(left: 16.0, right: 16.0),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Row(
              children: [
                const Icon(
                  Icons.output,
                  color: primaryColor,
                ),
                const SizedBox(width: 16),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Check Out',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(DateFormat.yMMMEd('en_US')
                        .format(store.currentAttendance.data!.date!)),
                  ],
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                store.currentAttendance.data?.attendance?.first.attendanceData
                            ?.timeOut ==
                        null
                    ? const Text('_:_ PM',
                        style: TextStyle(fontWeight: FontWeight.bold))
                    : Text(
                        DateFormat('h:mm a').format(store.currentAttendance
                            .data!.attendance!.first.attendanceData!.timeOut!),
                        style: const TextStyle(fontWeight: FontWeight.bold)),
              ],
            ),
          ]),
        ),
      ),
    );
  }
}
