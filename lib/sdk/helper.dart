import 'dart:math';
import 'package:flutter_rust_bridge_template/sdk/lit.dart';
import 'dart:convert';
import 'package:flutter/services.dart';

/// Generates a unique request ID as a hexadecimal string.
String getRequestId() {
  Random random = Random();
  return random.nextDouble().toStringAsFixed(16).substring(2);
}

Future<Map<String, dynamic>> LitConfig() async {
  final String jsonString = await rootBundle.loadString('lib/sdk/config.json');
  final Map<String, dynamic> jsonData = jsonDecode(jsonString);
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
