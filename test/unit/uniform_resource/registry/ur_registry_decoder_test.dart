import 'dart:convert';

import 'package:qr_transfer/qr_transfer.dart';
import 'package:test/test.dart';

void main() {
  group('Tests of URRegistryDecoder.decode()', () {
    test('Should [return URRegistryCryptoCoinInfo] if given UR [type is "crypto-coin-info"]', () {
      // Arrange
      // ur:crypto-coin-info/taadehoeadcsfnaoadaygevwjs
      UR actualUR = UR(
        type: 'crypto-coin-info',
        cborPayload: base64Decode('2QExogEYPAIB'),
      );

      // Act
      IURRegistryRecord actualURRegistryRecord = URRegistryDecoder.decode(actualUR);

      // Assert
      URRegistryCryptoCoinInfo expectedURRegistryRecord = const URRegistryCryptoCoinInfo(type: 60, network: 1);

      expect(actualURRegistryRecord, expectedURRegistryRecord);
    });

    test('Should [return URRegistryCryptoHDKey] if given UR [type is "crypto-hdkey"]', () {
      // Arrange
      // ur:crypto-hdkey/onaxhdclaxpsgefyjsutpfckcalydtgyjpamjlndfsetiyhtetaajprnzseokptbhnghasesiyaahdcxvabdvsmucpttaodrfyayrobwveasvefnrezsrpbbfyotvyenwyuejogdcyiojeuoamtaaddyoeadlncsdwykcsfnykaeykaocynlzsiamnaycydyeeiyidasjnfpinjpflhsjocxdpcxjykthsjyrkbedymn
      UR actualUR = UR(
        type: 'crypto-hdkey',
        cborPayload: base64Decode(
            'pQNYIQOsSkRx3bAeHYEpUXIGb5s9OGZaOARyvvozddZgVAk5ZgRYIOYL6JMi0QIqRAi4E+QJ5Dy1+rYURKPhNu7ecFAaZ2vcBtkBMKIBhhgs9Rg89QD1AhqZ+mOOCBowNGZiCW1BaXJHYXAgLSB0d2F0'),
      );

      // Act
      IURRegistryRecord actualURRegistryRecord = URRegistryDecoder.decode(actualUR);

      // Assert
      URRegistryCryptoHDKey expectedURRegistryRecord = URRegistryCryptoHDKey(
        isMaster: false,
        isPrivate: false,
        keyData: base64Decode('A6xKRHHdsB4dgSlRcgZvmz04Zlo4BHK++jN11mBUCTlm'),
        chainCode: base64Decode('5gvokyLRAipECLgT5AnkPLX6thREo+E27t5wUBpna9w='),
        origin: const URRegistryCryptoKeypath(
          components: <PathComponent>[
            PathComponent(index: 44, hardened: true),
            PathComponent(index: 60, hardened: true),
            PathComponent(index: 0, hardened: true)
          ],
          sourceFingerprint: 2583323534,
        ),
        parentFingerprint: 808740450,
        name: 'AirGap - twat',
      );

      expect(actualURRegistryRecord, expectedURRegistryRecord);
    });

    test('Should [return URRegistryCryptoKeypath] if given UR [type is "crypto-keypath"]', () {
      // Arrange
      // ur:crypto-keypath/taaddyoeadlecsdwykcsfnykaeykaewkaewkaocymshlgtwnvejedtny
      UR actualUR = UR(
        type: 'crypto-keypath',
        cborPayload: base64Decode('2QEwogGKGCz1GDz1APUA9AD0AhqXXU3x'),
      );

      // Act
      IURRegistryRecord actualURRegistryRecord = URRegistryDecoder.decode(actualUR);

      // Assert
      URRegistryCryptoKeypath expectedURRegistryRecord = const URRegistryCryptoKeypath(
        components: <PathComponent>[
          PathComponent(index: 44, hardened: true),
          PathComponent(index: 60, hardened: true),
          PathComponent(index: 0, hardened: true),
          PathComponent(index: 0, hardened: false),
          PathComponent(index: 0, hardened: false)
        ],
        sourceFingerprint: 2539474417,
      );

      expect(actualURRegistryRecord, expectedURRegistryRecord);
    });

    test('Should [return URRegistryEthSignature] if given UR [type is "eth-signature"]', () {
      // Arrange
      // ur:eth-signature/oeadtpdagdlnrsmsyaclntgannnypfsaoxpeecamlsaohdfpwklnswwmtbwfvdrkcysettkowtksgyimcfcttbbelnjzdpsgbsdllngotptohtjlgmutdnspkskbrhbaryfnpkdndeqzdljebssnremwtpgewnadmnsklpiswmprvsfzaeonondyny
      UR actualUR = UR(
        type: 'eth-signature',
        cborPayload: base64Decode('ogHYJVCGv5f4IZ1JnpqwwqSvNQaDAlhB9IbG69bz57sawdF28HhRahkf1hCGbC3KDy+GVdjOWm9S3SvIeH65Dr08qisotC9rD821lNhK8QGOxYVo67LoQAA='),
      );

      // Act
      IURRegistryRecord actualURRegistryRecord = URRegistryDecoder.decode(actualUR);

      // Assert
      URRegistryEthSignature expectedURRegistryRecord = URRegistryEthSignature(
        requestId: base64Decode('hr+X+CGdSZ6asMKkrzUGgw=='),
        signature: base64Decode('9IbG69bz57sawdF28HhRahkf1hCGbC3KDy+GVdjOWm9S3SvIeH65Dr08qisotC9rD821lNhK8QGOxYVo67LoQAA='),
      );

      expect(actualURRegistryRecord, expectedURRegistryRecord);
    });

    test('Should [return URRegistryEthSignRequest] if given UR [type is "eth-sign-request"]', () {
      // Arrange
      // ur:eth-sign-request/oladtpdagdrdfwfsrposmnfzjppkeooxpmeooewtioaohdeoaownlspkenosadlrhkisdlaelrhprflngalfgmaymwnlbzwddskpbyhgaodpgytblbosgofrwyeyhfeezcltbysrkkemvtlaaelartaxaaaacyaepkenosahtaaddyoeadlecsdwykcsfnykaeykaewkaewkaocymshlgtwnamghtbsweyihlpkegywykkgaietdytlrehpfdprokbvdtdknceny
      UR actualUR = UR(
        type: 'eth-sign-request',
        cborPayload: base64Decode(
            'pgHYJVC6Qj22p45AcqozpK0zovBnAlgzAvGDqjanAYRZaC8AhFu8hkmCUgiUmRXqJnURVwItUdZ/p1U77jJWNP2HEcN5N+CAAIDAAwQEGgCqNqcF2QEwogGKGCz1GDz1APUA9AD0AhqXXU3xBlTWxjJlhXxR7nlJZNL5hDGwLbh+5w=='),
      );

      // Act
      IURRegistryRecord actualURRegistryRecord = URRegistryDecoder.decode(actualUR);

      // Assert
      URRegistryEthSignRequest expectedURRegistryRecord = URRegistryEthSignRequest(
        requestId: base64Decode('ukI9tqeOQHKqM6StM6LwZw=='),
        signData: base64Decode('AvGDqjanAYRZaC8AhFu8hkmCUgiUmRXqJnURVwItUdZ/p1U77jJWNP2HEcN5N+CAAIDA'),
        dataType: EthSignDataType.typedTransaction,
        chainId: 11155111,
        derivationPath: const URRegistryCryptoKeypath(
          components: <PathComponent>[
            PathComponent(index: 44, hardened: true),
            PathComponent(index: 60, hardened: true),
            PathComponent(index: 0, hardened: true),
            PathComponent(index: 0, hardened: false),
            PathComponent(index: 0, hardened: false)
          ],
          sourceFingerprint: 2539474417,
        ),
        address: base64Decode('1sYyZYV8Ue55SWTS+YQxsC24fuc='),
      );

      expect(actualURRegistryRecord, expectedURRegistryRecord);
    });
  });
}
