import 'package:flutter/material.dart';
import 'package:human_resource_management_system/utils/style/colors.dart';

class EditProfileInfo extends StatefulWidget {
  const EditProfileInfo({Key? key}) : super(key: key);

  @override
  State<EditProfileInfo> createState() => _EditProfileInfoState();
}

enum SingingCharacter { mr, ms }

SingingCharacter? _character = SingingCharacter.mr;

class _EditProfileInfoState extends State<EditProfileInfo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          'Edit My Profile',
          style: TextStyle(color: white),
        ),
        centerTitle: true,
        backgroundColor: primaryColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: [
                  Row(
                    children: <Widget>[
                      Radio<SingingCharacter>(
                        value: SingingCharacter.mr,
                        groupValue: _character,
                        onChanged: (SingingCharacter? value) {
                          setState(() {
                            _character = value;
                          });
                        },
                      ),
                      const Text('Mr.'),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Radio<SingingCharacter>(
                        value: SingingCharacter.ms,
                        groupValue: _character,
                        onChanged: (SingingCharacter? value) {
                          setState(() {
                            _character = value;
                          });
                        },
                      ),
                      const Text('Ms.'),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 10), // Add some spacing
              _buildTextField('First Name'),
              _buildTextField('Last Name'),
              _buildTextField('Employee ID'),
              _buildTextField('Organization'),
              _buildTextField('Position'),
              _buildTextField('Email'),
              _buildTextField('Phone'),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildButton(context, 'Save'),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget _buildTextField(hintText) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 10),
    child: TextField(
      decoration: InputDecoration(
        hintText: hintText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: const BorderSide(
            color: Colors.grey, // specify border color here
            width: 1.0,
          ),
        ),
      ),
    ),
  );
}

Widget _buildButton(context, text) {
  return Row(
    children: [
      SizedBox(
        // padding: const EdgeInsets.only(left: 30, right: 30),
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
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const EditProfileInfo(),
              ),
            );
          },
          child: Text(
            text,
            style: TextStyle(color: white),
          ),
        ),
      )
    ],
  );
}
