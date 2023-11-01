import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:flutter_rust_bridge_template/sdk/accs/formatter.dart';
import 'package:flutter_rust_bridge_template/sdk/accs/formatter.types.dart';

Future<List<int>> hashEVMContractConditions(
    List<dynamic> evmContractConditions) async {
  var canonicalEVMConditions = evmContractConditions
      .map<CanonicalEVMCondition>((map) => CanonicalEVMCondition.fromJson(map))
      .toList();

  var json = CanonicalEVMCondition.toJsonList(canonicalEVMConditions);

  // Convert to JSON string
  var toHash = jsonEncode(json);
  print('Hashing evm contract conditions: $toHash');

  // Convert JSON string to bytes
  var data = utf8.encode(toHash);

  // Hash the data using SHA-256
  var digest = sha256.convert(data);

  // Return the hash as a list of integers
  return digest.bytes;
}
