import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:human_resource_management_system/core/enums/enums.dart';
import 'package:human_resource_management_system/modules/employee_detail/models/relative_model.dart';
import 'package:human_resource_management_system/modules/employee_detail/stores/emergency_contact_store.dart';
import 'package:human_resource_management_system/utils/style/colors.dart';
import 'package:lottie/lottie.dart';

class RelativeDropDown extends StatefulWidget {
  const RelativeDropDown(
      {super.key, required this.onRelativeChanged, this.initialValue});
  final Function(RelativeModel?) onRelativeChanged;
  final RelativeModel? initialValue;

  @override
  State<RelativeDropDown> createState() => _RelativeDropDownState();
}

class _RelativeDropDownState extends State<RelativeDropDown> {
  final EmergencyContactStore _relativeStore = EmergencyContactStore();
  RelativeModel? _selectedRelativeType;
  @override
  @override
  void initState() {
    super.initState();
    _relativeStore.getRelativeTypeList();
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) {
        if (_relativeStore.state == LoadingStatus.loading) {
          return Center(
            child: LottieBuilder.asset(
              'assets/animations/loading.json',
              width: 50,
            ),
          );
        } else if (_relativeStore.state == LoadingStatus.error) {
          return const Text('Failed to load Relative types');
        } else {
          final List<RelativeModel>? leaveTypes =
              _relativeStore.relativeTypeListModel.data;
          return Container(
            width: double.infinity,
            decoration: BoxDecoration(
              border: Border.all(color: grey),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<RelativeModel>(
                  hint: Text(widget.initialValue?.relativeName.toString() ??
                      'Choose Relative Type'),
                  value: _selectedRelativeType,
                  onChanged: (RelativeModel? value) {
                    setState(() {
                      _selectedRelativeType = value;
                      widget.onRelativeChanged(value);
                    });
                  },
                  items: leaveTypes?.map((RelativeModel relativeType) {
                        return DropdownMenuItem<RelativeModel>(
                          value: relativeType,
                          child: Text(
                            relativeType.relativeName ?? '',
                            style: const TextStyle(color: black),
                          ),
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
