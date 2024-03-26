import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:human_resource_management_system/core/enums/enums.dart';
import 'package:human_resource_management_system/modules/attendance/models/attendance_model.dart';
import 'package:human_resource_management_system/modules/attendance/stores/attendance_store.dart';
import 'package:human_resource_management_system/modules/scan_to_login/stores/scan_to_login_store.dart';
import 'package:human_resource_management_system/my_home.dart';
import 'package:human_resource_management_system/utils/style/colors.dart';
import 'package:human_resource_management_system/utils/widgets/loading.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class Attendance extends StatefulWidget {
  const Attendance({super.key});

  @override
  State<Attendance> createState() => _AttendanceState();
}

class _AttendanceState extends State<Attendance> {
  final List<String> _months = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December'
  ];

  final List<int> _years =
      List.generate(10, (index) => DateTime.now().year - index);

  late String _selectedMonth;
  late int _selectedYear;
  late String _selectedMonthIndex;

  String _monthSelected({int? month}) {
    if (month != null) {
      if (month < 10) {
        return '0$month';
      } else {
        return month.toString();
      }
    } else {
      int index = DateTime.now().month;
      if (index < 10) {
        return '0$index';
      } else {
        return index.toString();
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _selectedMonth = _months[DateTime.now().month - 1];
    _selectedYear = DateTime.now().year;
    _selectedMonthIndex = _monthSelected();
    if (mounted) {
      Future.delayed(Duration.zero, () async {
        await context.read<AttendanceStore>().getAttendanceList(
            Provider.of<ScanToLoginStore>(context, listen: false)
                .userModel!
                .user!
                .id!,
            '$_selectedYear-$_selectedMonthIndex');
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return const MyHome();
            }));
          },
          icon: const Icon(Icons.arrow_back, color: white),
        ),
        title: const Text(
          'Attendance',
          style: TextStyle(color: white),
        ),
        backgroundColor: primaryColor,
        centerTitle: true,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          // Reload attendance data when refreshing
          await _refreshAttendanceData();
        },
        child: _buildBody(),
      ),
    );
  }

  Future<void> _refreshAttendanceData() async {
    // You can reload attendance data here
    AttendanceStore attendanceStore =
        Provider.of<AttendanceStore>(context, listen: false);
    String userId = Provider.of<ScanToLoginStore>(context, listen: false)
        .userModel!
        .user!
        .id!;
    await attendanceStore.getAttendanceList(
        userId, '$_selectedYear-$_selectedMonthIndex');
  }

  Widget _buildBody() {
    return Observer(builder: (context) {
      LoadingStatus status = context.watch<AttendanceStore>().status;
      AttendanceStore attendanceStore = Provider.of<AttendanceStore>(context);
      switch (status) {
        case LoadingStatus.none:
        case LoadingStatus.loading:
          return const LoadingScreen();
        case LoadingStatus.error:
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              _buildCalender(attendanceStore),
              const SizedBox(
                height: 300,
              ),
              const Text('Wrong Date!!! Please select another date.'),
            ],
          );
        case LoadingStatus.done:
          List<AttendanceDataListModel>? filteredAttendances =
              attendanceStore.attendanceList.attendances?.where((attendance) {
            // Check if the date is not a weekend (Saturday or Sunday)
            return attendance.date?.weekday != DateTime.saturday &&
                attendance.date?.weekday != DateTime.sunday;
          }).toList();
          // return Column(
          //   children: [
          //     Text(attendanceStore.attendanceList.attendances!
          //         .map((e) => e.isLeave)
          //         .toString()),
          //     Text(attendanceStore.attendanceList.attendances!
          //         .map((e) => e.attendanceDataList?.attendanceData!.first)
          //         .toString()),
          //   ],
          // );
          return SingleChildScrollView(
            child: Column(
              children: [
                _buildCalender(attendanceStore),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: DataTable(
                    // horizontalMargin: 16.0,
                    headingRowColor: MaterialStateProperty.all(primaryColor),
                    headingTextStyle: const TextStyle(color: white),
                    headingRowHeight: 30,
                    dataRowHeight: 40,
                    border: TableBorder.all(color: Colors.grey),
                    columns: const [
                      DataColumn(label: Text('Date')),
                      DataColumn(label: Text('Time In')),
                      DataColumn(label: Text('Time Out')),
                    ],
                    rows: filteredAttendances?.map((e) {
                          return DataRow(cells: [
                            DataCell(Text(
                              DateFormat('E - d').format(e.date!),
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                            )),
                            _buildTimeIn(e),
                            _buildTimeOut(e),
                          ]);
                        }).toList() ??
                        [],
                  ),
                ),
              ],
            ),
          );
      }
    });
  }

  DataCell _buildTimeIn(AttendanceDataListModel e) {
    if (e.isLeave) {
      return const DataCell(Text(
        'Permission',
        style: TextStyle(color: Colors.blue, fontSize: 13),
      ));
    } else if (e.attendanceDataList != null &&
        e.attendanceDataList!.attendanceData != null &&
        e.attendanceDataList!.attendanceData!.first.timeIn != null) {
      return DataCell(Text(
        DateFormat('hh:mm a')
            .format(e.attendanceDataList!.attendanceData!.first.timeIn!),
        style: const TextStyle(
            fontSize: 14, fontWeight: FontWeight.w500, color: primaryColor),
      ));
    } else {
      DateTime today = DateTime.now();
      bool isGreater = e.date!.isAfter(today);
      if (isGreater) {
        return const DataCell(
          Text(
            '__:__',
            style: TextStyle(color: Colors.grey, fontSize: 13),
          ),
        );
      } else {
        return const DataCell(
          Text(
            'Absent',
            style: TextStyle(color: Colors.red, fontSize: 13),
          ),
        );
      }
    }
  }

  DataCell _buildTimeOut(AttendanceDataListModel e) {
    if (e.isLeave) {
      return const DataCell(Text(
        'Permission',
        style: TextStyle(color: Colors.blue, fontSize: 13),
      ));
    } else if (e.attendanceDataList != null &&
        e.attendanceDataList!.attendanceData != null &&
        e.attendanceDataList!.attendanceData!.first.timeOut != null) {
      return DataCell(Text(
        DateFormat('hh:mm a')
            .format(e.attendanceDataList!.attendanceData!.first.timeOut!),
        style: const TextStyle(
            fontSize: 14, fontWeight: FontWeight.w500, color: primaryColor),
      ));
    } else {
      DateTime today = DateTime.now();
      bool isGreater = e.date!.isAfter(today);
      if (isGreater) {
        return const DataCell(
          Text(
            '__:__',
            style: TextStyle(color: Colors.grey, fontSize: 13),
          ),
        );
      } else {
        return const DataCell(
          Text(
            'Absent',
            style: TextStyle(color: Colors.red, fontSize: 13),
          ),
        );
      }
    }
  }

  Widget _buildCalender(AttendanceStore attendanceStore) {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
      DropdownButton<String>(
        value: _selectedMonth,
        onChanged: (String? newValue) {
          setState(() {
            _selectedMonth = newValue!;
            int index = _months.indexOf(_selectedMonth) + 1;
            _selectedMonthIndex = _monthSelected(month: index);
            if (mounted) {
              Future.delayed(Duration.zero, () async {
                await context.read<AttendanceStore>().getAttendanceList(
                    Provider.of<ScanToLoginStore>(context, listen: false)
                        .userModel!
                        .user!
                        .id!,
                    '$_selectedYear-$_selectedMonthIndex');
              });
            }
          });
        },
        items: _months.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      ),
      const SizedBox(width: 20),
      DropdownButton<int>(
        value: _selectedYear,
        onChanged: (int? newValue) {
          setState(() {
            _selectedYear = newValue!;
            if (mounted) {
              Future.delayed(Duration.zero, () async {
                await context.read<AttendanceStore>().getAttendanceList(
                    Provider.of<ScanToLoginStore>(context, listen: false)
                        .userModel!
                        .user!
                        .id!,
                    '$_selectedYear-$_selectedMonthIndex');
              });
            }
          });
        },
        items: _years.map<DropdownMenuItem<int>>((int value) {
          return DropdownMenuItem<int>(
            value: value,
            child: Text(value.toString()),
          );
        }).toList(),
      )
    ]);
  }
}
