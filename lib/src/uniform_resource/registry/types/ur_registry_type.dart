enum URRegistryType {
  uuid(type: 'uuid', tag: 37),
  cryptoHDKey(type: 'crypto-hdkey', tag: 303),
  cryptoKeypath(type: 'crypto-keypath', tag: 304),
  cryptoCoinInfo(type: 'crypto-coin-info', tag: 305),
  cryptoECKey(type: 'crypto-eckey', tag: 306),
  cryptoOutput(type: 'crypto-output', tag: 308),
  cryptoPSBT(type: 'crypto-psbt', tag: 310),
  cryptoAccount(type: 'crypto-account', tag: 311),
  cryptoMultiAccounts(type: 'crypto-multi-accounts', tag: 1103),

  // ETH
  ethSignRequest(type: 'eth-sign-request', tag: 401),
  ethSignature(type: 'eth-signature', tag: 402),

  // SOL
  solSignRequest(type: 'sol-sign-request', tag: 1101),
  solSignature(type: 'sol-signature', tag: 1102),

  // QR hardware call
  qrHardwareCall(type: 'qr-hardware-call', tag: 1201),
  keyDerivationCall(type: 'key-derivation-call', tag: 1301),
  keyDerivationSchema(type: 'key-derivation-schema', tag: 1302),

  // Cosmos
  cosmosSignRequest(type: 'cosmos-sign-request', tag: 4101),
  cosmosSignature(type: 'cosmos-signature', tag: 4102),

  // EVM
  evmSignRequest(type: 'evm-sign-request', tag: 4101),
  evmSignature(type: 'evm-signature', tag: 4102),

  // BTC
  btcSignRequest(type: 'btc-sign-request', tag: 8101),
  btcSignature(type: 'btc-signature', tag: 8102);

  final String type;
  final int tag;

  const URRegistryType({
    required this.type,
    required this.tag,
  });

  factory URRegistryType.fromTag(int tag) {
    return URRegistryType.values.firstWhere((URRegistryType type) => type.tag == tag);
  }

  factory URRegistryType.fromType(String value) {
    return URRegistryType.values.firstWhere((URRegistryType type) => type.type == value);
  }
}
