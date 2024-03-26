import 'package:flutter/material.dart';
import 'package:human_resource_management_system/modules/employee_detail/models/relative_model.dart';
import 'package:human_resource_management_system/modules/employee_detail/screens/personal.dart';
import 'package:human_resource_management_system/modules/employee_detail/screens/relative_dropdown.dart';
import 'package:human_resource_management_system/modules/employee_detail/services/emergency_contact_service.dart';
import 'package:human_resource_management_system/modules/scan_to_login/stores/scan_to_login_store.dart';
import 'package:human_resource_management_system/utils/style/colors.dart';
import 'package:human_resource_management_system/utils/widgets/loading.dart';
import 'package:provider/provider.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

class AddEmergencyContact extends StatefulWidget {
  const AddEmergencyContact({super.key});

  @override
  State<AddEmergencyContact> createState() => _AddEmergencyContactState();
}

class _AddEmergencyContactState extends State<AddEmergencyContact> {
  final _formKey = GlobalKey<FormState>(); 
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final phoneController = TextEditingController();
  String? selectedGender;
  RelativeModel? selectedRelativeType;
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          'Edit Emergency',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: primaryColor,
        centerTitle: true,
      ),
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return loading
        ? const LoadingScreen()
        : Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Form(
                key: _formKey, // Assign the form key
                child: Column(
                  children: [
                    const SizedBox(height: 10),
                    _buildTextField('First Name', firstNameController),
                    _buildTextField('Last Name', lastNameController),
                    _buildTextField('Phone Number', phoneController),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Relative Type:',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: primaryColor),
                        ),
                        const SizedBox(
                          height: 8.0,
                        ),
                        RelativeDropDown(
                          onRelativeChanged: (value) {
                            setState(() {
                              selectedRelativeType = value;
                            });
                          },
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    _buildGenderRadioButtons(),
                    const SizedBox(
                      height: 16.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _buildButton(context, 'Save'),
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
  }

  Widget _buildTextField(String hintText, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            hintText.toString(),
            style: const TextStyle(
                fontWeight: FontWeight.bold, color: primaryColor),
          ),
          const SizedBox(
            height: 8.0,
          ),
          TextFormField(
            keyboardType: controller == phoneController
                ? TextInputType.phone
                : TextInputType.text,
            controller: controller,
            decoration: InputDecoration(
              hintText: hintText,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: const BorderSide(
                  color: Colors.grey, // specify border color here
                  width: 0.5,
                ),
              ),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter $hintText';
              }
              return null;
            },
          ),
        ],
      ),
    );
  }

  Widget _buildGenderRadioButtons() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Gender:',
          style: TextStyle(fontWeight: FontWeight.bold, color: primaryColor),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              children: [
                Radio<String>(
                  value: 'Female',
                  groupValue: selectedGender,
                  onChanged: (value) {
                    setState(() {
                      selectedGender = value;
                    });
                  },
                ),
                const Text('Female'),
              ],
            ),
            Row(
              children: [
                Radio<String>(
                  value: 'Male',
                  groupValue: selectedGender,
                  onChanged: (value) {
                    setState(() {
                      selectedGender = value;
                    });
                  },
                ),
                const Text('Male'),
              ],
            ),
            Row(
              children: [
                Radio<String>(
                  value: 'Other',
                  groupValue: selectedGender,
                  onChanged: (value) {
                    setState(() {
                      selectedGender = value;
                    });
                  },
                ),
                const Text('Other'),
              ],
            )
          ],
        ),
      ],
    );
  }

  Widget _buildButton(BuildContext context, String text) {
    return SizedBox(
      height: 50,
      width: 100, // Set to your desired width
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(20.0), // Adjust the value as needed
          ),
        ),
        onPressed: () {
          _saveEmergencyInfo();
        },
        child: Text(
          text,
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  void _saveEmergencyInfo() async {
    if (_formKey.currentState!.validate()) {
      final firstName = firstNameController.text;
      final phone = phoneController.text;
      final lastName = lastNameController.text;

      // Now you can use these values as needed, for example, save them to database or send to API
      print('Name: $firstName');
      print('Phone: $phone');
      print('lastname: $lastName');
      print('Gender: $selectedGender');
      print(
          'relat: ${selectedRelativeType?.relativeName} ${selectedRelativeType?.id}');

      if (selectedGender == null || selectedRelativeType == null) {
        QuickAlert.show(
          context: context,
          type: QuickAlertType.error,
          title: 'Oops...',
          text: 'Please Select Relative Type and Gender !!',
          confirmBtnColor: primaryColor,
        );
      }
      setState(() {
        loading = true;
      });

      EmergencyContactService service = EmergencyContactService();
      await service
          .addEmergencyContactService(
              userId: (Provider.of<ScanToLoginStore>(context, listen: false)
                  .userModel!
                  .user!
                  .id!),
              relativeId: selectedRelativeType!.id!,
              firstName: firstName,
              lastName: lastName,
              gender: selectedGender!,
              phoneNum1: phone)
          .then((value) {
        if (value.statusCode == 200 || value.statusCode == 201) {
          QuickAlert.show(
                  context: context,
                  type: QuickAlertType.success,
                  title: 'Success',
                  text: 'Emergency Contact Add successfully!!',
                  showConfirmBtn: false,
                  autoCloseDuration: const Duration(seconds: 2))
              .then((value) => Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const Personal(),
                    ),
                  ));
        } else {
          setState(() {
            loading = false;
          });
          print('quick alert error');
          QuickAlert.show(
            context: context,
            type: QuickAlertType.error,
            title: 'Oops...',
            text: 'Sorry, something went wrong!!',
          ).then((value) => Navigator.pop(context));
        }
      });
    }
  }

  @override
  void dispose() {
    firstNameController.dispose();
    phoneController.dispose();
    lastNameController.dispose();
    super.dispose();
  }
}
