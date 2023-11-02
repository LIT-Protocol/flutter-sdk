import 'dart:typed_data';

import 'package:flutter_rust_bridge_template/sdk/accs/formatter.types.dart';

class EncryptRequest {
  final String dataToEncrypt;
  final List<CanonicalAccessControlCondition>? accessControlConditions;
  final List<CanonicalEVMCondition>? evmContractConditions;
  final List<CanonicalUnifiedConditions>? unifiedAccessControlConditions;
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

  static Map<String, dynamic> toMap(params) {
    return {
      'dataToEncrypt': params.dataToEncrypt,
      'accessControlConditions': params.accessControlConditions
          ?.map((condition) => condition.toJson(condition))
          .toList(),
      'evmContractConditions': params.evmContractConditions
          ?.map((condition) => condition.toJson(condition))
          .toList(),
      'unifiedAccessControlConditions': params.unifiedAccessControlConditions
          ?.map((condition) => condition.toJson(condition))
          .toList(),
      'chain': params.chain,
      'authSig': params.authSig?.sig,
      'sessionSigs':
          params.sessionSigs?.map((key, value) => MapEntry(key, value.sig)),
    };
  }
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

class EncryptResponse {
  final String ciphertext;
  final String dataToEncryptHash;

  EncryptResponse({required this.ciphertext, required this.dataToEncryptHash});
}
