import 'dart:typed_data';

import 'package:cbor/cbor.dart';
import 'package:equatable/equatable.dart';
import 'package:qr_transfer/qr_transfer.dart';

/// Metadata for the signing request for Ethereum.
/// https://github.com/ethereum/ercs/blob/master/ERCS/erc-4527.md#cddl-for-eth-sign-request
class URRegistryEthSignRequest extends Equatable implements IURRegistryRecord {
  static URRegistryType registryType = URRegistryType.ethSignRequest;

  /// Data to be signed by offline signer, currently it can be unsigned transaction or typed data.
  /// For unsigned transactions it will be the rlp encoding for unsigned
  /// transaction data and ERC 712 typed data it will be the bytes of json string.
  final Uint8List signData;

  /// The type of data to be signed, listed in [EthSignDataType]
  final EthSignDataType dataType;

  /// The key path of the private key to sign the data
  final URRegistryCryptoKeypath derivationPath;

  /// Chain id of ethereum related blockchain.
  /// Each ethereum-based chain has its own file CAIP-2.json containing the chain id.
  final int chainId;

  /// The identifier for signing request
  final Uint8List? requestId;

  /// Ethereum address of the signing type for verification purposes which is optional
  final Uint8List? address;

  /// The origin of this sign request, like wallet name
  final String? origin;

  const URRegistryEthSignRequest({
    required this.signData,
    required this.dataType,
    required this.derivationPath,
    this.chainId = 1,
    this.requestId,
    this.address,
    this.origin,
  });

  factory URRegistryEthSignRequest.fromCborValue(CborValue cborValue) {
    CborMap cborMap = cborValue as CborMap;

    CborBytes cborRequestId = cborMap[const CborSmallInt(1)] as CborBytes;
    CborBytes cborSignData = cborMap[const CborSmallInt(2)] as CborBytes;
    CborSmallInt? cborDataType = cborMap[const CborSmallInt(3)] as CborSmallInt?;
    CborSmallInt? cborChainId = cborMap[const CborSmallInt(4)] as CborSmallInt?;
    CborValue cborDerivationPath = cborMap[const CborSmallInt(5)]!;
    CborBytes cborAddress = cborMap[const CborSmallInt(6)] as CborBytes;
    CborString? cborOrigin = cborMap[const CborSmallInt(7)] as CborString?;

    return URRegistryEthSignRequest(
      requestId: Uint8List.fromList(cborRequestId.bytes),
      signData: Uint8List.fromList(cborSignData.bytes),
      dataType: cborDataType != null ? EthSignDataType.fromCborIndex(cborDataType.value) : EthSignDataType.fromCborIndex(1),
      chainId: cborChainId?.value ?? 1,
      derivationPath: URRegistryCryptoKeypath.fromCborValue(cborDerivationPath),
      address: Uint8List.fromList(cborAddress.bytes),
      origin: cborOrigin?.toString(),
    );
  }

  @override
  CborValue toCborValue({required bool includeTagBool}) {
    return CborMap.of(
      <CborValue, CborValue>{
        if (requestId != null) const CborSmallInt(1): CborBytes(Uint8List.fromList(requestId!), tags: <int>[URRegistryType.uuid.tag]),
        const CborSmallInt(2): CborBytes(Uint8List.fromList(signData)),
        const CborSmallInt(3): CborSmallInt(dataType.cborIndex),
        if (chainId != 1) const CborSmallInt(4): CborSmallInt(chainId),
        const CborSmallInt(5): derivationPath.toCborValue(includeTagBool: true),
        if (address != null) const CborSmallInt(6): CborBytes(Uint8List.fromList(address!)),
        if (origin != null) const CborSmallInt(7): CborString(origin!),
      },
      tags: includeTagBool ? <int>[registryType.tag] : <int>[],
    );
  }

  @override
  URRegistryType getRegistryType() => registryType;

  @override
  List<Object?> get props => <Object?>[requestId, signData, dataType, chainId, derivationPath, address, origin];
}
