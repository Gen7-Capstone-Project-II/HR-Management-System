import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:human_resource_management_system/modules/leave_request/models/leave_request_model.dart';
import 'package:human_resource_management_system/modules/leave_request/screens/detail_leave.dart';
import 'package:human_resource_management_system/modules/leave_request/stores/leave_request_store.dart';
import 'package:human_resource_management_system/modules/scan_to_login/stores/scan_to_login_store.dart';
import 'package:human_resource_management_system/utils/widgets/loading.dart';
import 'package:human_resource_management_system/utils/widgets/no_data.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../../core/enums/enums.dart';
import '../../../utils/style/colors.dart';

class ListviewExapnadable extends StatefulWidget {
  const ListviewExapnadable({super.key, required this.approve});
  final dynamic approve;

  @override
  State<ListviewExapnadable> createState() => _ListviewExapnadableState();
}

class _ListviewExapnadableState extends State<ListviewExapnadable> {
  @override
  void initState() {
    super.initState();
    if (mounted) {
      Future.delayed(
        Duration.zero,
        () async {
          context.read<LeaveRequestStore>().filterLeaveRequestList(
              userId: Provider.of<ScanToLoginStore>(context, listen: false)
                  .userModel!
                  .user!
                  .id!,
              param: widget.approve);
        },
      );
    }
  }

  final List<String> items = List.generate(20, (index) => 'Item $index');
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: _buildLoadingStatus());
  }

  Widget _buildLoadingStatus() {
    LeaveRequestStore leaveRequestStore = context.watch<LeaveRequestStore>();
    return Observer(
      builder: (context) {
        LoadingStatus status = context.watch<LeaveRequestStore>().status;
        switch (status) {
          case LoadingStatus.none:
          case LoadingStatus.loading:
            return const LoadingScreen();
          case LoadingStatus.error:
            return const NoDataScreen();
          case LoadingStatus.done:
            return _buildListview(leaveRequestStore);
        }
      },
    );
  }

  Widget _buildListview(LeaveRequestStore leaveRequestStore) {
    return ListView.builder(
      itemCount: leaveRequestStore.leaveRequestList.data?.length,
      itemBuilder: (context, index) {
        return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => DetailLeave(
                          leave:
                              leaveRequestStore.leaveRequestList.data![index],
                        )),
              );
            },
            child: _buildCard(leaveRequestStore.leaveRequestList.data![index]));
      },
    );
  }

  Widget _buildCard(LeaveRequestModel leave) {
    return Card(
      shape: RoundedRectangleBorder(
        side: const BorderSide(color: primaryColor, width: 1),
        borderRadius: BorderRadius.circular(16.0),
      ),
      margin: const EdgeInsets.only(left: 8.0, right: 8.0, top: 16.0),
      child: Column(
        children: [
          Container(
            decoration: const BoxDecoration(
              color: primaryColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
            ),
            height: 50,
            child: Padding(
              padding: const EdgeInsets.only(left: 16, right: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  formatStatus(leave.isApproved),
                  Text(
                    '${leave.leaveType?.leaveType}',
                    style: const TextStyle(color: white),
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
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.calendar_month),
                            const SizedBox(width: 6),
                            Text(DateFormat.yMMMd('en_US')
                                .format(leave.startDate!))
                          ],
                        ),
                        const Icon(Icons.arrow_circle_right_outlined),
                        Row(
                          children: [
                            const Icon(Icons.calendar_month),
                            const SizedBox(
                              width: 6,
                            ),
                            Text(DateFormat.yMMMd('en_US')
                                .format(leave.endDate!))
                          ],
                        )
                      ],
                    ),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        const Icon(
                          Icons.av_timer_outlined,
                        ),
                        const SizedBox(
                          width: 6,
                        ),
                        Text(
                            '${leave.endDate!.difference(leave.startDate!).inDays} Days')
                      ],
                    ),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        const Icon(
                          Icons.chat_outlined,
                        ),
                        const SizedBox(
                          width: 6,
                        ),
                        Text(
                          '${leave.reason}',
                        )
                      ],
                    ),
                    leave.isApproved == null
                        ? const SizedBox(height: 6)
                        : Column(
                            children: [
                              const SizedBox(height: 6),
                              const Divider(
                                color: Colors.black,
                                thickness: 1,
                                height: 20,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  leave.isApproved == 1
                                      ? const Text(
                                          'Approved By :',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w500),
                                        )
                                      : const Text(
                                          'Rejected By :',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w500),
                                        ),
                                  Text(
                                    '${leave.approvedBy?.name}',
                                  )
                                ],
                              ),
                              const SizedBox(height: 6),
                            ],
                          ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget formatStatus(int? isApprove) {
    if (isApprove == null) {
      return const Text(
        'Pending',
        style: TextStyle(color: Colors.orange, fontWeight: FontWeight.w500),
      );
    } else if (isApprove == 1) {
      return const Text(
        'Approved',
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
      );
    } else {
      return const Text(
        'Rejected',
        style: TextStyle(color: Colors.red, fontWeight: FontWeight.w500),
      );
    }
  }
}
