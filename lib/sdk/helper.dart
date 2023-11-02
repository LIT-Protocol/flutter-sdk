import 'dart:math';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:typed_data';

import 'package:flutter_rust_bridge_template/sdk/accs/hasher.dart';

/// Generates a unique request ID as a hexadecimal string.
String getRequestId() {
  Random random = Random();
  return random.nextDouble().toStringAsFixed(16).substring(2);
}

Future<Map<String, dynamic>> LitConfig() async {
  WidgetsFlutterBinding.ensureInitialized();
  final String jsonString = await rootBundle.loadString('lib/sdk/config.json');
  final Map<String, dynamic> jsonData = jsonDecode(jsonString);

  if (jsonData.isEmpty) {
    throw Exception("Config file is empty");
  }

  return jsonData;
}

/// Find the element that occurs the most in an array
///
/// @param arr The array to find the most common element in.
/// @returns The most common element in the array.
dynamic mostCommonString(List<dynamic> arr) {
  return (arr.toList()
        ..sort((a, b) =>
            arr.where((v) => v == a).length - arr.where((v) => v == b).length))
      .last;
}

Uint8List toUint8List(dynamic data) {
  if (data is String) {
    return Uint8List.fromList(utf8.encode(data)); // Convert string to Uint8List
  } else if (data is int) {
    return Uint8List(4)
      ..buffer.asByteData().setInt32(0, data); // Convert int to Uint8List
  } else if (data is double) {
    return Uint8List(8)
      ..buffer.asByteData().setFloat64(0, data); // Convert double to Uint8List
  } else if (data is List<int>) {
    return Uint8List.fromList(data); // Convert list of integers to Uint8List
  } else {
    throw ArgumentError('Unsupported data type: ${data.runtimeType}');
  }
}

dynamic getHashedAccessControlConditions(Map<String, dynamic> params) async {
  // -- prepare
  Uint8List hashOfConditions;

  // -- validate
  final Map<String, dynamic> config = await LitConfig();
  List<String> supportedKeyTypes =
      (config['accs']['supported_key_types'] as List<dynamic>)
          .map((e) => e.toString())
          .toList();

  // -- check if params has any of the supported key types
  String keyType = params.keys.firstWhere(
      (key) => supportedKeyTypes.contains(key),
      orElse: () => '' // Return an empty string if no supported key found
      );

  switch (keyType) {
    case 'accessControlConditions':
      hashOfConditions =
          await hashAccessControlConditions(params[keyType] as List<dynamic>);
      break;
    case 'evmContractConditions':
      hashOfConditions =
          await hashEVMContractConditions(params[keyType] as List<dynamic>);
      break;
    case 'unifiedAccessControlConditions':
      hashOfConditions = await hashUnifiedAccessControlConditions(
          params[keyType] as List<dynamic>);
      break;
    default:
      throw Exception(
          "InvalidAccessControlConditions, key type '$keyType' is not supported. Supported key types: ${supportedKeyTypes.toString()}. Please contact us if you need to add a new key type.");
  }

  return hashOfConditions;
}
