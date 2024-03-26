// ignore_for_file: use_build_context_synchronously

import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:human_resource_management_system/modules/attendance/services/attendance_service.dart';
import 'package:human_resource_management_system/modules/scan_to_login/stores/scan_to_login_store.dart';
import 'package:human_resource_management_system/my_home.dart';
import 'package:human_resource_management_system/utils/style/colors.dart';
import 'package:human_resource_management_system/utils/widgets/loading.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

class CheckIn extends StatefulWidget {
  const CheckIn({super.key, this.attendanceId, this.lat, this.long});

  final String? attendanceId;
  final double? lat;
  final double? long;

  @override
  State<CheckIn> createState() => _CheckInState();
}

class _CheckInState extends State<CheckIn> {
  Position? _currentPosition;
  double? distance;
  bool _checkInPerformed = false;
  String? _currentAddress;

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
        if (_currentPosition != null) {
          var dist = calculateDistance(_currentPosition!.latitude,
              _currentPosition!.longitude, widget.lat!, widget.long!);
          distance = dist;
          print('late: ${position.latitude}');
          print('long: ${position.longitude}');
          print("distance $distance");
          _getAddressFromLatLng(_currentPosition!);
          // print('current lat: ${_currentPosition!.latitude}');
          // print('current long: ${_currentPosition!.longitude}');

          // print("dist $dist");
          // print('distance $distance');
        }
      });
    }).catchError((e) {
      debugPrint(e);
    });
  }

  @override
  void initState() {
    super.initState();
    _getCurrentPosition();
  }

  Future<void> _getAddressFromLatLng(Position position) async {
    await placemarkFromCoordinates(
            _currentPosition?.latitude ?? 0, _currentPosition?.longitude ?? 0)
        .then((List<Placemark> placemarks) {
      setState(() {
        _currentAddress = placemarks[0].name;
      });
    }).catchError((e) {
      debugPrint(e);
    });
  }

  double calculateDistance(lat1, lon1, lat2, lon2) {
    var p = 0.017453292519943295;
    var c = cos;
    var a = 0.5 -
        c((lat2 - lat1) * p) / 2 +
        c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;
    return 12742 * asin(sqrt(a)) * 1000;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Check In'),
        leading: IconButton(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return const MyHome();
            }));
          },
          icon: const Icon(Icons.arrow_back, color: black),
        ),
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    if (widget.lat == null || widget.long == null) {
      return Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
            LottieBuilder.asset(
              'assets/animations/unsuccess.json',
              width: 90,
            ),
            const SizedBox(height: 16.0),
            const Text(
              'You Scan The Wrong QR Code!!!',
              style: TextStyle(fontSize: 16),
            )
          ]));
    } else {
      if (_currentPosition == null) {
        return const LoadingScreen();
      } else {
        return _buildContent();
      }
    }
  }

  Widget _buildContent() {
    if (distance != null) {
      if (distance! < 100) {
        print('distance: $distance');
        _performCheckIn();
        return const LoadingScreen();
      } else {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              LottieBuilder.asset(
                'assets/animations/unsuccess.json',
                width: 90,
              ),
              const SizedBox(height: 16.0),
              const Text(
                'You are not in the office area',
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
        );
      }
    } else {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            LottieBuilder.asset(
              'assets/animations/unsuccess.json',
              width: 90,
            ),
            const SizedBox(height: 16.0),
            const Text(
              'You are not in the office area',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      );
    }
  }

  void _performCheckIn() async {
    print(_checkInPerformed);
    if (_checkInPerformed) {
      return; // Do nothing if already performed
    }
    AttendanceService service = AttendanceService();
    if (_currentAddress != null) {
      Response response = await service.updateTimeIn(
        token: Provider.of<ScanToLoginStore>(context, listen: false)
            .userModel!
            .user!
            .id!,
        attendanceId: widget.attendanceId!,
        timeIn: '${DateTime.now().hour}:${DateTime.now().minute}',
        locationTimeIn: _currentAddress ?? 'Unknown',
      );
      print('response: ${response.statusCode}');
      if (response.statusCode == 200 || response.statusCode == 201) {
        setState(() {
          _checkInPerformed = true;
        });

        QuickAlert.show(
          context: context,
          type: QuickAlertType.success,
          title: 'Success',
          text: 'Check In Success',
          showConfirmBtn: false,
        );

        await Future.delayed(const Duration(seconds: 2));

        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) {
            return const MyHome();
          }),
        );
      } else {
        QuickAlert.show(
            context: context,
            type: QuickAlertType.error,
            title: 'Error',
            text: 'Check In Failed',
            confirmBtnColor: primaryColor);
      }
    }
  }
}
