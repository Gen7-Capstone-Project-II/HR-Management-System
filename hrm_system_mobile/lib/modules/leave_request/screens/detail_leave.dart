import 'package:flutter/material.dart';
import 'package:human_resource_management_system/utils/style/colors.dart';
import 'package:intl/intl.dart';

import '../models/leave_request_model.dart';

class DetailLeave extends StatefulWidget {
  final LeaveRequestModel leave;
  final int? isApproved;

  const DetailLeave({super.key, required this.leave, this.isApproved});

  @override
  State<DetailLeave> createState() => _DetailLeaveState();
}

class _DetailLeaveState extends State<DetailLeave> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          'Leave Detail',
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
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16.0),
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
                            style: TextStyle(
                                color: primaryColor,
                                fontWeight: FontWeight.w700),
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
                                      .format(widget.leave.startDate!),
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
                            style: TextStyle(
                                color: primaryColor,
                                fontWeight: FontWeight.w700),
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
                                      .format(widget.leave.endDate!),
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
                            style: TextStyle(
                                color: primaryColor,
                                fontWeight: FontWeight.w700),
                          ),
                          const SizedBox(height: 5.0),
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Row(
                              children: [
                                const Icon(Icons.timer_sharp),
                                const SizedBox(width: 6.0),
                                Text(
                                  '${widget.leave.endDate!.difference(widget.leave.startDate!).inDays} days',
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
                            'Type of Leave:',
                            style: TextStyle(
                                color: primaryColor,
                                fontWeight: FontWeight.w700),
                          ),
                          const SizedBox(height: 5.0),
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Row(
                              children: [
                                // Icon(Icons.calendar_month_outlined),
                                // SizedBox(width: 6.0),
                                Text(
                                  '${widget.leave.leaveType?.leaveType}',
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
                            'Status:',
                            style: TextStyle(
                                color: primaryColor,
                                fontWeight: FontWeight.w700),
                          ),
                          const SizedBox(height: 5.0),
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Row(
                              children: [
                                // Icon(Icons.calendar_month_outlined),
                                formatStatus(widget.leave.isApproved),
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
                            widget.leave.isApproved != null ||
                                    widget.leave.isApproved != 1
                                ? 'Rejected By:'
                                : 'Approval By:',
                            style: const TextStyle(
                                color: primaryColor,
                                fontWeight: FontWeight.w700),
                          ),
                          const SizedBox(height: 5.0),
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Row(
                              children: [
                                const Icon(Icons.person),
                                const SizedBox(width: 6.0),
                                Text(
                                  '${widget.leave.approvedBy?.name}',
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
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Reason:',
                            style: TextStyle(
                                color: primaryColor,
                                fontWeight: FontWeight.w700),
                          ),
                          const SizedBox(height: 5.0),
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Row(
                              children: [
                                // Icon(Icons.calendar_month_outlined),
                                // SizedBox(width: 6.0),
                                Text(
                                  '${widget.leave.reason}',
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
                widget.leave.isApproved == null
                    ? const SizedBox()
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
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
                              widget.leave.leaveComment ?? 'N/A',
                              style: const TextStyle(fontSize: 16),
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
        style: TextStyle(
            color: Colors.orange, fontWeight: FontWeight.w500, fontSize: 16),
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
