import 'package:equatable/equatable.dart';

/// Metadata for the CryptoKeypath component.
/// https://github.com/BlockchainCommons/Research/blob/master/papers/bcr-2020-007-hdkey.md#cddl-for-key-path
class PathComponent extends Equatable {
  final int index;
  final bool hardened;

  const PathComponent({
    required this.index,
    required this.hardened,
  });

  @override
  List<Object> get props => <Object>[index, hardened];
}
