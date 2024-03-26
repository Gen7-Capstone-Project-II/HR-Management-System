import 'package:flutter/material.dart';
import 'package:human_resource_management_system/utils/style/colors.dart';

class Setting extends StatelessWidget {
  const Setting({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // backgroundColor: white,
        iconTheme: const IconThemeData(color: black),
        centerTitle: true,
        title: const Text(
          'Setting',
          style: TextStyle(color: black),
        ),
      ),
      body: _buildBody(context),
    );
  }

  Widget _buildBody(context) {
    return Column(
      children: [
        _buildGeneral(),
        // _buildSupportive()
        // _buildSupportive(),
      ],
    );
  }

  Widget _buildGeneral() {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.only(right: 20, left: 20),
        child: ListView(
          // shrinkWrap: true,
          children: [
            GestureDetector(
              // onTap: () {
              //   Navigator.push(
              //     context,
              //     MaterialPageRoute(builder: (context) => Overtime()),
              //   );
              // },
              child: const ListTile(
                leading: Icon(Icons.language),
                title: Text("English"),
                trailing: Icon(Icons.arrow_forward_ios),
              ),
            ),
            GestureDetector(
              // onTap: () {
              //   Navigator.push(
              //     context,
              //     MaterialPageRoute(builder: (context) => ListviewExapnadable()),
              //   );
              // },
              child: const ListTile(
                leading: Icon(Icons.key),
                title: Text("Change Password"),
                trailing: Icon(Icons.arrow_forward_ios),
              ),
            ),
            GestureDetector(
              // onTap: () {
              //   Navigator.push(
              //     context,
              //     MaterialPageRoute(builder: (context) => const AboutUs()),
              //   );
              // },
              child: const ListTile(
                leading: Icon(Icons.list_outlined),
                title: Text("About us"),
                trailing: Icon(Icons.arrow_forward_ios),
              ),
            ),
            const SizedBox(height: 20),
            // const Column(
            //   crossAxisAlignment: CrossAxisAlignment.start,
            //   children: [
            //     Text('Help Center', style: TextStyle(fontSize: 16)),
            //     Text('Get help if you are lost!',
            //         style: TextStyle(fontSize: 14)),
            //     SizedBox(height: 15),
            //     Text('Please Rate Our Appstore',
            //         style: TextStyle(fontSize: 16)),
            //     Text('Peopel have rated this version!',
            //         style: TextStyle(fontSize: 14)),
            //   ],
            // ),
          ],
        ),
      ),
    );
  }
}
