import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:human_resource_management_system/core/enums/enums.dart';
import 'package:human_resource_management_system/modules/scan_to_login/stores/scan_to_login_store.dart';
import 'package:human_resource_management_system/my_home.dart';
import 'package:human_resource_management_system/utils/widgets/loading.dart';
import 'package:human_resource_management_system/wrapper_screen.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class SuccessScreen extends StatefulWidget {
  const SuccessScreen(
      {super.key,
      required this.token,
      required this.userId,
      required this.context});
  final BuildContext context;
  final String token;
  final String userId;
  @override
  State<SuccessScreen> createState() => _SuccessScreenState();
}

class _SuccessScreenState extends State<SuccessScreen> {
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    // context.read<ScanToLoginStore>().signIn(
    //       token: widget.token.toString(),
    //       userId: widget.userId.toString(),
    //     );
    if (mounted) {
      Future.delayed(Duration.zero, () async {
        await context.read<ScanToLoginStore>().signIn(
              token: widget.token.toString(),
              userId: widget.userId.toString(),
            );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const WrapperScreen(),
              ),
            );
          },
        ),
      ),
      body: Observer(builder: (context) {
        LoadingStatus status = context.watch<ScanToLoginStore>().loadingStatus;
        switch (status) {
          case LoadingStatus.none:
          case LoadingStatus.loading:
            return const LoadingScreen();
          case LoadingStatus.error:
            return Center(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                LottieBuilder.asset(
                  'assets/animations/unsuccess.json',
                  width: 130,
                ),
                const SizedBox(height: 8.0),
                const Text(
                  'Token is invalid or expired.',
                  style: TextStyle(fontSize: 18, color: Colors.red),
                ),
                const Text(
                  'Please try again.',
                  style: TextStyle(fontSize: 18, color: Colors.red),
                ),
              ],
            ));
          case LoadingStatus.done:
            Future.delayed(Duration.zero, () {
              Navigator.pushAndRemoveUntil(
                widget.context,
                MaterialPageRoute(
                  builder: (context) => const MyHome(),
                ),
                (route) => false,
              );
            });

            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                LottieBuilder.asset(
                  'assets/animations/success.json',
                  width: 130,
                ),
                const SizedBox(height: 8.0),
                const Center(child: Text('You have successfully logged in.')),
              ],
            );
        }
      }),
    );
  }
}
