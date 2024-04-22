library qr_transfer;

/// A library for encoding and decoding Uniform Resources (URs) used for QR code transfer.

/// Defines available Uniform Resource (UR) data structures, and provides [URRegistryDecoder]
/// class to decode received [UR] into proper class implementing [IURRegistryRecord].
/// Usage:
///    UR ur = UR.fromCBOR(receivedCbor);
///    IURRegistryRecord urRegistryRecord = IURRegistryRecord.decode(ur);
///
/// Method returns [IURRegistryRecord] instance that can be used to access decoded data.
export 'src/uniform_resource/registry/export.dart';

/// Defines Uniform Resource (UR) object, containing CBOR encoded data from QR code.
/// Usage:
///   ```
///   // Returns UR object with given type and CBOR encoded data
///   UR ur = UR(type: 'crypto-seed', cborPayload: cborData);
///
///   // Returns UR object from given [IURRegistryRecord]
///   Ur ur = UR.fromRegistryElement(urRegistryRecord);
///
///   // Returns empty CBOR value
///   Ur ur = UR.empty();
///
///   // Decodes CBOR payload of UR into CBOR value
///   CborValue cborValue = ur.decodeCborPayload();
///   ```
export 'src/uniform_resource/ur.dart';

/// Provides functionality to decode data from Uniform Resource (UR) format from single or multi UR resource
/// Usage:
///   ```
///   // Construct URDecoder
///   URDecoder urDecoder = URDecoder();
///
///   // After reading UR data from QR code, pass it to URDecoder
///   urDecoder.receivePart(urPart);
///
///   // Check if URDecoder received whole data
///   bool receivedWholeDataBool = urDecoder.isComplete;
///
///   // Return received data as [IURRegistryRecord] if possible
///   IURRegistryRecord? urRegistryRecord = urDecoder.resultUR();
///
///   // Return received data as [UR] if possible
///   UR? ur = urDecoder.resultUR();
///
///   // Return received parts percentage
///   double progress = urDecoder.progress;
///
///   // Return estimated percentage of received data
///   double estimatedPercentComplete = urDecoder.estimatedPercentComplete;
///
///   // Return total parts count expected in current transfer
///   int expectedPartCount = urDecoder.expectedPartCount;
///   ```
export 'src/uniform_resource/ur_decoder.dart';

/// Provides functionality to encode data into Uniform Resource (UR) format
/// Usage:
///   ```
///   // Construct UREncoder
///   UREncoder urEncoder = UREncoder(ur: ur);
///
///   // Encode whole data to transfer into UR format
///   List<String> parts = urEncoder.encodeWhole();
///
///   // Return total parts count expected in current transfer
///   int fragmentsCount = urEncoder.fragmentsCount;
///
///   // Encode next part of data to transfer into UR format
///   String part = urEncoder.nextPart();
///
///   // Return whether all parts were encoded
///   bool transferCompletedBool = urEncoder.isComplete;
///
///   // Reset UREncoder to start encoding from beginning
///   urEncoder.reset();
///   ```
export 'src/uniform_resource/ur_encoder.dart';
