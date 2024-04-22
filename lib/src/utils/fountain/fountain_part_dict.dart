import 'package:equatable/equatable.dart';
import 'package:qr_transfer/src/utils/fountain/decoder/fountain_decoder_part.dart';

/// The [FountainPartDic] class associates a list of integers (key) with a [FountainDecoderPart] (value),
/// aiding in organizing and accessing data parts based on their indices.
class FountainPartDic extends Equatable {
  /// The key representing identifiers for parts of the encoded message.
  final List<int> key;

  /// The value, storing a [FountainDecoderPart] which contains a segment of the decoded data
  /// along with associated metadata necessary for reconstruction.
  final FountainDecoderPart value;

  /// Creates a new instance of [FountainPartDic] with the specified key and value.
  const FountainPartDic({required this.key, required this.value});

  @override
  List<Object> get props => <Object>[key, value];
}
