import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:human_resource_management_system/modules/mission/stores/mission_store.dart';
import 'package:human_resource_management_system/modules/mission/stores/mission_type_store.dart';
import 'package:human_resource_management_system/modules/scan_to_login/stores/scan_to_login_store.dart';
import 'package:human_resource_management_system/modules/mission/screen/detail_mission.dart';
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
          context.read<MissionStore>().filterMissionList(
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
    MissionStore missionStore = context.watch<MissionStore>();
    MissionTypeStore missionTypeStore = context.watch<MissionTypeStore>();
    return Observer(
      builder: (context) {
        LoadingStatus status = context.watch<MissionStore>().status;
        switch (status) {
          case LoadingStatus.none:
          case LoadingStatus.loading:
            return const LoadingScreen();
          case LoadingStatus.error:
            return const NoDataScreen();
          case LoadingStatus.done:
            print("here is mission data");
            print(missionStore.missionList.data?.map((e) => e.id));
            print('mission type: ${missionTypeStore.missionTypeList.data}');

            return _buildListview(missionStore);
        }
      },
    );
  }

  Widget _buildListview(MissionStore missionStore) {
    if (missionStore.missionList.data == null ||
        missionStore.missionList.data!.isEmpty) {
      return const NoDataScreen();
    }
    return ListView.builder(
      itemCount: missionStore.missionList.data?.length,
      itemBuilder: (context, index) {
        return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => DetailMission(
                          missionModel: missionStore.missionList.data![index],
                        )),
              );
            },
            child: _buildCard(missionStore, index));
      },
    );
  }

  Widget _buildCard(MissionStore missionStore, int index) {
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
                  formatStatus(
                      missionStore.missionList.data?[index].isApproved),
                  Text(
                    '${missionStore.missionList.data?[index].missionType?.missionType}',
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
                            Text(DateFormat.yMMMd('en_US').format(missionStore
                                .missionList.data![index].startDate!))
                          ],
                        ),
                        const Icon(Icons.arrow_circle_right_outlined),
                        Row(
                          children: [
                            const Icon(Icons.calendar_month),
                            const SizedBox(
                              width: 6,
                            ),
                            Text(DateFormat.yMMMd('en_US').format(
                                missionStore.missionList.data![index].endDate!))
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
                            '${missionStore.missionList.data?[index].endDate!.difference(missionStore.missionList.data![index].startDate!).inDays} Days')
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
                          '${missionStore.missionList.data?[index].title}',
                        )
                      ],
                    ),
                    missionStore.missionList.data?[index].isApproved == null
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
                                  missionStore.missionList.data?[index]
                                              .isApproved ==
                                          1
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
                                    '${missionStore.missionList.data?[index].approvedBy?.name}',
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
