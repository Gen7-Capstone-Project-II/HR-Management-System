import 'package:flutter/material.dart';
import 'package:human_resource_management_system/modules/employee_detail/stores/employee_detail_store.dart';
import 'package:human_resource_management_system/utils/style/colors.dart';

class MyProfileScreen extends StatefulWidget {
  const MyProfileScreen({super.key, required this.store});
  final EmployeeDetailStore store;

  @override
  State<MyProfileScreen> createState() => _MyProfileScreenState();
}

class _MyProfileScreenState extends State<MyProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.0),
          border: Border.all(
            width: 0.5,
            color: primaryColor,
          ),
        ),
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 8.0),
                  child: Text(
                    'Personal Information',
                    style: TextStyle(
                        color: black.withOpacity(0.8),
                        fontSize: 18,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ),
              buildContentCard(
                  title: 'Name',
                  content:
                      '${widget.store.employeeDetails.data?.firstName} ${widget.store.employeeDetails.data?.lastName}'),
              buildContentCard(
                  title: 'Employee ID',
                  content: '${widget.store.employeeDetails.data?.user?.idEmp}'),
              buildContentCard(
                  title: 'Department',
                  content:
                      '${widget.store.employeeDetails.data?.department?.deptName}'),
              buildContentCard(
                  title: 'Positon',
                  content:
                      '${widget.store.employeeDetails.data!.position?.positionName}'),
              buildContentCard(
                  title: 'Email',
                  content: '${widget.store.employeeDetails.data!.user?.email}'),
              buildContentCard(
                  title: 'Phone Number',
                  content: '${widget.store.employeeDetails.data?.phoneNum1}'),
            ],
          ),
        ),
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
}
