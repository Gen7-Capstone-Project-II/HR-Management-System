import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:human_resource_management_system/core/enums/enums.dart';
import 'package:human_resource_management_system/modules/leave_request/models/leave_type_model.dart';
import 'package:human_resource_management_system/utils/style/colors.dart';
import 'package:lottie/lottie.dart';
import '../stores/leave_type_store.dart';

class DropdownMenuExample extends StatefulWidget {
  final Function(LeaveTypeModel?) onLeaveTypeChanged;
  const DropdownMenuExample({Key? key, required this.onLeaveTypeChanged})
      : super(key: key);

  @override
  State<DropdownMenuExample> createState() => _DropdownMenuExampleState();
}

class _DropdownMenuExampleState extends State<DropdownMenuExample> {
  final LeaveTypeStore _leaveTypeStore = LeaveTypeStore();
  LeaveTypeModel? _selectedLeaveType;

  @override
  void initState() {
    super.initState();
    _leaveTypeStore.getLeaveTypeList();
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) {
        if (_leaveTypeStore.status == LoadingStatus.loading) {
          return Center(
            child: LottieBuilder.asset(
              'assets/animations/loading.json',
              width: 50,
            ),
          );
        } else if (_leaveTypeStore.status == LoadingStatus.error) {
          return const Text('Failed to load leave types');
        } else {
          final List<LeaveTypeModel>? leaveTypes =
              _leaveTypeStore.leaveTypeList.data;
          return Container(
            width: double.infinity,
            decoration: BoxDecoration(
              border: Border.all(color: primaryColor),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<LeaveTypeModel>(
                  hint: const Text('Choose leave type'),
                  value: _selectedLeaveType,
                  onChanged: (LeaveTypeModel? value) {
                    setState(() {
                      _selectedLeaveType = value;
                      widget.onLeaveTypeChanged(value);
                    });
                  },
                  items: leaveTypes?.map((LeaveTypeModel leaveType) {
                        return DropdownMenuItem<LeaveTypeModel>(
                          value: leaveType,
                          child: Text(leaveType.leaveType ?? ''),
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
