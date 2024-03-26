// ignore_for_file: use_build_context_synchronously, avoid_print

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:human_resource_management_system/modules/attendance/screens/scan.dart';
import 'package:human_resource_management_system/modules/attendance/services/attendance_service.dart';
import 'package:human_resource_management_system/modules/employee_detail/stores/employee_detail_store.dart';
import 'package:human_resource_management_system/modules/home/home.dart';
import 'package:human_resource_management_system/modules/scan_to_login/stores/scan_to_login_store.dart';
import 'package:human_resource_management_system/modules/account/account.dart';
import 'package:human_resource_management_system/utils/style/colors.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class MyHome extends StatefulWidget {
  const MyHome({super.key});

  @override
  State<MyHome> createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  Position? _currentPosition;
  String? _currentAddress;

  int currentTap = 0;
  final List<Widget> screens = [
    const HomeScreen(),
    const ScanScreen(),
    const AccountScreen(),
  ];

  final PageStorageBucket bucket = PageStorageBucket();

  Future<bool> _handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location services are disabled. Please enable the services')));
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Location permissions are denied')));
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location permissions are permanently denied, we cannot request permissions.')));
      return false;
    }
    return true;
  }

  Future<void> _getCurrentPosition() async {
    final hasPermission = await _handleLocationPermission();
    if (!hasPermission) return;
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) {
      setState(() {
        _currentPosition = position;
        if (_currentPosition != null) {}
        _getAddressFromLatLng(_currentPosition!);
      });
    }).catchError((e) {
      debugPrint(e);
    });
  }

  Future<void> _getAddressFromLatLng(Position position) async {
    await placemarkFromCoordinates(
            _currentPosition?.latitude ?? 0, _currentPosition?.longitude ?? 0)
        .then((List<Placemark> placemarks) {
      setState(() {
        _currentAddress = placemarks[0].name;
        print("current Address : 1 $_currentAddress");
      });
    }).catchError((e) {
      debugPrint(e);
    });
  }

  @override
  void initState() {
    super.initState();
    _getCurrentPosition();
    if (mounted) {
      Future.delayed(Duration.zero, () async {
        await context.read<EmployeeDetailStore>().getEmployeeDetails(
            Provider.of<ScanToLoginStore>(context, listen: false)
                .userModel!
                .user!
                .id!);
      });
    }
  }

  Widget currentScreen = const HomeScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        child: PageStorage(
          bucket: bucket,
          child: currentScreen,
        ),
        onRefresh: () async {
          if (mounted) {
            await context.read<EmployeeDetailStore>().getEmployeeDetails(
                Provider.of<ScanToLoginStore>(context, listen: false)
                    .userModel!
                    .user!
                    .id!);
          }
        },
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  Widget _buildBottomNavigationBar() {
    return BottomAppBar(
      // color: const Color(0xff23AF4F),
      color: const Color(0xffFAFAFA),
      shape: const CircularNotchedRectangle(),
      notchMargin: 10,
      child: SizedBox(
        height: 50,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MaterialButton(
                  minWidth: 40,
                  onPressed: () {
                    setState(() {
                      currentScreen = const HomeScreen();
                      currentTap = 0;
                    });
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      FaIcon(
                        FontAwesomeIcons.house,
                        color: currentTap == 0
                            ? primaryColor
                            : const Color(0xff828282),
                      ),
                      Text(
                        'Home',
                        style: TextStyle(
                          fontSize: 12,
                          color: currentTap == 0
                              ? primaryColor
                              : const Color(0xff828282),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Row(
              children: [
                MaterialButton(
                  minWidth: 40,
                  onPressed: () async {
                    setState(() {
                      currentScreen = const ScanScreen();
                      currentTap = 1;
                    });
                    AttendanceService service = AttendanceService();
                    await service.postAttendanceService(
                      Provider.of<ScanToLoginStore>(context, listen: false)
                          .userModel!
                          .user!
                          .id!,
                      _currentAddress ?? 'Unknown',
                    );
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: currentTap == 1
                              ? primaryColor
                              : Colors.transparent,
                          shape: BoxShape.circle,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: FaIcon(
                            FontAwesomeIcons.camera,
                            size: 25,
                            color: currentTap == 1 ? white : grey,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MaterialButton(
                  minWidth: 40,
                  onPressed: () {
                    setState(() {
                      currentScreen = const AccountScreen();
                      currentTap = 2;
                    });
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      FaIcon(
                        FontAwesomeIcons.ellipsis,
                        color: currentTap == 2
                            ? primaryColor
                            : const Color(0xff828282),
                      ),
                      Text(
                        'More',
                        style: TextStyle(
                          fontSize: 12,
                          color: currentTap == 2
                              ? primaryColor
                              : const Color(0xff828282),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
