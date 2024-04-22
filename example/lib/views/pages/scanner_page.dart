import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:qr_transfer/qr_transfer.dart';

class ScannerPage extends StatefulWidget {
  const ScannerPage({super.key});

  @override
  _ScannerPageState createState() => _ScannerPageState();
}

class _ScannerPageState extends State<ScannerPage> {
  final URDecoder urDecoder = URDecoder();
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController? qrViewController;
  double progress = 0;

  @override
  void dispose() {
    qrViewController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double scanArea = MediaQuery.of(context).size.width - 120;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Expanded(
              child: QRView(
                key: qrKey,
                onQRViewCreated: _handleQrViewCreated,
                overlay: QrScannerOverlayShape(borderColor: Colors.red, borderRadius: 10, borderLength: 30, borderWidth: 10, cutOutSize: scanArea),
              ),
            ),
            LinearProgressIndicator(
              value: progress,
            ),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              child: ElevatedButton(
                onPressed: () => Navigator.of(context, rootNavigator: true).pop(),
                child: const Text('Back'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _handleQrViewCreated(QRViewController qrViewController) {
    this.qrViewController = qrViewController;

    qrViewController.scannedDataStream.listen((Barcode scanData) async {
      String? qrContent = scanData.code;
      if (qrContent == null) {
        return;
      }
      urDecoder.receivePart(qrContent);
      setState(() {
        progress = urDecoder.estimatedPercentComplete;
      });
      if (urDecoder.isComplete) {
        UR ur = urDecoder.resultUR()!;
        IURRegistryRecord value = URRegistryDecoder.decode(ur);
        await qrViewController.pauseCamera();
        Navigator.of(context, rootNavigator: true).pop(value);
      }
    });
  }
}
