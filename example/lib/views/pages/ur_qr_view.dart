import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:qr_transfer/qr_transfer.dart';

class URQRView extends StatefulWidget {
  final UREncoder urEncoder;

  const URQRView({
    required this.urEncoder,
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _URQRViewState();
}

class _URQRViewState extends State<URQRView> {
  String? qrCodeContent;
  Timer? timer;

  @override
  void initState() {
    super.initState();
    qrCodeContent = widget.urEncoder.nextPart();
    if (widget.urEncoder.fragmentsCount != 1) {
      _updateQRCode();
      timer = Timer.periodic(const Duration(milliseconds: 300), (Timer timer) => _updateQRCode());
    }
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return QrImageView(
      data: qrCodeContent ?? '',
      version: QrVersions.auto,
      gapless: false,
    );
  }

  void _updateQRCode() {
    if (widget.urEncoder.isComplete) {
      widget.urEncoder.reset();
    }
    setState(() {
      qrCodeContent = widget.urEncoder.nextPart();
    });
  }
}
