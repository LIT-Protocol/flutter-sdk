import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:flutter/services.dart';
import 'package:flutter_rust_bridge_template/native.dart';
import 'package:flutter_rust_bridge_template/sdk/accs/uint8arrays.dart';
import 'package:flutter_rust_bridge_template/sdk/handshakes.dart';
import 'package:flutter_rust_bridge_template/sdk/helper.dart';
import 'package:flutter_rust_bridge_template/sdk/lit.types.dart';
import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'dart:typed_data';
import 'package:convert/convert.dart';
import 'package:flutter_rust_bridge_template/sdk/helper.dart';
import 'package:flutter_rust_bridge_template/sdk/lit.dart';

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
  ///
  Future<EncryptResponse> encrypt(EncryptRequest params) async {
    if (!ready) {
      await connect();

      if (!ready) {
        throw Exception("Lit node client is not ready yet");
      }
    }

    if (subnetPubKey == null) {
      throw Exception("Subnet public key is null");
    }

    // -- 1. hash accs
    final hashedConditions =
        await getHashedAccessControlConditions(EncryptRequest.toMap(params));

    final hashedConditionsString = uint8ListToHex(hashedConditions);

    final hashedConditionsHex =
        uint8arrayFromString(hashedConditionsString, 'base16');

    // -- 2. hash data to encrypt
    var privateDataBuffer = toUint8List(params.dataToEncrypt);
    final dataToEncryptHash = uint8arrayToString(privateDataBuffer, 'base16');

    // -- 3. assemble identity param TODO: 0.0.2
    final identityParam =
        'lit-accesscontrolcondition://$hashedConditionsHex/$dataToEncryptHash';

    // -- 4. encrypt
    final ciphertext = await bls.encrypt(
        publicKey: subnetPubKey ?? '',
        message: hex.encode(privateDataBuffer),
        identity: hex.encode(uint8arrayFromString(identityParam, 'utf8')));

    return EncryptResponse(
        ciphertext: ciphertext, dataToEncryptHash: dataToEncryptHash);
  }
}
