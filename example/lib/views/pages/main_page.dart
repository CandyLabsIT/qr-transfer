import 'package:example/views/pages/scanner_page.dart';
import 'package:example/views/pages/ur_qr_view.dart';
import 'package:example/views/utils/ur_utils.dart';
import 'package:flutter/material.dart';
import 'package:qr_transfer/qr_transfer.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('QR Transfer Example App'),
        centerTitle: true,
      ),
      body: SizedBox.expand(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const Text('Mnemonic', style: TextStyle(fontWeight: FontWeight.bold)),
            Text(URUtils.mnemonic.toString(), textAlign: TextAlign.center),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _signInToMetamask,
              child: const Text('Sign in to Metamask'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _scanQR,
              child: const Text('Scan QR Code'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _signInToMetamask() async {
    _showSignInQRCode(await URUtils.getAccountUREncoder());
  }

  void _showSignInQRCode(UREncoder urEncoder) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          key: const Key('sign_in_dialog'),
          title: const Center(child: Text('Sign in to MetaMask')),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              SizedBox(
                width: 300,
                height: 300,
                child: URQRView(urEncoder: urEncoder),
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _scanQR() async {
    IURRegistryRecord? urRegistryElement = await Navigator.push<IURRegistryRecord?>(
      context,
      MaterialPageRoute<IURRegistryRecord?>(
        builder: (BuildContext context) => const ScannerPage(),
      ),
    );

    switch (urRegistryElement.runtimeType) {
      case URRegistryEthSignRequest:
        await _signETHTransaction(urRegistryElement as URRegistryEthSignRequest);
        break;
      default:
        if (urRegistryElement != null) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Unknown QR type')));
        }
        break;
    }
  }

  Future<void> _signETHTransaction(URRegistryEthSignRequest ethSignRequest) async {
    await _showSignedTransactionQRCode(await URUtils.getSignedTransactionUREncoder(ethSignRequest));
  }

  Future<void> _showSignedTransactionQRCode(UREncoder urEncoder) async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          key: const Key('signed_transaction_dialog'),
          title: const Center(child: Text('Transaction signed')),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              SizedBox(
                width: 300,
                height: 300,
                child: URQRView(urEncoder: urEncoder),
              ),
            ],
          ),
        );
      },
    );
  }
}
