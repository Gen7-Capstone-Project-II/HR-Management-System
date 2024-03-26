import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:human_resource_management_system/modules/scan_to_login/models/scan_to_login_model.dart';
import 'package:human_resource_management_system/modules/scan_to_login/screen/success_screen.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class ScanToLoginScreen extends StatefulWidget {
  const ScanToLoginScreen({super.key});

  @override
  State<ScanToLoginScreen> createState() => _ScanToLoginScreenState();
}

class _ScanToLoginScreenState extends State<ScanToLoginScreen> {
  ScanToLoginModel? result;
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    }
    controller!.resumeCamera();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _buildQrView(context),
          Positioned(
            left: 16,
            top: 50,
            child: _buildBackButton(context),
          ),
          Positioned(
            left: 16,
            right: 16,
            bottom: 16,
            child: _buildBottom(),
          )
        ],
      ),
    );
  }

  Widget _buildBackButton(BuildContext context) {
    return IconButton(
      icon: const Icon(
        Icons.arrow_back,
        color: Colors.white,
      ),
      onPressed: () {
        Navigator.pop(context);
      },
    );
  }

  Widget _buildBottom() {
    return Column(
      children: [
        const Text(
          "Scanning QR Code",
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
        const SizedBox(
          height: 50,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              margin: const EdgeInsets.all(8),
              child: InkWell(
                  onTap: () async {
                    await controller?.toggleFlash();
                  },
                  child: FutureBuilder(
                    future: controller?.getFlashStatus(),
                    builder: (context, snapshot) {
                      return Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: const Center(
                            child: Padding(
                              padding: EdgeInsets.all(16.0),
                              child: Icon(Icons.flash_on_rounded, size: 30),
                            ),
                          ));
                    },
                  )),
            ),
            const SizedBox(
              width: 30,
            ),
            Container(
              margin: const EdgeInsets.all(8),
              child: InkWell(
                  onTap: () async {
                    await controller?.flipCamera();
                  },
                  child: FutureBuilder(
                    future: controller?.getCameraInfo(),
                    builder: (context, snapshot) {
                      if (snapshot.data != null) {
                        return Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: const Center(
                              child: Padding(
                                padding: EdgeInsets.all(16.0),
                                child: Icon(Icons.flip_camera_ios_rounded, size: 30),
                              ),
                            ));
                      } else {
                        return const Text('loading');
                      }
                    },
                  )),
            )
          ],
        ),
      ],
    );
  }

  Widget _buildQrView(BuildContext context) {
    var scanArea = (MediaQuery.of(context).size.width < 400 || MediaQuery.of(context).size.height < 400) ? 250.0 : 300.0;
    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(borderColor: Colors.white, borderRadius: 10, borderLength: 30, borderWidth: 5, cutOutSize: scanArea),
      onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((scanData) {
      onQRCodeScanned(context, scanData.code ?? '');
    });
  }

  void onQRCodeScanned(BuildContext context, String qrData) {
    var jsonData = json.decode(qrData);

    if (jsonData != null) {
      controller?.dispose();
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => SuccessScreen(
            token: jsonData['token'],
            userId: jsonData['user_id'],
            context: context,
          ),
        ),
        (route) => false,
      );
    }
  }

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('no Permission')),
      );
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
