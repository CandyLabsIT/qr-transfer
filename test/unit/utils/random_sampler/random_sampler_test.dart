import 'package:qr_transfer/src/utils/random_sampler/random_sampler.dart';
import 'package:qr_transfer/src/utils/xoshiro/xoshiro.dart';
import 'package:test/test.dart';

void main() {
  group('Tests of RandomSampler.next()', () {
    // Arrange
    RandomSampler actualRandomSampler = RandomSampler(
      probabilities: <double>[0.5, 0.5],
      rng: Xoshiro(<int>[0, 0, 0, 2, 161, 142, 51, 6]),
    );

    test('Should [return next sampled outcome] based on the provided probabilities (1st round)', () {
      // Act
      int actualSampledOutcome = actualRandomSampler.next();

      // Assert
      int expectedSampledOutcome = 0;

      expect(actualSampledOutcome, expectedSampledOutcome);
    });

    test('Should [return next sampled outcome] based on the provided probabilities (2nd round)', () {
      // Act
      int actualSampledOutcome = actualRandomSampler.next();

      // Assert
      int expectedSampledOutcome = 0;

      expect(actualSampledOutcome, expectedSampledOutcome);
    });

    test('Should [return next sampled outcome] based on the provided probabilities (3rd round)', () {
      // Act
      int actualSampledOutcome = actualRandomSampler.next();

      // Assert
      int expectedSampledOutcome = 1;

      expect(actualSampledOutcome, expectedSampledOutcome);
    });
  });
}
