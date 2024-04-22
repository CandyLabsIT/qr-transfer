import 'dart:convert';

import 'package:qr_transfer/qr_transfer.dart';
import 'package:test/test.dart';

void main() {
  group('Tests of URDecoder process', () {
    group('Tests for simple UR (single-fragment)', () {
      URDecoder actualURDecoder = URDecoder();

      test('Should [return initial values] if no parts received', () {
        // Arrange
        expect(actualURDecoder.resultRegistryRecord(), null);
        expect(actualURDecoder.resultUR(), null);
        expect(actualURDecoder.progress, 0.0);
        expect(actualURDecoder.estimatedPercentComplete, 0.0);
        expect(actualURDecoder.isComplete, false);
        expect(actualURDecoder.expectedPartCount, null);
      });

      test('Should [return complete values] if all fragments received (single part)', () async {
        // Act
        actualURDecoder.receivePart('ur:crypto-keypath/taaddyoeadlecsdwykcsfnykaeykaewkaewkaocymshlgtwnvejedtny');

        // Arrange
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

        UR expectedUR = UR(
          type: 'crypto-keypath',
          cborPayload: base64Decode('2QEwogGKGCz1GDz1APUA9AD0AhqXXU3x'),
        );

        expect(actualURDecoder.resultRegistryRecord(), expectedURRegistryRecord);
        expect(actualURDecoder.resultUR(), expectedUR);
        expect(actualURDecoder.progress, 1.0);
        expect(actualURDecoder.estimatedPercentComplete, 1.0);
        expect(actualURDecoder.isComplete, true);
        expect(actualURDecoder.expectedPartCount, 1);
      });
    });

    group('Tests for simple UR (multi-fragment - within range)', () {
      URDecoder actualURDecoder = URDecoder();

      test('Should [return initial values] if no parts received', () {
        // Arrange
        expect(actualURDecoder.resultRegistryRecord(), null);
        expect(actualURDecoder.resultUR(), null);
        expect(actualURDecoder.progress, 0.0);
        expect(actualURDecoder.estimatedPercentComplete, 0.0);
        expect(actualURDecoder.isComplete, false);
        expect(actualURDecoder.expectedPartCount, null);
      });

      test('Should [return actual values] after 1st fragment received (1/4)', () async {
        // Act
        actualURDecoder.receivePart('ur:crypto-hdkey/1-4/lpadaacsjpcyrkbedymnhdcaonaxhdclaxpsgefyjsutpfckcalydtgyjpamjlndfsetiyhtetaajprnzslkoxkkto');

        // Arrange
        expect(actualURDecoder.resultRegistryRecord(), null);
        expect(actualURDecoder.resultUR(), null);
        expect(actualURDecoder.progress, 0.25);
        expect(actualURDecoder.estimatedPercentComplete, 0.14285714285714285);
        expect(actualURDecoder.isComplete, false);
        expect(actualURDecoder.expectedPartCount, 4);
      });

      test('Should [return actual values] after 2nd fragment received (2/4)', () async {
        // Act
        actualURDecoder.receivePart('ur:crypto-hdkey/2-4/lpaoaacsjpcyrkbedymnhdcaeokptbhnghasesiyaahdcxvabdvsmucpttaodrfyayrobwveasvefnrezsnelbpfdw');

        // Arrange
        expect(actualURDecoder.resultRegistryRecord(), null);
        expect(actualURDecoder.resultUR(), null);
        expect(actualURDecoder.progress, 0.5);
        expect(actualURDecoder.estimatedPercentComplete, 0.2857142857142857);
        expect(actualURDecoder.isComplete, false);
        expect(actualURDecoder.expectedPartCount, 4);
      });

      test('Should [return actual values] after 4th fragment received (3/4)', () async {
        // Act
        actualURDecoder.receivePart('ur:crypto-hdkey/4-4/lpaaaacsjpcyrkbedymnhdcaaocynlzsiamnaycydyeeiyidasjnfpinjpflhsjocxdpcxjykthsjyaeaetidnyarh');

        // Arrange
        expect(actualURDecoder.resultRegistryRecord(), null);
        expect(actualURDecoder.resultUR(), null);
        expect(actualURDecoder.progress, 0.75);
        expect(actualURDecoder.estimatedPercentComplete, 0.42857142857142855);
        expect(actualURDecoder.isComplete, false);
        expect(actualURDecoder.expectedPartCount, 4);
      });

      test('Should [return complete values] after 3rd fragment received (4/4)', () async {
        // Act
        actualURDecoder.receivePart('ur:crypto-hdkey/3-4/lpaxaacsjpcyrkbedymnhdcarpbbfyotvyenwyuejogdcyiojeuoamtaaddyoeadlncsdwykcsfnykaeykondpwlfp');

        // Arrange
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

        UR expectedUR = UR(
          type: 'crypto-hdkey',
          cborPayload: base64Decode(
              'pQNYIQOsSkRx3bAeHYEpUXIGb5s9OGZaOARyvvozddZgVAk5ZgRYIOYL6JMi0QIqRAi4E+QJ5Dy1+rYURKPhNu7ecFAaZ2vcBtkBMKIBhhgs9Rg89QD1AhqZ+mOOCBowNGZiCW1BaXJHYXAgLSB0d2F0'),
        );

        expect(actualURDecoder.resultRegistryRecord(), expectedURRegistryRecord);
        expect(actualURDecoder.resultUR(), expectedUR);
        expect(actualURDecoder.progress, 1);
        expect(actualURDecoder.estimatedPercentComplete, 1);
        expect(actualURDecoder.isComplete, true);
        expect(actualURDecoder.expectedPartCount, 4);
      });
    });

    group('Tests for simple UR (multi-fragment - range overflow)', () {
      URDecoder actualURDecoder = URDecoder();

      test('Should [return initial values] if no parts received', () {
        // Arrange
        expect(actualURDecoder.resultRegistryRecord(), null);
        expect(actualURDecoder.resultUR(), null);
        expect(actualURDecoder.progress, 0.0);
        expect(actualURDecoder.estimatedPercentComplete, 0.0);
        expect(actualURDecoder.isComplete, false);
        expect(actualURDecoder.expectedPartCount, null);
      });

      test('Should [return actual values] after 1st fragment received (1/3)', () async {
        // Act
        actualURDecoder.receivePart(
            'ur:eth-sign-request/108-3/lpcsjzaxcfadmkcyoymneoamhdlowkcyskeoiahyrsprjteopkhlbblnztfehhberlceecgrbkhphkaeidkgeyeejsdkdydpdndaglehkgdafnhdfhfxdpcmbtkiindebbjpeccpemeyhsetfrdpieeohnksemcpkneceydnkpindsecfrihfndifldsfnimbneskohsbwatctcwsbfwdnpmglrlhlehwngyfnzmguptfdvycyzcgyfltaadaovdamhetblghkfprkjpbgynjkgljnmuztmndiykbarhdpndoxaoasse');

        // Arrange
        expect(actualURDecoder.resultRegistryRecord(), null);
        expect(actualURDecoder.resultUR(), null);
        expect(actualURDecoder.progress, 0.0);
        expect(actualURDecoder.estimatedPercentComplete, 0.19047619047619047);
        expect(actualURDecoder.isComplete, false);
        expect(actualURDecoder.expectedPartCount, 3);
      });

      test('Should [return actual values] after 3rd fragment received (2/3)', () async {
        // Act
        actualURDecoder.receivePart(
            'ur:eth-sign-request/292-3/lpcfaddkaxcfadmkcyoymneoamhdlodyksieeniaeneoeyenecetecemiaecehihihemeseeeseneeieeyiyeseteeeoehiddyeyieidetemihihembkbkgljljtiaihftbkemeyesemenhseoesdpiaeyeeesdpeeeoeoendpideseoecdphsenieiaecehiheneyemececaxaxahtaaddyoeadlecsdwykcsfnykaeykaewkaewkaocymshlgtwnamghtbsweyihlpkegywykkgaietdytlrehpfdprokbvdbsrlzere');

        // Arrange
        expect(actualURDecoder.resultRegistryRecord(), null);
        expect(actualURDecoder.resultUR(), null);
        expect(actualURDecoder.progress, 0.3333333333333333);
        expect(actualURDecoder.estimatedPercentComplete, 0.38095238095238093);
        expect(actualURDecoder.isComplete, false);
        expect(actualURDecoder.expectedPartCount, 3);
      });

      test('Should [return complete values] after 2nd fragment received (3/3)', () async {
        // Act
        actualURDecoder.receivePart(
            'ur:eth-sign-request/252-3/lpcsztaxcfadmkcyoymneoamhdlomdkkrfbweoehteuybtgelekpkewzloecdldrmkeohtfrjlecdrihaxgohphphyghfwfyhlfydpfdgmbdengmjednfyihdpbsbnhkhschfghfchfeayghhgbtbkhhbbhdfxgdbwgmgoglatgaflbzhkasgufydwfeghbdihhghfbzhsiyjsispkclhesscltakihylsjshemhcxutislajylrjscxrojpcplyiaftonotgugrwpbwkbnycmftgtwzmkwdgomhkisgchmesstejnfx');

        // Arrange
        URRegistryEthSignRequest expectedURRegistryRecord = URRegistryEthSignRequest(
          requestId: base64Decode('B+DpO3+yQEuRvQRKT68Kbg=='),
          signData: base64Decode(
              'V2VsY29tZSB0byBPcGVuU2VhIQoKQ2xpY2sgdG8gc2lnbiBpbiBhbmQgYWNjZXB0IHRoZSBPcGVuU2VhIFRlcm1zIG9mIFNlcnZpY2UgKGh0dHBzOi8vb3BlbnNlYS5pby90b3MpIGFuZCBQcml2YWN5IFBvbGljeSAoaHR0cHM6Ly9vcGVuc2VhLmlvL3ByaXZhY3kpLgoKVGhpcyByZXF1ZXN0IHdpbGwgbm90IHRyaWdnZXIgYSBibG9ja2NoYWluIHRyYW5zYWN0aW9uIG9yIGNvc3QgYW55IGdhcyBmZWVzLgoKV2FsbGV0IGFkZHJlc3M6CjB4ZDZjNjMyNjU4NTdjNTFlZTc5NDk2NGQyZjk4NDMxYjAyZGI4N2VlNwoKTm9uY2U6CjcyOTc2YTM5LWMyNDktNDMzNi1iOTM1LWE2ZGM1MWU2Mjc1NQ=='),
          dataType: EthSignDataType.rawBytes,
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

        UR expectedUR = UR(
          type: 'eth-sign-request',
          cborPayload: base64Decode(
              'pQHYJVAH4Ok7f7JAS5G9BEpPrwpuAlkBTldlbGNvbWUgdG8gT3BlblNlYSEKCkNsaWNrIHRvIHNpZ24gaW4gYW5kIGFjY2VwdCB0aGUgT3BlblNlYSBUZXJtcyBvZiBTZXJ2aWNlIChodHRwczovL29wZW5zZWEuaW8vdG9zKSBhbmQgUHJpdmFjeSBQb2xpY3kgKGh0dHBzOi8vb3BlbnNlYS5pby9wcml2YWN5KS4KClRoaXMgcmVxdWVzdCB3aWxsIG5vdCB0cmlnZ2VyIGEgYmxvY2tjaGFpbiB0cmFuc2FjdGlvbiBvciBjb3N0IGFueSBnYXMgZmVlcy4KCldhbGxldCBhZGRyZXNzOgoweGQ2YzYzMjY1ODU3YzUxZWU3OTQ5NjRkMmY5ODQzMWIwMmRiODdlZTcKCk5vbmNlOgo3Mjk3NmEzOS1jMjQ5LTQzMzYtYjkzNS1hNmRjNTFlNjI3NTUDAwXZATCiAYoYLPUYPPUA9QD0APQCGpddTfEGVNbGMmWFfFHueUlk0vmEMbAtuH7n'),
        );

        expect(actualURDecoder.resultRegistryRecord(), expectedURRegistryRecord);
        expect(actualURDecoder.resultUR(), expectedUR);
        expect(actualURDecoder.progress, 1);
        expect(actualURDecoder.estimatedPercentComplete, 1);
        expect(actualURDecoder.isComplete, true);
        expect(actualURDecoder.expectedPartCount, 3);
      });
    });
  });
}
