import 'dart:typed_data';

import 'package:flutter_rust_bridge_template/sdk/accs/formatter.types.dart';

class EncryptRequest {
  final Uint8List dataToEncrypt; 
  final CanonicalAccessControlCondition? accessControlConditions;
  final CanonicalEVMCondition? evmContractConditions;
  final CanonicalUnifiedConditions? unifiedAccessControlConditions;
  final String chain;
  final AuthSig? authSig;
  final Map<String, SessionSig>? sessionSigs;

  EncryptRequest({
    required this.dataToEncrypt,
    this.accessControlConditions,
    this.evmContractConditions,
    this.unifiedAccessControlConditions,
    required this.chain,
    this.authSig,
    this.sessionSigs,
  });
}

class AuthSig {
  final dynamic sig; // 'any' in TS translates to 'dynamic' in Dart
  final String derivedVia;
  final String signedMessage;
  final String address;

  AuthSig({
    required this.sig,
    required this.derivedVia,
    required this.signedMessage,
    required this.address,
  });
}

class SessionSig {
  final String sig;
  final String derivedVia;
  final String signedMessage;
  final String address;
  final String? algo;

  SessionSig({
    required this.sig,
    required this.derivedVia,
    required this.signedMessage,
    required this.address,
    this.algo,
  });
}
