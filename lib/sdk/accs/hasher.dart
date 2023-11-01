import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:flutter_rust_bridge_template/sdk/accs/formatter.types.dart';

Future<List<int>> hashEVMContractConditions(
    List<dynamic> evmContractConditions) async {
  var canonicalEVMConditions = evmContractConditions
      .map<CanonicalEVMCondition>((c) => CanonicalEVMCondition.fromJson(c))
      .toList();

  var json = CanonicalEVMCondition.toJsonList(canonicalEVMConditions);

  // Convert to JSON string
  var toHash = jsonEncode(json);

  // Convert JSON string to bytes
  var data = utf8.encode(toHash);

  // Hash the data using SHA-256
  var digest = sha256.convert(data);

  // Return the hash as a list of integers
  return digest.bytes;
}

Future<List<int>> hashAccessControlConditions(
    List<dynamic> accessControlConditions) async {
  // Assuming you have a CanonicalAccessControlCondition class and formatter
  var canonicalConditions = accessControlConditions
      .map((c) => CanonicalAccessControlCondition.fromJson(c))
      .toList();

  var json = CanonicalAccessControlCondition.toJsonList(canonicalConditions);

  var toHash = jsonEncode(json);

  // Convert JSON string to bytes
  var data = utf8.encode(toHash);

  // Hash the data using SHA-256
  Digest digest = sha256.convert(data);

  // Return the hash as a list of integers
  return digest.bytes;
}

Future<List<int>> hashUnifiedAccessControlConditions(
    List<dynamic> unifiedAccessControlConditions) async {
  var canonicalConditions = unifiedAccessControlConditions.map((condition) {
    // Assuming you have a formatter function
    return CanonicalUnifiedConditions.fromJson(condition);
  }).toList();

  // Check for undefined conditions
  if (canonicalConditions.any((c) => c == null)) {
    throw Exception("InvalidAccessControlConditions");
  }

  if (canonicalConditions.isEmpty) {
    throw Exception("InvalidAccessControlConditions");
  }
  var json = CanonicalUnifiedConditions.toJsonList(canonicalConditions);

  // Convert to JSON
  var toHash = jsonEncode(json);

  var data = utf8.encode(toHash);
  Digest digest = sha256.convert(data);
  return digest.bytes;
}

Future<List<int>> hashResourceId(Map<String, dynamic> resourceId) async {
  var resId = {
    'baseUrl': resourceId['baseUrl'],
    'path': resourceId['path'],
    'orgId': resourceId['orgId'],
    'role': resourceId['role'],
    'extraData': resourceId['extraData']
  };

  var toHash = jsonEncode(resId); // Turn it into a JSON string
  var data = utf8.encode(toHash); // Convert JSON string to bytes
  Digest digest = sha256.convert(data); // Hash using SHA-256

  return digest.bytes; // Return the hash as a list of integers
}
