import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:human_resource_management_system/core/enums/enums.dart';
import 'package:human_resource_management_system/modules/overtime/model/over_time_model.dart';
import 'package:human_resource_management_system/modules/overtime/stores/over_time_store.dart';
import 'package:human_resource_management_system/modules/scan_to_login/stores/scan_to_login_store.dart';
import 'package:human_resource_management_system/modules/overtime/screen/detail_overtime.dart';
import 'package:human_resource_management_system/utils/style/colors.dart';
import 'package:human_resource_management_system/utils/widgets/loading.dart';
import 'package:human_resource_management_system/utils/widgets/no_data.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class FilterOvertimeScreen extends StatefulWidget {
  const FilterOvertimeScreen({super.key, this.approve});
  final dynamic approve;

  @override
  State<FilterOvertimeScreen> createState() => _FilterOvertimeScreenState();
}

class _FilterOvertimeScreenState extends State<FilterOvertimeScreen> {
  String _calculateDuration(String? startTime, String? endTime) {
    if (startTime == null || endTime == null) {
      return ''; // Return empty string if either startTime or endTime is null
    }

    // Parse start time and end time
    List<String> startParts = startTime.split(':');
    List<String> endParts = endTime.split(':');

    // Extract hours and minutes
    int startHour = int.parse(startParts[0]);
    int startMinute = int.parse(startParts[1]);
    int endHour = int.parse(endParts[0]);
    int endMinute = int.parse(endParts[1]);

    // Calculate total minutes
    int totalMinutes =
        (endHour * 60 + endMinute) - (startHour * 60 + startMinute);

    // Calculate hours and remaining minutes
    int hours = totalMinutes ~/ 60;
    int minutes = totalMinutes % 60;

    // Return formatted duration string
    return '$hours hr $minutes min';
  }

  @override
  void initState() {
    super.initState();
    if (mounted) {
      Future.delayed(Duration.zero, () async {
        await context.read<OverTimeStore>().filterOverTimeList(
            userId: Provider.of<ScanToLoginStore>(context, listen: false)
                .userModel!
                .user!
                .id!,
            param: widget.approve);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    OverTimeStore store = context.watch<OverTimeStore>();
    return Observer(builder: (context) {
      LoadingStatus status = context.watch<OverTimeStore>().status;
      switch (status) {
        case LoadingStatus.none:
        case LoadingStatus.loading:
          return const LoadingScreen();
        case LoadingStatus.error:
          return const NoDataScreen();
        case LoadingStatus.done:
          return store.overTimeList.data!.isEmpty
              ? const NoDataScreen()
              : ListView.builder(
                  itemCount: store.overTimeList.data?.length ?? 0,
                  itemBuilder: (context, index) {
                    OverTimeModel overtime = store.overTimeList.data![index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => DetailOvertime(
                                    overTime: store.overTimeList.data![index],
                                  )),
                        );
                      },
                      child: Card(
                        shape: RoundedRectangleBorder(
                          side: const BorderSide(color: primaryColor, width: 1),
                          borderRadius: BorderRadius.circular(16.0),
                        ),
                        margin: const EdgeInsets.only(
                            left: 8.0, right: 8.0, top: 16.0),
                        child: Column(
                          children: [
                            Container(
                              decoration: const BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(16.0),
                                  topRight: Radius.circular(16.0),
                                ),
                                color: primaryColor,
                              ),
                              height: 50,
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(left: 16, right: 16),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    formatStatus(overtime.isApproved),
                                    Row(
                                      children: [
                                        const SizedBox(
                                          width: 6,
                                        ),
                                        Text(
                                          '${store.overTimeList.data?[index].title}',
                                          style: const TextStyle(color: white),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Card(
                                shape: RoundedRectangleBorder(
                                  side: const BorderSide(
                                    color: primaryColor,
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              const Icon(
                                                Icons.calendar_month,
                                              ),
                                              const SizedBox(width: 6),
                                              Text(
                                                DateFormat.yMMMMd('en_US')
                                                    .format(DateTime.parse(
                                                        overtime.dateOT!)),
                                              )
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              const Icon(Icons.access_time),
                                              const SizedBox(width: 6),
                                              Text(
                                                '${_formatTime(store.overTimeList.data?[index].timeFrom)} - ${_formatTime(store.overTimeList.data?[index].timeTo)}',
                                              )
                                            ],
                                          )
                                        ],
                                      ),
                                      const SizedBox(height: 6),
                                      Row(
                                        children: [
                                          const Icon(Icons.timer_outlined),
                                          const SizedBox(width: 6),
                                          Text(
                                            _calculateDuration(
                                                store.overTimeList.data?[index]
                                                    .timeFrom,
                                                store.overTimeList.data?[index]
                                                    .timeTo),
                                          )
                                        ],
                                      ),
                                      const SizedBox(height: 6),
                                      Row(
                                        children: [
                                          const Icon(Icons.chat_outlined),
                                          const SizedBox(width: 6),
                                          Text(
                                            '${store.overTimeList.data?[index].reason}',
                                          )
                                        ],
                                      ),
                                      const SizedBox(height: 6),
                                      const Divider(
                                        color: Colors.black54,
                                        thickness: 0.5,
                                        height: 20,
                                      ),
                                      Row(
                                        children: [
                                          const Icon(Icons.person_pin_outlined),
                                          const SizedBox(width: 6),
                                          Text(
                                            '${store.overTimeList.data?[index].employee?.name}',
                                          )
                                        ],
                                      ),
                                      const SizedBox(height: 6),
                                    ],
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                );
      }
    });
  }

  Widget formatStatus(int? isApprove) {
    if (isApprove == null) {
      return const Text(
        'Pending',
        style: TextStyle(color: Colors.orange),
      );
    } else if (isApprove == 1) {
      return const Text(
        'Approved',
        style: TextStyle(color: Colors.white),
      );
    } else {
      return const Text(
        'Rejected',
        style: TextStyle(color: Colors.red),
      );
    }
  }

  String _formatTime(String? fullTime) {
    if (fullTime == null) return ''; // Return empty string if fullTime is null
    // Split the time string by ':' to separate hours, minutes, and seconds
    List<String> timeParts = fullTime.split(':');
    // Extract hours and minutes
    String hour = timeParts[0];
    String minute = timeParts[1];
    // Format the time to display only hour and minute parts
    return '$hour:$minute';
  }
}
