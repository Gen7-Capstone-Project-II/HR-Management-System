import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:human_resource_management_system/utils/style/colors.dart';

class Item {
  Item({
    required this.expandedValue,
    required this.headerValue,
    this.isExpanded = false,
  });

  String expandedValue;
  String headerValue;
  bool isExpanded;
}

List<Item> generateItems(int numberOfItems) {
  return List<Item>.generate(numberOfItems, (int index) {
    return Item(
      headerValue: '31 Augest 2024',
      expandedValue: 'This is item number $index',
    );
  });
}

class ExpansionPanelListExample extends StatefulWidget {
  const ExpansionPanelListExample({Key? key}) : super(key: key);

  @override
  State<ExpansionPanelListExample> createState() =>
      _ExpansionPanelListExampleState();
}

class _ExpansionPanelListExampleState extends State<ExpansionPanelListExample> {
  final List<Item> _data = generateItems(5);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        child: _buildPanel(),
      ),
    );
  }

  Widget _buildPanel() {
    return ExpansionPanelList(
      expansionCallback: (int index, bool isExpanded) {
        setState(() {
          _data[index].isExpanded = isExpanded;
        });
      },
      children: _data.map<ExpansionPanel>((Item item) {
        return ExpansionPanel(
          headerBuilder: (BuildContext context, bool isExpanded) {
            return const ListTile(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Text(
                  //   item.headerValue,
                  //   style: TextStyle(color: primaryColor),
                  // ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FaIcon(
                        FontAwesomeIcons.circleCheck,
                        size: 30,
                        color: primaryColor,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Leap Sakorl'),
                          Text(
                            '31 Augest 2024',
                            style: TextStyle(fontSize: 13),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Text(
                    'Approved',
                    style: TextStyle(color: primaryColor),
                  ), // Additional text
                ],
              ),
            );
          },
          body: const Padding(
            padding: EdgeInsets.only(left: 16, right: 16, bottom: 15),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Name:',
                      style: TextStyle(
                          fontSize: 18,
                          color: primaryColor,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'Leap Sakorl',
                      style: TextStyle(
                          fontSize: 18,
                          color: grey,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Created at:',
                      style: TextStyle(
                          fontSize: 18,
                          color: primaryColor,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      '25 August 2022,   02:16 P.M',
                      style: TextStyle(
                          fontSize: 18,
                          color: grey,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Total day:',
                      style: TextStyle(
                          fontSize: 18,
                          color: primaryColor,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      '1 day',
                      style: TextStyle(
                          fontSize: 18,
                          color: grey,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Your Request:',
                      style: TextStyle(
                          fontSize: 18,
                          color: primaryColor,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      '4 hours',
                      style: TextStyle(
                          fontSize: 18,
                          color: grey,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Status:',
                      style: TextStyle(
                          fontSize: 18,
                          color: primaryColor,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'Approved',
                      style: TextStyle(
                          fontSize: 18,
                          color: primaryColor,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ],
            ),
          ),
          isExpanded: item.isExpanded,
        );
      }).toList(),
    );
  }
}
