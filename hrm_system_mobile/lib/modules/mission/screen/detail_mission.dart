import 'package:flutter/material.dart';
import 'package:human_resource_management_system/modules/mission/models/mission_model.dart';
import 'package:human_resource_management_system/utils/style/colors.dart';
import 'package:intl/intl.dart';

class DetailMission extends StatelessWidget {
  final MissionModel missionModel;
  final int? isApproved;
  const DetailMission({super.key, required this.missionModel, this.isApproved});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          'Mission Detail',
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
                            'Start Date:',
                            style: TextStyle(color: primaryColor),
                          ),
                          const SizedBox(height: 5.0),
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Row(
                              children: [
                                const Icon(Icons.calendar_month_outlined),
                                const SizedBox(width: 6.0),
                                Text(
                                  DateFormat.yMMMd('en_US')
                                      .format(missionModel.startDate!),
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
                            'End Date:',
                            style: TextStyle(color: primaryColor),
                          ),
                          const SizedBox(height: 5.0),
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Row(
                              children: [
                                const Icon(Icons.calendar_month_outlined),
                                const SizedBox(width: 6.0),
                                Text(
                                  DateFormat.yMMMd('en_US')
                                      .format(missionModel.endDate!),
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
                            'Duration:',
                            style: TextStyle(color: primaryColor),
                          ),
                          const SizedBox(height: 5.0),
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Row(
                              children: [
                                const Icon(Icons.timer_sharp),
                                const SizedBox(width: 6.0),
                                Text(
                                  '${missionModel.endDate!.difference(missionModel.startDate!).inDays} days',
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
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Status:',
                            style: TextStyle(color: primaryColor),
                          ),
                          const SizedBox(height: 5.0),
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Row(
                              children: [
                                // Icon(Icons.calendar_month_outlined),
                                formatStatus(missionModel.isApproved),
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
                            'Requested by:',
                            style: TextStyle(color: primaryColor),
                          ),
                          const SizedBox(height: 5.0),
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Row(
                              children: [
                                const Icon(Icons.person),
                                const SizedBox(width: 6.0),
                                Text(
                                  '${missionModel.user?.name}',
                                  style: const TextStyle(fontSize: 16),
                                )
                              ],
                            ),
                          ),
                          const SizedBox(height: 16.0),
                        ],
                      ),
                    ),
                    missionModel.approvedBy == null
                        ? const SizedBox()
                        : Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  missionModel.isApproved != null ||
                                          missionModel.isApproved != 1
                                      ? 'Rejected By'
                                      : 'Approval By:',
                                  style: const TextStyle(color: primaryColor),
                                ),
                                const SizedBox(height: 5.0),
                                Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: Row(
                                    children: [
                                      const Icon(Icons.person),
                                      const SizedBox(width: 6.0),
                                      Text(
                                        '${missionModel.approvedBy?.name}',
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
                            'Type of Misiion:',
                            style: TextStyle(color: primaryColor),
                          ),
                          const SizedBox(height: 5.0),
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Row(
                              children: [
                                // Icon(Icons.calendar_month_outlined),
                                // SizedBox(width: 6.0),
                                Text(
                                  '${missionModel.missionType?.missionType}',
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
                      'Note:',
                      style: TextStyle(color: primaryColor),
                    ),
                    const SizedBox(height: 5.0),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Row(
                        children: [
                          // Icon(Icons.calendar_month_outlined),
                          // SizedBox(width: 6.0),
                          Text(
                            '${missionModel.note}',
                            style: const TextStyle(fontSize: 16),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(height: 16.0),
                  ],
                ),
                missionModel.isApproved == null
                    ? const SizedBox()
                    : Column(
                        children: [
                          Container(
                            width: double.infinity,
                            height: 1,
                            color: primaryColor,
                          ),
                          const SizedBox(height: 16.0),
                          const Text(
                            'Comment:',
                            style: TextStyle(color: primaryColor),
                          ),
                          const SizedBox(height: 5.0),
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Row(
                              children: [
                                // Icon(Icons.calendar_month_outlined),
                                Text(
                                  missionModel.missionComment ?? 'N/A',
                                  style: const TextStyle(fontSize: 16),
                                )
                              ],
                            ),
                          ),
                        ],
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
            TextStyle(color: yellow, fontWeight: FontWeight.w500, fontSize: 16),
      );
    } else if (isApprove == 1) {
      return const Text(
        'Approved',
        style: TextStyle(
            color: primaryColor, fontWeight: FontWeight.w500, fontSize: 16),
      );
    } else {
      return const Text(
        'Rejected',
        style: TextStyle(
            color: Colors.red, fontWeight: FontWeight.w500, fontSize: 16),
      );
    }
  }
}
