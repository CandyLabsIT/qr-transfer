import 'dart:typed_data';

import 'package:cryptography_utils/cryptography_utils.dart';
import 'package:qr_transfer/qr_transfer.dart';

class URUtils {
  static Mnemonic mnemonic = Mnemonic.fromMnemonicPhrase(
      'require point property company tongue busy bench burden caution gadget knee glance thought bulk assist month cereal report quarter tool section often require shield');

  static Future<UREncoder> getAccountUREncoder() async {
    LegacyHDWallet legacyHDWallet = await LegacyHDWallet.fromMnemonic(
      derivationPath: LegacyDerivationPath.parse("m/44'/60'/0'/0/0"),
      mnemonic: mnemonic,
      walletConfig: Bip44WalletsConfig.ethereum,
    );

    Secp256k1PublicKey publicKey = legacyHDWallet.publicKey as Secp256k1PublicKey;

    URRegistryCryptoHDKey cryptoHDKey = URRegistryCryptoHDKey(
      isMaster: false,
      isPrivate: false,
      keyData: publicKey.compressed,
      parentFingerprint: publicKey.metadata.fingerprint.toInt(),
      chainCode: legacyHDWallet.privateKey.metadata.chainCode,
      origin: URRegistryCryptoKeypath(
        components: legacyHDWallet.derivationPath.pathElements.map((LegacyDerivationPathElement e) {
          return PathComponent(index: e.rawIndex, hardened: e.isHardened);
        }).toList(),
        sourceFingerprint: publicKey.metadata.fingerprint.toInt(),
      ),
      children: const URRegistryCryptoKeypath(
        components: <PathComponent>[
          PathComponent(index: 0, hardened: false),
        ],
      ),
      name: 'SNGGLE',
    );

    return UREncoder(
      ur: UR.fromRegistryElement(cryptoHDKey),
      maxFragmentLength: 50,
    );
  }

  static Future<UREncoder> getSignedTransactionUREncoder(URRegistryEthSignRequest ethSignRequest) async {
    List<LegacyDerivationPathElement> derivationPathElements = ethSignRequest.derivationPath.components.map((PathComponent pathComponent) {
      return LegacyDerivationPathElement.parse('${pathComponent.index}${pathComponent.hardened ? "'" : ''}');
    }).toList();

    LegacyHDWallet legacyHDWallet = await LegacyHDWallet.fromMnemonic(
      derivationPath: LegacyDerivationPath(pathElements: derivationPathElements),
      mnemonic: mnemonic,
      walletConfig: Bip44WalletsConfig.ethereum,
    );

    Secp256k1PrivateKey privateKey = legacyHDWallet.privateKey as Secp256k1PrivateKey;

    Uint8List signData = ethSignRequest.signData;
    EthereumSigner ecdsaSigner = EthereumSigner(privateKey.ecPrivateKey);

    Uint8List signatureBytes;
    if (ethSignRequest.dataType == EthSignDataType.rawBytes) {
      signatureBytes = ecdsaSigner.signPersonalMessage(signData).toBytes(eip155Bool: true);
    } else {
      signatureBytes = ecdsaSigner.sign(signData).toBytes(eip155Bool: false);
    }

    URRegistryEthSignature ethSignature = URRegistryEthSignature(
      requestId: ethSignRequest.requestId ?? Uint8List(0),
      signature: signatureBytes,
      origin: ethSignRequest.origin,
    );
    return UREncoder(
      ur: UR.fromRegistryElement(ethSignature),
      maxFragmentLength: 50,
    );
  }
}
