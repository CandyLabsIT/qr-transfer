import 'package:cbor/cbor.dart';
import 'package:qr_transfer/qr_transfer.dart';

class URRegistryDecoder {
  static IURRegistryRecord decode(UR ur) {
    URRegistryType registryType = URRegistryType.fromType(ur.type);

    CborValue cborValue = ur.decodeCborPayload();

    switch (registryType) {
      case URRegistryType.cryptoCoinInfo:
        return URRegistryCryptoCoinInfo.fromCborValue(cborValue);
      case URRegistryType.cryptoHDKey:
        return URRegistryCryptoHDKey.fromCborValue(cborValue);
      case URRegistryType.cryptoKeypath:
        return URRegistryCryptoKeypath.fromCborValue(cborValue);
      case URRegistryType.ethSignature:
        return URRegistryEthSignature.fromCborValue(ur.decodeCborPayload());
      case URRegistryType.ethSignRequest:
        return URRegistryEthSignRequest.fromCborValue(cborValue);
      default:
        throw UnimplementedError('Unimplemented UR registry record type: ${ur.type}');
    }
  }
}
