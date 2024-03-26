import 'package:flutter/material.dart';
import 'package:human_resource_management_system/modules/leave_request/models/leave_type_model.dart';
import 'package:human_resource_management_system/modules/leave_request/screens/leave.dart';
import 'package:human_resource_management_system/modules/leave_request/services/leave_request_service.dart';
import 'package:human_resource_management_system/modules/scan_to_login/stores/scan_to_login_store.dart';
import 'package:human_resource_management_system/utils/style/colors.dart';
import 'package:human_resource_management_system/utils/widgets/loading.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'dropdown.dart';

class LeaveRequest extends StatefulWidget {
  const LeaveRequest({super.key});

  @override
  State<LeaveRequest> createState() => _LeaveRequestState();
}

class _LeaveRequestState extends State<LeaveRequest> {
  final TextEditingController _reasonController = TextEditingController();

  String getFormattedDate(DateTime date) {
    return DateFormat('dd-MMM-yyyy').format(date);
  }

  late DateTime _selectedStartDate;
  late DateTime _selectedEndDate;

  late TextEditingController _startDateController;
  late TextEditingController _endDateController;

  LeaveTypeModel? _selectedLeaveType;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _selectedStartDate = DateTime.now();
    _selectedEndDate = DateTime.now().add(const Duration(days: 1));

