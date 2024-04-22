import 'package:cbor/cbor.dart';
import 'package:equatable/equatable.dart';
import 'package:qr_transfer/qr_transfer.dart';

/// Metadata for the complete or partial derivation path of a key.
///
/// https://github.com/BlockchainCommons/Research/blob/master/papers/bcr-2020-007-hdkey.md#cddl-for-key-path
class URRegistryCryptoKeypath extends Equatable implements IURRegistryRecord {
  static URRegistryType registryType = URRegistryType.cryptoKeypath;

  /// A list of derivation path components.
  /// If empty, [sourceFingerprint] MUST be present.
  final List<PathComponent> components;

  /// Fingerprint of ancestor key, or master key if components are empty.
  /// If present, is the fingerprint of the ancestor key from which the associated key was derived.
  /// If [components] are empty, then [sourceFingerprint] MUST be a fingerprint of a master key.
  final int? sourceFingerprint;

  /// Stores the depth of the key.
  /// If present, represents the number of derivation steps in the path of the associated key,
  /// regardless of whether steps are present in the [components] element of this structure.
  ///
  /// If this is a public key derived directly from a master key it's value should be 0 - otherwise, value is optional.
  final int? depth;

  const URRegistryCryptoKeypath({
    required this.components,
    this.sourceFingerprint,
    this.depth,
  });

  factory URRegistryCryptoKeypath.fromCborValue(CborValue cborValue) {
    CborMap cborMap = cborValue as CborMap;

    CborList cborComponents = cborMap[const CborSmallInt(1)] as CborList;
    CborSmallInt? cborSourceFingerprint = cborMap[const CborSmallInt(2)] as CborSmallInt?;
    CborSmallInt? cborDepth = cborMap[const CborSmallInt(3)] as CborSmallInt?;

    List<PathComponent> components = <PathComponent>[];
    for (int i = 0; i < cborComponents.length; i += 2) {
      CborSmallInt index = cborComponents[i] as CborSmallInt;
      CborBool hardened = cborComponents[i + 1] as CborBool;

      components.add(PathComponent(index: index.value, hardened: hardened.value));
    }

    return URRegistryCryptoKeypath(
      components: components,
      sourceFingerprint: cborSourceFingerprint?.value,
      depth: cborDepth?.value,
    );
  }

  @override
  CborValue toCborValue({required bool includeTagBool}) {
    List<CborValue> cborComponents = <CborValue>[];
    for (PathComponent component in components) {
      cborComponents
        ..add(CborSmallInt(component.index))
        ..add(CborBool(component.hardened));
    }

    return CborMap.of(
      <CborValue, CborValue>{
        const CborSmallInt(1): CborList.of(cborComponents),
        if (sourceFingerprint != null) const CborSmallInt(2): CborSmallInt(sourceFingerprint!),
        if (depth != null) const CborSmallInt(3): CborSmallInt(depth!),
      },
      tags: includeTagBool ? <int>[registryType.tag] : <int>[],
    );
  }

  @override
  URRegistryType getRegistryType() => registryType;

  @override
  List<Object?> get props => <Object?>[components, sourceFingerprint, depth];
}
