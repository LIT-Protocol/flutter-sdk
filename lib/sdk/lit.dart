import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter_rust_bridge_template/sdk/handshakes.dart';
import 'package:flutter_rust_bridge_template/sdk/helper.dart';
import 'package:flutter_rust_bridge_template/sdk/lit.types.dart';

class LitNodeClient {
  List<dynamic> bootstrapUrls = [];
  Set<String> connectedNodes = {};
  List<Map<String, String>> serverKeys = [];
  bool ready = false;
  String? subnetPubKey;
  String? networkPubKey;
  String? networkPubKeySet;
  Map<String, dynamic> litConfig = {};

  // Constructor
  LitNodeClient({bootstrapUrls}) {
    if (bootstrapUrls != null) {
      this.bootstrapUrls = bootstrapUrls;
    }
  }

  Future<void> setup() async {
    litConfig = await LitConfig();

    if (bootstrapUrls.isEmpty) {
      bootstrapUrls = litConfig["lit_networks"]["cayenne"];

      if (bootstrapUrls.isEmpty) {
        throw Exception("No bootstrap URLs found");
      }
    }
  }

  // Connect to Lit nodes
  Future<bool> connect() async {
    await setup();

    for (dynamic url in bootstrapUrls) {
      try {
        var res = await handshakeWithNode(url);

        connectedNodes.add(url);

        // -- validate
        const requiredKeys = [
          "serverPublicKey",
          "subnetPublicKey",
          "networkPublicKey",
          "networkPublicKeySet"
        ];

        // they must exists in the response
        for (String key in requiredKeys) {
          if (!res.containsKey(key)) {
            throw Exception("Missing key: $key");
          }
        }

        serverKeys.add({
          "serverPubKey": res["serverPublicKey"],
          "subnetPubKey": res["subnetPublicKey"],
          "networkPubKey": res["networkPublicKey"],
          "networkPubKeySet": res["networkPublicKeySet"],
        });
      } catch (e) {
        print('Failed to connect to $url: $e');
      }
    }

    // -- validate
    if (serverKeys.length <= litConfig['min_node_count']) {
      throw Exception("Not enough nodes connected");
    }

    // -- prepare
    subnetPubKey = mostCommonString(serverKeys
        .map((keysFromSingleNode) => keysFromSingleNode['subnetPubKey'])
        .toList());
    networkPubKey = mostCommonString(serverKeys
        .map((keysFromSingleNode) => keysFromSingleNode['networkPubKey'])
        .toList());
    networkPubKeySet = mostCommonString(serverKeys
        .map((keysFromSingleNode) => keysFromSingleNode['networkPubKeySet'])
        .toList());
    ready = true;

    print(
        '🔥 lit is ready. "litNodeClient" variable is ready to use globally.');

    return true;
  }

  ///
  /// Encrypt data using the Lit network public key
  Future<String> encrypt(EncryptRequest params) async {
    if (!ready) {
      await connect();

      if (!ready) {
        throw Exception("Lit node client is not ready yet");
      }
    }

    if (subnetPubKey == null) {
      throw Exception("Subnet public key is null");
    }

    // -- convert data to Uint8List
    // var dataToEncryptBuffer = toUint8List(dataToEncrypt);

    // -- handle

    return 'Not implemented yet';
  }
}
