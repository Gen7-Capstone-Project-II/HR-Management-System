import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:human_resource_management_system/core/enums/enums.dart';
import 'package:human_resource_management_system/modules/mission/models/mission_type_model.dart';
import 'package:human_resource_management_system/modules/mission/stores/mission_type_store.dart';
import 'package:human_resource_management_system/utils/style/colors.dart';
import 'package:lottie/lottie.dart';

class DropdownMenuExample extends StatefulWidget {
  final Function(MissionTypeModel?) onMissionTypeChanged;
  const DropdownMenuExample({Key? key, required this.onMissionTypeChanged})
      : super(key: key);

  @override
  State<DropdownMenuExample> createState() => _DropdownMenuExampleState();
}

class _DropdownMenuExampleState extends State<DropdownMenuExample> {
  final MissionTypeStore _missionTypeStore = MissionTypeStore();
  MissionTypeModel? _selectedMissionType;

  @override
  void initState() {
    super.initState();
    _missionTypeStore.getMissionTypeListStore();
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) {
        if (_missionTypeStore.status == LoadingStatus.loading) {
          return Center(
            child: LottieBuilder.asset(
              'assets/animations/loading.json',
              width: 50,
            ),
          );
        } else if (_missionTypeStore.status == LoadingStatus.error) {
          return const Text('Failed to load leave types');
        } else {
          final List<MissionTypeModel>? missionTypes =
              _missionTypeStore.missionTypeList.data;
          return Container(
            width: double.infinity,
            decoration: BoxDecoration(
              border: Border.all(color: primaryColor),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<MissionTypeModel>(
                  hint: const Text('Choose Mission Type'),
                  value: _selectedMissionType,
                  onChanged: (MissionTypeModel? value) {
                    setState(() {
                      _selectedMissionType = value;
                      widget.onMissionTypeChanged(value);
                    });
                  },
                  items: missionTypes?.map((MissionTypeModel missionType) {
                        return DropdownMenuItem<MissionTypeModel>(
                          value: missionType,
                          child: Text(missionType.missionType ?? ''),
                        );
                      }).toList() ??
                      [],
                  style: const TextStyle(color: Colors.black),
                  icon: const Icon(Icons.arrow_drop_down),
                  iconSize: 32,
                  elevation: 16,
                  isExpanded: true,
                  dropdownColor: Colors.white,
                ),
              ),
            ),
          );
        }
      },
    );
  }
}