    _startDateController =
        TextEditingController(text: getFormattedDate(_selectedStartDate));
    _endDateController =
        TextEditingController(text: getFormattedDate(_selectedEndDate));
  }

  Future<void> selectStartDate(context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedStartDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null && pickedDate != _selectedStartDate) {
      setState(() {
        _selectedStartDate = pickedDate;
        _startDateController.text = getFormattedDate(pickedDate);
        _selectedEndDate = pickedDate.add(const Duration(days: 1));
        _endDateController.text = getFormattedDate(_selectedEndDate);
      });
    }
  }

  Future<void> selectEndDate(context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedEndDate,
      firstDate: _selectedStartDate,
      lastDate: DateTime(2100),
    );

    if (pickedDate != null && pickedDate != _selectedEndDate) {
      setState(() {
        _selectedEndDate = pickedDate;
        _endDateController.text = getFormattedDate(pickedDate);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.white),
          title: const Text(
            'Leave Request',
            style: TextStyle(color: white),
          ),
          backgroundColor: primaryColor,
          centerTitle: true,
        ),
        body: _buildBody());
  }

  Widget _buildBody() {
    return _isLoading
        ? const Center(child: LoadingScreen())
        : SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 8, left: 8, right: 8),
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        height: 90,
                        width: double.infinity,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Leave Type',
                                  style: TextStyle(
                                      color: primaryColor,
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(height: 10),
                                DropdownMenuExample(
                                  onLeaveTypeChanged: (value) {
                                    setState(() {
                                      _selectedLeaveType = value;
                                      print(_selectedLeaveType);
                                      print(value);
                                    });
                                  },
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8, left: 8, right: 8),
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        width: double.infinity,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _buildDate(),
                                const SizedBox(height: 10),
                                _buildTextField('write you note here'),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 8.0),
                _buildSubmitButton(),
              ],
            ),
          );
  }

  Widget _buildStartDate(context) {
    return SizedBox(
      height: 70,
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.only(top: 10, bottom: 10),
        child: GestureDetector(
          onTap: () {
            selectStartDate(context);
          },
          child: AbsorbPointer(
            child: TextField(
              controller: _startDateController,
              decoration: const InputDecoration(
                hintText: 'Start Date',
                fillColor: lowGrey,
                prefixIcon: Icon(Icons.calendar_today),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildEndDate(context) {
    return SizedBox(
      height: 70,
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.only(top: 10, bottom: 10),
        child: GestureDetector(
          onTap: () {
            selectEndDate(context);
          },
          child: AbsorbPointer(
            child: TextField(
              controller: _endDateController,
              decoration: const InputDecoration(
                hintText: 'End Date',
                fillColor: lowGrey,
                prefixIcon: Icon(Icons.calendar_today),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDate() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Start Date',
          style: TextStyle(color: primaryColor, fontWeight: FontWeight.bold),
        ),
        _buildStartDate(context),
        const SizedBox(height: 10),
        const Text(
          'End Date',
          style: TextStyle(color: primaryColor, fontWeight: FontWeight.bold),
        ),
        // const SizedBox(height: 6),
        _buildEndDate(context),
      ],
    );
  }

  Widget _buildTextField(hintText) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Reason',
            style: TextStyle(color: primaryColor, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          TextField(
            controller: _reasonController,
            maxLines: null,
            decoration: InputDecoration(
              hintText: hintText,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: const BorderSide(
                  color: primaryColor, // specify border color here
                  width: 1.0,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSubmitButton() {
    return Center(
      child: SizedBox(
        height: 50,
        width: 100, // Set to your desired width
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: primaryColor,
            shape: RoundedRectangleBorder(
              borderRadius:
                  BorderRadius.circular(20.0), // Adjust the value as needed
            ),
          ),
          onPressed: () async {
            if (_selectedLeaveType == null ||
                _reasonController.text.trim().isEmpty) {
              QuickAlert.show(
                context: context,
                type: QuickAlertType.error,
                title: 'Oops...',
                text: 'Please select leave type or Input your reason',
              );
              return;
            } else {
              setState(() {
                _isLoading = true;
              });
            }

            FocusScope.of(context).unfocus();
            LeaveRequestService service = LeaveRequestService();
            await service
                .addLeaveRequestService(
                    userId:
                        (Provider.of<ScanToLoginStore>(context, listen: false)
                            .userModel!
                            .user!
                            .id!),
                    leaveType: _selectedLeaveType!.id!,
                    startDate:
                        '${_selectedStartDate.year}-${_selectedStartDate.month}-${_selectedStartDate.day}',
                    endDate:
                        '${_selectedEndDate.year}-${_selectedEndDate.month}-${_selectedEndDate.day}',
                    reason: _reasonController.text.trim(),
                    attachment: null,
                    token: Provider.of<ScanToLoginStore>(context, listen: false)
                        .userModel!
                        .token!)
                .then((value) {
              print('leave request screen : ${value.statusCode}');
              setState(() {
                _isLoading = false;
              });
              if (value.statusCode == 200 || value.statusCode == 201) {
                QuickAlert.show(
                        context: context,
                        type: QuickAlertType.success,
                        title: 'Success',
                        text: 'Leave Request updated successfully!!',
                        showConfirmBtn: false,
                        autoCloseDuration: const Duration(seconds: 2))
                    .then((value) => Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const Leave(),
                          ),
                        ));
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const Leave(),
                  ),
                );
              } else if (value.statusCode == 409) {
                print('quick alert error');
                QuickAlert.show(
                        context: context,
                        type: QuickAlertType.error,
                        title: 'Oops...',
                        text:
                            'Incorrect data provided. Please check your input.',
                        showConfirmBtn: false,
                        autoCloseDuration: const Duration(seconds: 2))
                    .then((value) => Navigator.pop(context));
              } else {
                print('quick alert error');
                QuickAlert.show(
                  context: context,
                  type: QuickAlertType.error,
                  title: 'Oops...',
                  text: 'Sorry, something went wrong',
                  showConfirmBtn: false,
                ).then((value) => Navigator.pop(context));
              }
            }).catchError((error) {
              setState(() {
                _isLoading = false;
              });
              print('Error: $error');
              QuickAlert.show(
                context: context,
                type: QuickAlertType.error,
                title: 'Invalid Input',
                text: 'Please choose the right Date.',
                confirmBtnColor: primaryColor,
                confirmBtnTextStyle: const TextStyle(
                    color: white, fontWeight: FontWeight.normal),
              );
            });
          },
          child: const Text(
            'Submit',
            style: TextStyle(color: white),
          ),
        ),
      ),
    );
  }
}
