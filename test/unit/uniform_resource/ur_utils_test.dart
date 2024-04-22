import 'package:qr_transfer/src/uniform_resource/ur_utils.dart';
import 'package:test/test.dart';

void main() {
  group('Tests of URUtils.isValidURType()', () {
    test('Should [return TRUE] if UR type is valid', () {
      // Arrange
      String actualURType = 'crypto-keypath';

      // Act
      bool actualURTypeValidBool = URUtils.isValidURType(actualURType);

      // Assert
      expect(actualURTypeValidBool, true);
    });

    test('Should [return FALSE] if UR type is invalid', () {
      // Arrange
      String actualURType = 'crypto#keypath';

      // Act
      bool actualURTypeValidBool = URUtils.isValidURType(actualURType);

      // Assert
      expect(actualURTypeValidBool, false);
    });
  });
}
