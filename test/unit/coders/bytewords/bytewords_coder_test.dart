import 'dart:convert';
import 'dart:typed_data';

import 'package:qr_transfer/src/coders/bytewords/bytewords_coder.dart';
import 'package:qr_transfer/src/coders/bytewords/bytewords_style.dart';
import 'package:test/test.dart';

void main() {
  group('Tests of BytewordsCoder.encode()', () {
    test('Should [return bytewords] encoded from given bytes (BytewordsStyle.standard)', () {
      // Arrange
      Uint8List actualBytesToEncode = base64Decode('TWFueSBoYW5kcyBtYWtlIGxpZ2h0IHdvcmsu');

      // Act
      String actualBytewords = BytewordsCoder.encode(actualBytesToEncode, BytewordsStyle.standard);

      // Assert
      String expectedBytewords =
          'gift huts jolt kick crux iris huts jolt idle junk crux join huts jade inch crux jazz iron into iris jury crux kept jowl jump jade drum paid pose apex ramp';

      expect(actualBytewords, expectedBytewords);
    });

    test('Should [return bytewords] encoded from given bytes (BytewordsStyle.uri)', () {
      // Arrange
      Uint8List actualBytesToEncode = base64Decode('TWFueSBoYW5kcyBtYWtlIGxpZ2h0IHdvcmsu');

      // Act
      String actualBytewords = BytewordsCoder.encode(actualBytesToEncode, BytewordsStyle.uri);

      // Assert
      String expectedBytewords =
          'gift-huts-jolt-kick-crux-iris-huts-jolt-idle-junk-crux-join-huts-jade-inch-crux-jazz-iron-into-iris-jury-crux-kept-jowl-jump-jade-drum-paid-pose-apex-ramp';

      expect(actualBytewords, expectedBytewords);
    });

    test('Should [return bytewords] encoded from given bytes (BytewordsStyle.minimal)', () {
      // Arrange
      Uint8List actualBytesToEncode = base64Decode('TWFueSBoYW5kcyBtYWtlIGxpZ2h0IHdvcmsu');

      // Act
      String actualBytewords = BytewordsCoder.encode(actualBytesToEncode, BytewordsStyle.minimal);

      // Assert
      String expectedBytewords = 'gthsjtkkcxishsjtiejkcxjnhsjeihcxjzinioisjycxktjljpjedmpdpeaxrp';

      expect(actualBytewords, expectedBytewords);
    });
  });

  group('Tests of BytewordsCoder.decode()', () {
    test('Should [return bytes] decoded from given bytewords (BytewordsStyle.standard)', () {
      // Arrange
      String actualBytewords =
          'gift huts jolt kick crux iris huts jolt idle junk crux join huts jade inch crux jazz iron into iris jury crux kept jowl jump jade drum paid pose apex ramp';

      // Act
      Uint8List actualBytes = BytewordsCoder.decode(actualBytewords, BytewordsStyle.standard);

      // Assert
      Uint8List expectedBytes = base64Decode('TWFueSBoYW5kcyBtYWtlIGxpZ2h0IHdvcmsu');

      expect(actualBytes, expectedBytes);
    });

    test('Should [return bytes] decoded from given bytewords (BytewordsStyle.uri)', () {
      // Arrange
      String actualBytewords =
          'gift-huts-jolt-kick-crux-iris-huts-jolt-idle-junk-crux-join-huts-jade-inch-crux-jazz-iron-into-iris-jury-crux-kept-jowl-jump-jade-drum-paid-pose-apex-ramp';

      // Act
      Uint8List actualBytes = BytewordsCoder.decode(actualBytewords, BytewordsStyle.uri);

      // Assert
      Uint8List expectedBytes = base64Decode('TWFueSBoYW5kcyBtYWtlIGxpZ2h0IHdvcmsu');

      expect(actualBytes, expectedBytes);
    });

    test('Should [return bytes] decoded from given bytewords (BytewordsStyle.minimal)', () {
      // Arrange
      String actualBytewords = 'gthsjtkkcxishsjtiejkcxjnhsjeihcxjzinioisjycxktjljpjedmpdpeaxrp';

      // Act
      Uint8List actualBytes = BytewordsCoder.decode(actualBytewords, BytewordsStyle.minimal);

      // Assert
      Uint8List expectedBytes = base64Decode('TWFueSBoYW5kcyBtYWtlIGxpZ2h0IHdvcmsu');

      expect(actualBytes, expectedBytes);
    });
  });
}
