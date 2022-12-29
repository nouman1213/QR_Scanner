import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:qr_scanner/result_screen.dart';

class QRScanner extends StatefulWidget {
  QRScanner({super.key});

  @override
  State<QRScanner> createState() => _QRScannerState();
}

class _QRScannerState extends State<QRScanner> {
  MobileScannerController mobileScannerController = MobileScannerController();
  bool isScanCompleted = false;

  bool isFlashOn = false;

  bool isFrontCamera = false;

  void closeScreen() {
    isScanCompleted = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.menu_sharp),
        actions: [
          IconButton(
              onPressed: () {
                setState(() {
                  isFlashOn = !isFlashOn;
                });
                mobileScannerController.toggleTorch();
              },
              icon: Icon(
                Icons.flash_on_rounded,
                color: isFlashOn ? Colors.teal : Colors.black54,
              )),
          IconButton(
              onPressed: () {
                setState(() {
                  isFrontCamera = !isFrontCamera;
                });
                mobileScannerController.switchCamera();
              },
              icon: Icon(Icons.camera_front,
                  color: isFrontCamera ? Colors.teal : Colors.black54)),
        ],
        title: Text(
          'QR Scanner',
          style: Theme.of(context).textTheme.headline1,
        ),
      ),
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Place the QR Code in the Area',
                    style: Theme.of(context).textTheme.headline1,
                  ),
                  const SizedBox(
                    height: 3,
                  ),
                  Text(
                    'Scanning will be start automatically',
                    style: Theme.of(context).textTheme.headline2,
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 4,
              child: Stack(
                children: [
                  MobileScanner(
                    controller: mobileScannerController,
                    allowDuplicates: true,
                    onDetect: (barcode, args) {
                      if (!isScanCompleted) {
                        String code =
                            barcode.rawValue ?? "Failed to scan Barcode";
                        isScanCompleted = true;
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => ResultScreen(
                                      closeScreen: closeScreen,
                                      code: code,
                                    )));
                      }
                    },
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                alignment: Alignment.bottomCenter,
                child: Text(
                  'Developed by Nouman Ashraf',
                  style: Theme.of(context).textTheme.headline2,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
