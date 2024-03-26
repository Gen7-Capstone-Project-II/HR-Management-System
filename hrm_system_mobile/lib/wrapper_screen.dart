// ignore_for_file: avoid_print

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:human_resource_management_system/modules/login/sign_in.dart';
import 'package:human_resource_management_system/modules/scan_to_login/stores/scan_to_login_store.dart';
import 'package:human_resource_management_system/my_home.dart';
import 'package:provider/provider.dart';

import 'core/stores/connectivity_store/connectivity_store.dart';

class WrapperScreen extends StatefulWidget {
  const WrapperScreen({super.key});

  @override
  State<WrapperScreen> createState() => _WrapperScreenState();
}

class _WrapperScreenState extends State<WrapperScreen> {
  late ConnectivityStore _connStore;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ScanToLoginStore scanToLoginStore = context.watch<ScanToLoginStore>();
    _connStore = context.watch<ConnectivityStore>();
    scanToLoginStore.readCache;
    print(scanToLoginStore.readCache());
    print(scanToLoginStore.userModel?.token);
    return Observer(builder: (_) {
      debugPrint("--> START: Tracking Connectivity");
      debugPrint(
          "--> Connectivity Result :${_connStore.connectivityResult.value}");
      debugPrint("<-- END");
      if (_connStore.connectivityResult.value == null ||
          _connStore.connectivityResult.value == ConnectivityResult.none) {
        return const Scaffold(
          body: Center(
            child: Text("No Internet Connection"),
          ),
        );
      } else {
        print('wraperscreen');
        print(scanToLoginStore.userModel?.token);
        if (scanToLoginStore.userModel?.token == null) {
          return const SignInScreen();
        } else {
          return const MyHome();
        }
      }
    });
  }
}
