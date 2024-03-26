import 'package:flutter/material.dart';
import 'package:human_resource_management_system/modules/overtime/model/over_time_model.dart';
import 'package:human_resource_management_system/utils/style/colors.dart';
import 'package:intl/intl.dart';

class DetailOvertime extends StatelessWidget {
  final OverTimeModel overTime;
  final int? isApproved;
  const DetailOvertime({super.key, required this.overTime, this.isApproved});

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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          'Overtime Detail',
          style: TextStyle(color: white),
        ),
        centerTitle: true,
        backgroundColor: primaryColor,
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          shape: RoundedRectangleBorder(
            side: const BorderSide(
              color: primaryColor, // Set border color here
              width: 2, // Set border width here
            ),
            borderRadius: BorderRadius.circular(10), // Set border radius here
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Tile:',
                            style: TextStyle(
                              color: primaryColor,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(height: 5.0),
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Row(
                              children: [
                                Text(
                                  '${overTime.title}',
                                  style: const TextStyle(fontSize: 15),
                                )
                              ],
                            ),
                          ),
                          const SizedBox(height: 16.0),
                        ],
                      ),
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Reason:',
                            style: TextStyle(
                              color: primaryColor,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(height: 5.0),
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Row(
                              children: [
                                // Icon(Icons.calendar_month_outlined),
                                // SizedBox(width: 6.0),
                                Text(
                                  '${overTime.reason}',
                                  style: const TextStyle(fontSize: 16),
                                )
                              ],
                            ),
                          ),
                          const SizedBox(height: 16.0),
                        ],
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Time From:',
                            style: TextStyle(
                              color: primaryColor,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(height: 5.0),
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Row(
                              children: [
                                const Icon(Icons.timer_outlined),
                                const SizedBox(width: 6.0),
                                Text(
                                  _formatTime(overTime.timeFrom),
                                  style: const TextStyle(fontSize: 16),
                                )
                              ],
                            ),
                          ),
                          const SizedBox(height: 16.0),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'To Time:',
                            style: TextStyle(
                              color: primaryColor,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(height: 5.0),
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Row(
                              children: [
                                const Icon(Icons.timer_outlined),
                                const SizedBox(width: 6.0),
                                Text(
                                  _formatTime(overTime.timeTo),
                                  style: const TextStyle(fontSize: 16),
                                )
                              ],
                            ),
                          ),
                          const SizedBox(height: 16.0),
                        ],
                      ),
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Amount Time:',
                            style: TextStyle(
                              color: primaryColor,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(height: 5.0),
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Row(
                              children: [
                                const Icon(Icons.timer_outlined),
                                const SizedBox(width: 6.0),
                                Text(
                                  _calculateDuration(
                                      overTime.timeFrom, overTime.timeTo),
                                  style: const TextStyle(
                                    fontSize: 16,
                                  ),
                                )
                              ],
                            ),
                          ),
                          const SizedBox(height: 16.0),
                        ],
                      ),
                    ),
                    // Expanded(
                    //   child: Column(
                    //     crossAxisAlignment: CrossAxisAlignment.start,
                    //     children: [
                    //        Text(
                    //      'Leave Type',
                    //         style: const TextStyle(color: primaryColor, fontWeight: FontWeight.w700,),
                    //       ),
                    //       const SizedBox(height: 5.0),
                    //       Padding(
                    //         padding: const EdgeInsets.only(left: 8.0),
                    //         child: Row(
                    //           children: [
                    //             const Icon(Icons.timer_outlined),
                    //             const SizedBox(width: 6.0),
                    //             Text(
                    //               '${overTime.}',
                    //               style: const TextStyle(

                    //                   fontSize: 16),
                    //             )
                    //           ],
                    //         ),
                    //       ),
                    //       const SizedBox(height: 16.0),
                    //     ],
                    //   ),
                    // )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Requested by:',
                            style: TextStyle(
                              color: primaryColor,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(height: 5.0),
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Row(
                              children: [
                                const Icon(Icons.person),
                                const SizedBox(width: 6.0),
                                Text(
                                  '${overTime.employee?.name}',
                                  style: const TextStyle(fontSize: 16),
                                )
                              ],
                            ),
                          ),
                          const SizedBox(height: 16.0),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            overTime.isApproved == 1
                                ? 'Approval By:'
                                : 'Rejected By',
                            style: const TextStyle(
                              color: primaryColor,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(height: 5.0),
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Row(
                              children: [
                                const Icon(Icons.person),
                                const SizedBox(width: 6.0),
                                Text(
                                  overTime.approvedBy?.name ?? 'N/A',
                                  style: const TextStyle(fontSize: 16),
                                )
                              ],
                            ),
                          ),
                          const SizedBox(height: 16.0),
                        ],
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Date:',
                      style: TextStyle(
                        color: primaryColor,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 5.0),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Row(
                        children: [
                          const Icon(Icons.calendar_month_outlined),
                          const SizedBox(width: 6.0),
                          Text(
                            DateFormat.yMMMMd('en_US')
                                .format(DateTime.parse(overTime.dateOT!)),
                            style: const TextStyle(fontSize: 16),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(height: 16.0),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Status:',
                      style: TextStyle(
                        color: primaryColor,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 5.0),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Row(
                        children: [
                          // Icon(Icons.calendar_month_outlined),
                          formatStatus(overTime.isApproved),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16.0),
                  ],
                ),
                Container(
                  width: double.infinity,
                  height: 1,
                  color: primaryColor,
                ),
                const SizedBox(height: 16.0),
                const Text(
                  'Comment:',
                  style: TextStyle(
                    color: primaryColor,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 5.0),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text(
                    overTime.overtimeComment ?? 'N/A',
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget formatStatus(int? isApprove) {
    if (isApprove == null) {
      return const Text(
        'Pending',
        style:
            TextStyle(color: yellow, fontWeight: FontWeight.bold, fontSize: 16),
      );
    } else if (isApprove == 1) {
      return const Text(
        'Approved',
        style: TextStyle(
            color: primaryColor, fontWeight: FontWeight.bold, fontSize: 16),
      );
    } else {
      return const Text(
        'Rejected',
        style: TextStyle(
            color: Colors.red, fontWeight: FontWeight.bold, fontSize: 16),
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
