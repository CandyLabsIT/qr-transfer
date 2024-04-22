import 'dart:typed_data';

import 'package:cbor/cbor.dart';
import 'package:equatable/equatable.dart';
import 'package:qr_transfer/qr_transfer.dart';

/// Metadata for the signature response for Ethereum.
/// https://github.com/ethereum/ercs/blob/master/ERCS/erc-4527.md#cddl-for-eth-signature
class URRegistryEthSignature extends Equatable implements IURRegistryRecord {
  static URRegistryType registryType = URRegistryType.ethSignature;

  /// The identifier for signing request
  final Uint8List requestId;

  /// The signature of the signing request (r,s,v)
  final Uint8List signature;

  /// The device info for providing this signature.
  final String? origin;

  const URRegistryEthSignature({
    required this.requestId,
    required this.signature,
    this.origin,
  });

  factory URRegistryEthSignature.fromCborValue(CborValue cborValue) {
    CborMap cborMap = cborValue as CborMap;

    CborBytes cborRequestId = cborMap[const CborSmallInt(1)] as CborBytes;
    CborBytes cborSignature = cborMap[const CborSmallInt(2)] as CborBytes;
    CborString? cborOrigin = cborMap[const CborSmallInt(3)] as CborString?;

    return URRegistryEthSignature(
      requestId: Uint8List.fromList(cborRequestId.bytes),
      signature: Uint8List.fromList(cborSignature.bytes),
      origin: cborOrigin?.toString(),
    );
  }

  @override
  CborValue toCborValue({required bool includeTagBool}) {
    return CborMap.of(
      <CborValue, CborValue>{
        const CborSmallInt(1): CborBytes(requestId, tags: <int>[URRegistryType.uuid.tag]),
        const CborSmallInt(2): CborBytes(signature),
        if (origin != null) const CborSmallInt(3): CborString(origin!),
      },
      tags: includeTagBool ? <int>[registryType.tag] : <int>[],
    );
  }

  @override
  URRegistryType getRegistryType() => registryType;

  @override
  List<Object?> get props => <Object?>[requestId, signature, origin];
}
