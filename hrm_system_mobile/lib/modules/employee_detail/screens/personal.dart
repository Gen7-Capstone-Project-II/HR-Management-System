import 'package:flutter/material.dart';
import 'package:flutter_profile_picture/flutter_profile_picture.dart';
import 'package:human_resource_management_system/modules/employee_detail/screens/emergency_contact.dart';
import 'package:human_resource_management_system/modules/employee_detail/screens/my_profile_screen.dart';
import 'package:human_resource_management_system/modules/employee_detail/stores/emergency_contact_store.dart';
import 'package:human_resource_management_system/modules/employee_detail/stores/employee_detail_store.dart';
import 'package:human_resource_management_system/modules/scan_to_login/stores/scan_to_login_store.dart';
import 'package:human_resource_management_system/utils/style/colors.dart';
import 'package:provider/provider.dart';

class Personal extends StatefulWidget {
  const Personal({super.key});

  @override
  State<Personal> createState() => _PersonalState();
}

class _PersonalState extends State<Personal> with TickerProviderStateMixin {
  late final TabController _tabController;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);

    if (mounted) {
      Future.delayed(Duration.zero, () async {
        await context.read<EmergencyContactStore>().getEmergencyContact(
            Provider.of<ScanToLoginStore>(context, listen: false)
                .userModel!
                .user!
                .id!);
      });
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    EmployeeDetailStore store = context.watch<EmployeeDetailStore>();
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: primaryColor,
        title: const Text(
          'Personal',
          style: TextStyle(color: white),
        ),
        centerTitle: true,
        bottom: TabBar(
          indicatorColor: white,
          controller: _tabController,
          tabs: const <Widget>[
            Tab(
              icon: Icon(
                Icons.person,
                color: white,
              ),
              child: Text(
                'My Profile',
                style: TextStyle(color: white),
              ),
            ),
            Tab(
              icon: Icon(
                Icons.contact_emergency,
                color: white,
              ),
              child: Text(
                'Emergency',
                style: TextStyle(color: white),
              ),
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: <Widget>[
          Column(
            children: [
              MyProfileScreen(
                store: store,
              ),
            ],
          ),
          const EmergencyContact()
        ],
      ),
    );
  }
}

Widget _buildProfile(EmployeeDetailStore store) {
  return Column(
    children: [
      const SizedBox(
        height: 20,
      ),
      ProfilePicture(
        name:
            "${store.employeeDetails.data?.firstName} ${store.employeeDetails.data?.lastName}",
        radius: 50,
        fontsize: 20,
        // img: "$fileBaseUrl${store.employeeDetails.data!.attachment ?? ""}",
      ),
      // CircleAvatar(
      //   backgroundImage: NetworkImage(
      //     "assets/images/profile.jpg",
      //   ),
      //   radius: 50.0,
      // ),
      const SizedBox(
        height: 5,
      ),
      Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            '${store.employeeDetails.data?.firstName} ${store.employeeDetails.data?.lastName}',
            style: const TextStyle(
                fontSize: 15, fontWeight: FontWeight.bold, color: primaryColor),
          ),
          const SizedBox(height: 7),
          Text(
            store.employeeDetails.data?.user?.idEmp ?? "",
            style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: Color(0xff828282)),
          ),
          const SizedBox(height: 7),
          // Text(
          //   'Flutter Developer',
          //   style: TextStyle(
          //       fontSize: 12,
          //       fontWeight: FontWeight.bold,
          //       color: Color(0xff828282)),
          // ),
        ],
      )
    ],
  );
}

Widget _buildRole(context, EmployeeDetailStore store) {
  return Padding(
    padding: const EdgeInsets.only(left: 8, right: 8, top: 8),
    child: Column(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: double.infinity,
              height: 1,
              child: Container(
                color: grey,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Department',
              style: TextStyle(
                color: primaryColor,
                fontSize: 12,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              store.employeeDetails.data?.department?.deptName ?? "",
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(
              height: 10,
            ),
            // SizedBox(
            //   width: double.infinity,
            //   height: 1,
            //   child: Container(
            //     color: grey,
            //   ),
            // ),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: double.infinity,
              height: 1,
              child: Container(
                color: grey,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              'Position',
              style: TextStyle(
                color: primaryColor,
                fontSize: 12,
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              store.employeeDetails.data?.position?.positionName ?? "",
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 10),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: double.infinity,
              height: 1,
              child: Container(
                color: grey,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              'Email',
              style: TextStyle(
                color: primaryColor,
                fontSize: 12,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              store.employeeDetails.data?.user?.email ?? "",
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 10),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: double.infinity,
              height: 1,
              child: Container(
                color: grey,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Phone',
              style: TextStyle(
                color: primaryColor,
                fontSize: 12,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              store.employeeDetails.data?.phoneNum1 ?? "",
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 10),
            SizedBox(
              width: double.infinity,
              height: 1,
              child: Container(
                color: grey,
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        // _buildButtonEdit(context, EditProfileInfo())
      ],
    ),
  );
}
