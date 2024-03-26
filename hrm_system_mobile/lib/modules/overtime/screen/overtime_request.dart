import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:human_resource_management_system/modules/overtime/services/over_time_service.dart';
import 'package:human_resource_management_system/modules/scan_to_login/stores/scan_to_login_store.dart';
import 'package:human_resource_management_system/modules/overtime/screen/overtime.dart';
import 'package:human_resource_management_system/utils/style/colors.dart';
import 'package:human_resource_management_system/utils/widgets/loading.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

class OvertimeRequest extends StatefulWidget {
  const OvertimeRequest({Key? key}) : super(key: key);

  @override
  State<OvertimeRequest> createState() => _OvertimeRequestState();
}

class _OvertimeRequestState extends State<OvertimeRequest> {
  TimeOfDay _startTime = const TimeOfDay(hour: 10, minute: 0);
  TimeOfDay _endTime = const TimeOfDay(hour: 10, minute: 0);

  late TextEditingController _titleController = TextEditingController();
  late TextEditingController _reasonController = TextEditingController();

  bool isLoading = false;

  Future<void> _selectTime(BuildContext context, bool isStartTime) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: isStartTime ? _startTime : _endTime,
    );
    if (picked != null) {
      setState(() {
        if (isStartTime) {
          _startTime = picked;
        } else {
          _endTime = picked;
        }
      });
    }
  }

  String getFormattedDate(DateTime date) {
    return DateFormat('dd-MMM-yyyy').format(date);
  }

  late TextEditingController _dateController = TextEditingController();
  late DateTime _selectedDate;

  @override
  void initState() {
    super.initState();
    _selectedDate = DateTime.now(); // Initialize with current date
    _dateController.text = getFormattedDate(_selectedDate);
  }

  Future<void> selectDate(context) async {
    DateTime? _picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2100));

    if (_picked != null && _picked != _selectedDate) {
      setState(() {
        _selectedDate = _picked;
        _dateController.text = getFormattedDate(_picked);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: white),
        backgroundColor: primaryColor,
        title: const Text(
          'Overtime Request',
          style: TextStyle(color: white),
        ),
        centerTitle: true,
      ),
      body: _buildBody(context),
    );
  }

  Widget _buildDatePicker(context) {
    return SizedBox(
      // color: white,
      height: 70,
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.only(top: 6, bottom: 10),
        child: TextField(
          controller: _dateController,
          decoration: const InputDecoration(
            hintText: '{getFormattedDate(_selectedDate)}',
            // filled: true,
            fillColor: lowGrey,
            prefixIcon: Icon(
              Icons.calendar_month,
              color: primaryColor,
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  color: Colors.grey), // Remove the line under the TextField
            ),
          ),
          readOnly: true,
          onTap: () {
            selectDate(context);
          },
        ),
      ),
    );
  }

  Widget _buildBody(context) {
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    return isLoading
        ? const LoadingScreen()
        : SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: _buildTextField('Title', 'Title'),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 8,
                        left: 8,
                        right: 8,
                      ),
                      child: SizedBox(
                        width: double.infinity,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Select Date',
                                  style: TextStyle(
                                      color: primaryColor,
                                      fontWeight: FontWeight.bold),
                                ),
                                _buildDate()
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        width: double.infinity,
                        child: _buildTextField('Reason', 'Reason'),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    _buildButtonSave(context, _formKey)
                  ],
                ),
              ),
            ),
          );
  }

  Widget _buildTextField(String hintText, String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
                color: primaryColor, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 6),
          TextFormField(
            controller: title == 'Title' ? _titleController : _reasonController,
            validator: (value) {
              if (value!.isEmpty) {
                return title == 'Title'
                    ? 'Title is required'
                    : 'Reason is required';
              } else {
                return null;
              }
            },
            maxLines: null, // allow TextField to expand vertically
            decoration: InputDecoration(
              hintText: hintText,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: const BorderSide(
                  color: Colors.grey, // specify border color here
                  width: 1.0,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(
                    8.0), // Adjust the border radius as needed
                borderSide: const BorderSide(
                  color: primaryColor, // Change the border color if needed
                  width: 2.0, // Adjust the border width if needed
                ),
              ),
              contentPadding: const EdgeInsets.symmetric(
                  vertical: 12.0,
                  horizontal: 16.0), // Adjust content padding as needed
            ),
          ),
        ],
      ),
    );
  }

  double calculateTotalTime(TimeOfDay startTime, TimeOfDay endTime) {
    int startMinutes = startTime.hour * 60 + startTime.minute;
    int endMinutes = endTime.hour * 60 + endTime.minute;

    int totalMinutes = (endMinutes - startMinutes + (24 * 60)) % (24 * 60);

    double totalHours = totalMinutes / 60.0;

    return totalHours;
  }

  Widget _buildButtonSave(context, GlobalKey<FormState> formKey) {
    return SizedBox(
      height: 50,
      width: 100,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
        ),
        onPressed: () async {
          if (formKey.currentState!.validate()) {
            double totalTime = calculateTotalTime(_startTime, _endTime);
            print(totalTime);
            OverTimeService service = OverTimeService();
            setState(() {
              isLoading = true;
            });
            await service
                .addOverTimeService(
                    token:
                        (Provider.of<ScanToLoginStore>(context, listen: false)
                            .userModel!
                            .token!),
                    userId:
                        (Provider.of<ScanToLoginStore>(context, listen: false)
                            .userModel!
                            .user!
                            .id!),
                    date: DateFormat('yyyy-MM-dd').format(_selectedDate),
                    startTime:
                        '${_startTime.hour.toString().padLeft(2, '0')}:${_startTime.minute.toString().padRight(2, '0')}',
                    endTime:
                        '${_endTime.hour.toString().padLeft(2, '0')}:${_endTime.minute.toString().padRight(2, '0')}',
                    reason: _reasonController.text,
                    title: _titleController.text,
                    totalTime: totalTime)
                .then((value) {
              if (value.statusCode == 200 || value.statusCode == 201) {
                QuickAlert.show(
                        context: context,
                        type: QuickAlertType.success,
                        title: 'Success',
                        text: 'Request OverTime successfully!!',
                        showConfirmBtn: false,
                        autoCloseDuration: const Duration(seconds: 2))
                    .then((value) => Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const Overtime(),
                          ),
                        ));
              } else {
                setState(() {
                  isLoading = false;
                });
                QuickAlert.show(
                  context: context,
                  type: QuickAlertType.error,
                  title: 'Invalid Input',
                  text: 'Please choose the right time start & end.',
                  confirmBtnColor: primaryColor,
                  confirmBtnTextStyle: const TextStyle(
                      color: white, fontWeight: FontWeight.normal),
                );
              }
            }).catchError((error) {
              print(error);
              QuickAlert.show(
                context: context,
                type: QuickAlertType.error,
                title: 'Invalid Input',
                text: 'Please choose the right time start & end.',
                confirmBtnColor: primaryColor,
                confirmBtnTextStyle: const TextStyle(
                    color: white, fontWeight: FontWeight.normal),
              );
            });
            FocusScope.of(context).unfocus();
          }
        },
        child: const Text(
          'Submit',
          style: TextStyle(color: white),
        ),
      ),
    );
  }

  Widget _buildDate() {
    return Column(
      children: [
        _buildDatePicker(context),
        const SizedBox(height: 6),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Start Time',
                        style: TextStyle(
                            color: primaryColor, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 6,
                      ),
                      GestureDetector(
                        onTap: () {
                          _selectTime(context, true);
                        },
                        child: Container(
                          width: 140,
                          height: 50,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: primaryColor,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 12.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(_startTime.format(context)),
                                const Icon(
                                  Icons.access_time,
                                  color: primaryColor,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            const Icon(Icons.arrow_forward),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'End Time',
                    style: TextStyle(
                        color: primaryColor, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 6,
                  ),
                  GestureDetector(
                    onTap: () {
                      _selectTime(context, false);
                    },
                    child: Container(
                      width: 140,
                      height: 50,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: primaryColor,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(_endTime.format(context)),
                            const Icon(
                              Icons.access_time,
                              color: primaryColor,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        // _buildButtonSave(context, Overtime()),
        const SizedBox(
          height: 10,
        )
      ],
    );
  }
}
