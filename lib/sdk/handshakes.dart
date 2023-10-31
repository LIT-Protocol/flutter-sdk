import 'package:flutter_rust_bridge_template/sdk/helper.dart';
import 'package:flutter_rust_bridge_template/sdk/lit.dart';
import 'dart:async';
import 'dart:core';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'dart:convert';

Future<Map<String, dynamic>> sendCommandToNode(
    String url, Map<String, String> data) async {
  // -- prepare
  final String requestId = getRequestId();
  final Map<String, dynamic> config = await LitConfig();
  final String headerVersion = config["X-Lit-SDK-Version"];
  final String headerType = config["X-Lit-SDK-Type"];
  final String headerRequestIdPrefix = config["X-Request-Id"];

  // -- validate
  // make sure they are not empty strings
  assert(requestId != "");
  assert(headerVersion != "");
  assert(headerType != "");
  assert(headerRequestIdPrefix != "");

  // -- prepare
  Map<String, String> headers = {
    "Content-Type": "application/json",
    "X-Lit-SDK-Version": headerVersion,
    "X-Lit-SDK-Type": headerType,
    "X-Request-Id": "$headerRequestIdPrefix$requestId"
  };

  http.Response response = await http.post(
    Uri.parse(url),
    headers: headers,
    body: jsonEncode(data),
  );

  bool isJson =
      response.headers['content-type']?.contains('application/json') ?? false;

  dynamic responseData = isJson ? jsonDecode(response.body) : null;

  if (response.statusCode != 200) {
    // Get error message from body or default to response status code
    dynamic error = responseData ?? response.statusCode;
    throw Exception(error);
  }

  return responseData;
}

// ============================== List of Handshakes ==============================
/// Sends a handshake request to a Lit Node
Future<Map<String, dynamic>> handshakeWithNode(String url) async {
  // -- prepare path
  final Map<String, dynamic> config = await LitConfig();
  final String path = config["lit_node_apis"]["handshake"];

  if (path == '') {
    throw Exception("Handshake path is empty");
  }

  String urlWithPath = '$url$path';

  // -- prepare data
  Map<String, String> data = {'clientPublicKey': 'test'};

  // -- send command
  return sendCommandToNode(urlWithPath, data);
}
