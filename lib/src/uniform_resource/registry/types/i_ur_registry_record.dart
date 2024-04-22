import 'package:cbor/cbor.dart';
import 'package:qr_transfer/qr_transfer.dart';

abstract interface class IURRegistryRecord {
  URRegistryType getRegistryType();

  /// When a CBOR with a UR type is encoded as standalone CBOR or anywhere embedded
  /// in a CBOR structure, its tag MUST match the tag registered with the UR type.
  ///
  /// On the other hand, if the CBOR structure is the top-level object in a UR,
  /// then it  MUST NOT be tagged, as the UR type provides that information.
  ///
  /// https://github.com/BlockchainCommons/Research/blob/master/papers/bcr-2020-005-ur.md#ur-cbor-tags
  CborValue toCborValue({required bool includeTagBool});
}
