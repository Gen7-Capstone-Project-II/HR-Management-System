import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:human_resource_management_system/core/enums/enums.dart';
import 'package:human_resource_management_system/modules/employee_detail/models/emergency_contact_model.dart';
import 'package:human_resource_management_system/modules/employee_detail/screens/add_emergency_info.dart';
import 'package:human_resource_management_system/modules/employee_detail/screens/edit_emergency_info.dart';
import 'package:human_resource_management_system/modules/employee_detail/services/emergency_contact_service.dart';
import 'package:human_resource_management_system/modules/employee_detail/stores/emergency_contact_store.dart';
import 'package:human_resource_management_system/modules/scan_to_login/stores/scan_to_login_store.dart';
import 'package:human_resource_management_system/utils/style/colors.dart';
import 'package:human_resource_management_system/utils/widgets/loading.dart';
import 'package:human_resource_management_system/utils/widgets/no_data.dart';
import 'package:provider/provider.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

class EmergencyContact extends StatefulWidget {
  const EmergencyContact({super.key});

  @override
  State<EmergencyContact> createState() => _EmergencyContactState();
}

class _EmergencyContactState extends State<EmergencyContact> {
  @override
  void initState() {
    super.initState();
    if (mounted) {
      _fetchEmergencyContactData();
    }
  }

  Future<void> _fetchEmergencyContactData() async {
    final scanToLoginStore =
        Provider.of<ScanToLoginStore>(context, listen: false);
    final userId = scanToLoginStore.userModel!.user!.id!;
    await context.read<EmergencyContactStore>().getEmergencyContact(userId);
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: _fetchEmergencyContactData,
      child: Stack(
        children: [
          Observer(
            builder: (context) {
              LoadingStatus status =
                  Provider.of<EmergencyContactStore>(context).state;
              EmergencyContactStore emergencyContactStore =
                  Provider.of<EmergencyContactStore>(context);
              switch (status) {
                case LoadingStatus.none:
                case LoadingStatus.loading:
                  return const LoadingScreen();
                case LoadingStatus.error:
                  return const NoDataScreen();
                case LoadingStatus.done:
                  if (emergencyContactStore.emergencyContacts.data?.isEmpty ??
                      true) {
                    return const NoDataScreen();
                  } else {
                    return SingleChildScrollView(
                      padding: const EdgeInsets.only(bottom: 100),
                      child: Column(
                          children: List.generate(
                              emergencyContactStore
                                  .emergencyContacts.data!.length, (index) {
                        return Padding(
                          padding: const EdgeInsets.only(
                              right: 10, left: 10, top: 10),
                          child: _buildCards(
                              emergencyContactStore
                                  .emergencyContacts.data![index],
                              context,
                              index),
                        );
                      })),
                    );
                  }
              }
            },
          ),
          Positioned(
            bottom: 16,
            right: 16,
            child: buildAddButton(context),
          )
        ],
      ),
    );
  }

  Widget buildAddButton(BuildContext context) {
    return FloatingActionButton(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(100),
      ),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const AddEmergencyContact(),
          ),
        );
      },
      backgroundColor: primaryColor,
      child: const Icon(
        Icons.add,
        color: white,
      ),
    );
  }

  Widget _buildCards(EmergencyContactModel emergenceyContact,
      BuildContext context, int index) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.0),
        border: Border.all(
          width: 0.5,
          color: primaryColor,
        ),
      ),
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            width: double.infinity,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Emergency Contact #${index + 1}',
                    style: TextStyle(
                        color: black.withOpacity(0.8),
                        fontSize: 18,
                        fontWeight: FontWeight.w500),
                  ),
                  PopupMenuButton<String>(
                    onSelected: (String value) {
                      if (value == 'edit') {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EditEmergencyInfo(
                              emergencyContact: emergenceyContact,
                            ),
                          ),
                        );
                      } else if (value == 'delete') {
                        _showDeleteConfirmation(context, emergenceyContact);
                      }
                    },
                    itemBuilder: (BuildContext context) =>
                        <PopupMenuEntry<String>>[
                      const PopupMenuItem<String>(
                        value: 'edit',
                        child: Row(
                          children: [
                            Icon(Icons.edit),
                            SizedBox(width: 8),
                            Text('Edit'),
                          ],
                        ),
                      ),
                      const PopupMenuItem<String>(
                        value: 'delete',
                        child: Row(
                          children: [
                            Icon(
                              Icons.delete,
                              color: Colors.red,
                            ),
                            SizedBox(width: 8),
                            Text(
                              'Delete',
                              style: TextStyle(color: Colors.red),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Column(
            children: [
              buildContentCard(
                  title: 'Name',
                  content:
                      '${emergenceyContact.firstname} ${emergenceyContact.lastname}'),
              buildContentCard(
                  title: 'Relative Type',
                  content: '${emergenceyContact.relative?.relativeName}'),
              buildContentCard(
                  title: 'Gender', content: '${emergenceyContact.gender}'),
              buildContentCard(
                  title: 'Phone Number',
                  content: '${emergenceyContact.phoneNum1}'),
              const SizedBox(height: 8.0),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildContentCard({required String title, required String content}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '$title:',
            style: TextStyle(
                fontWeight: FontWeight.w500, color: black.withOpacity(0.7)),
          ),
          Text(
            content,
            style: TextStyle(
              color: black.withOpacity(0.9),
              fontSize: 14,
            ),
          )
        ],
      ),
    );
  }

  void _showDeleteConfirmation(
      BuildContext context, EmergencyContactModel emergencyContact) {
    QuickAlert.show(
      context: context,
      type: QuickAlertType.confirm,
      title: 'Are you sure?',
      text: 'Do you want to delete this emergency contact?',
      confirmBtnColor: primaryColor,
      onConfirmBtnTap: () async {
        EmergencyContactService service = EmergencyContactService();
        await service
            .deleteEmergencyContactService(emergencyContact.id!)
            .then((value) {
          context
              .read<EmergencyContactStore>()
              .getEmergencyContact(
                Provider.of<ScanToLoginStore>(context, listen: false)
                    .userModel!
                    .user!
                    .id!,
              )
              .then((value) {
            Navigator.pop(context); // Dismiss the confirmation dialog
          });
        });
      },
    );
  }
}
