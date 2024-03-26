import 'package:flutter/material.dart';
import 'package:flutter_profile_picture/flutter_profile_picture.dart';
import 'package:human_resource_management_system/modules/employee_detail/stores/employee_detail_store.dart';
import 'package:human_resource_management_system/modules/more/about_us/about_us.dart';
import 'package:human_resource_management_system/modules/account/components/button_log_out.dart';
import 'package:human_resource_management_system/modules/mission/screen/mission.dart';
import 'package:human_resource_management_system/modules/overtime/screen/overtime.dart';
import 'package:human_resource_management_system/utils/style/colors.dart';
import 'package:provider/provider.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  @override
  Widget build(BuildContext context) {
    EmployeeDetailStore store = context.watch<EmployeeDetailStore>();
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('this is account screen'),
      // ),
      body: _buildBody(context, store),
    );
  }

  Widget _buildBody(BuildContext context, EmployeeDetailStore store) {
    return Column(
      children: <Widget>[
        Container(
          decoration: const BoxDecoration(
              color: primaryColor, // Replace with your primary color
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(45),
                bottomLeft: Radius.circular(45),
              )),
          child: SizedBox(
            width: double.infinity,
            height: 200.0,
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  ProfilePicture(
                    name:
                        "${store.employeeDetails.data?.firstName} ${store.employeeDetails.data?.lastName}",
                    radius: 50,
                    fontsize: 20,
                    // img: "$fileBaseUrl${store.employeeDetails.data?.attachment ?? ""}",
                  ),
                  const SizedBox(height: 5.0),
                  Text(
                    '${store.employeeDetails.data?.firstName} ${store.employeeDetails.data?.lastName}',
                    style: const TextStyle(
                      fontSize: 22.0,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 5.0),
                ],
              ),
            ),
          ),
        ),
        // const SizedBox(height: 5.0),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(right: 20, left: 20),
            child: ListView(
              // shrinkWrap: true,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Overtime()),
                    );
                  },
                  child: const ListTile(
                    leading: Icon(Icons.watch_later),
                    title: Text("Overtime"),
                    trailing: Icon(Icons.arrow_forward_ios),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const Mission()),
                    );
                  },
                  child: const ListTile(
                    leading: Icon(Icons.business_center_outlined),
                    title: Text("Mission"),
                    trailing: Icon(Icons.arrow_forward_ios),
                  ),
                ),

                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const AboutUs()),
                    );
                  },
                  child: const ListTile(
                    leading: Icon(Icons.people_alt_sharp),
                    title: Text("About us"),
                    trailing: Icon(Icons.arrow_forward_ios),
                  ),
                ),
                // GestureDetector(
                //   onTap: () {
                //     Navigator.push(
                //       context,
                //       MaterialPageRoute(builder: (context) => const Contact()),
                //     );
                //   },
                //   child: const ListTile(
                //     leading: Icon(Icons.phone),
                //     title: Text("Contact"),
                //     trailing: Icon(Icons.arrow_forward_ios),
                //   ),
                // ),
                const SizedBox(height: 20),
                const ButtonLogOut()
              ],
            ),
          ),
        ),
      ],
    );
  }
}
