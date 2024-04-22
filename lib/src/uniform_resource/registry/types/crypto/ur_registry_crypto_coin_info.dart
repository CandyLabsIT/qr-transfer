import 'package:cbor/cbor.dart';
import 'package:equatable/equatable.dart';
import 'package:qr_transfer/qr_transfer.dart';

/// Metadata for a network details.
///
/// https://github.com/BlockchainCommons/Research/blob/master/papers/bcr-2020-007-hdkey.md#cddl-for-coin-info
class URRegistryCryptoCoinInfo extends Equatable implements IURRegistryRecord {
  static URRegistryType registryType = URRegistryType.cryptoCoinInfo;

  /// Coin-specific identifier for testnet or mainnet.
  /// Default is 0 for mainnet.
  final int network;

  /// Defines values values from [SLIP44](https://github.com/satoshilabs/slips/blob/master/slip-0044.md) with high bit turned off.
  final int? type;

  const URRegistryCryptoCoinInfo({
    required this.network,
    this.type,
  });

  factory URRegistryCryptoCoinInfo.fromCborValue(CborValue cborValue) {
    CborMap cborMap = cborValue as CborMap;

    CborSmallInt? cborType = cborMap[const CborSmallInt(1)] as CborSmallInt?;
    CborSmallInt? cborNetwork = cborMap[const CborSmallInt(2)] as CborSmallInt?;

    return URRegistryCryptoCoinInfo(
      network: cborNetwork?.value ?? 0,
      type: cborType?.value,
    );
  }

  @override
  CborValue toCborValue({required bool includeTagBool}) {
    return CborMap.of(
      <CborValue, CborValue>{
        if (type != null) const CborSmallInt(1): CborSmallInt(type!),
        if (network != 0) const CborSmallInt(2): CborSmallInt(network),
      },
      tags: includeTagBool ? <int>[registryType.tag] : <int>[],
    );
  }

  @override
  URRegistryType getRegistryType() => registryType;

  @override
  List<Object?> get props => <Object?>[type, network];
}
