import 'dart:math';

import 'package:flutter_rust_bridge_template/sdk/accs/formatter.dart';
import 'package:flutter_rust_bridge_template/sdk/accs/formatter.types.dart';
import 'package:test/test.dart';

// Helper function to randomize the orders of the  keys of a map
Map randomizeMapKeys(Map inputMap) {
  var keys = inputMap.keys.toList();
  keys.shuffle(Random());

  return Map.fromIterable(
    keys,
    key: (k) => k,
    value: (k) => inputMap[k],
  );
}

void main() {
  test('canonicalEVMContractConditionFormatter', () {
    var evmContractConditions = [
      randomizeMapKeys({
        'contractAddress': "0xc7BA08FB2546cA2198F6C69e5c4B15252D90A347",
        'functionName': "sumBytes32",
        'functionParams': [
          "[0000000000000000000000000000000000000000000000000000000000000002,0000000000000000000000000000000000000000000000000000000000000003]",
        ],
        'functionAbi': {
          'name': "sumBytes32",
          'inputs': [
            {'internalType': "bytes32[]", 'name': "vals", 'type': "bytes32[]"}
          ],
          'outputs': [
            {'internalType': "uint256", 'name': "", 'type': "uint256"}
          ],
          'constant': true,
          'stateMutability': "view",
        },
        'chain': "xdai",
        'returnValueTest': {'key': "", 'comparator': "=", 'value': "5"},
      })
    ];

    var result = canonicalEVMContractConditionFormatter(evmContractConditions);
    var item = result[0];
    var castedType = CanonicalEVMCondition.fromJson(item);

    expect(castedType.chain, 'xdai');

    var expectedKeysOrder = [
      'contractAddress',
      'functionName',
      'functionParams',
      'functionAbi',
      'chain',
      'returnValueTest',
    ];

    var resultKeysOrder = (item as Map).keys.toList();

    expect(resultKeysOrder, expectedKeysOrder);
  });

  test('canonicalAccessControlConditionFormatter', () {
    var accessControlConditions = [
      // Must posess at least one ERC1155 token with a given token id
      randomizeMapKeys({
        'contractAddress': '0x3110c39b428221012934A7F617913b095BC1078C',
        'standardContractType': 'ERC1155',
        'chain': 'ethereum',
        'method': 'balanceOf',
        'parameters': [':userAddress', '9541'],
        'returnValueTest': {'comparator': '>', 'value': '0'}
      }),

      // Must posess a specific ERC721 token (NFT)
      randomizeMapKeys({
        'contractAddress': '0x89b597199dAc806Ceecfc091e56044D34E59985c',
        'standardContractType': 'ERC721',
        'chain': 'ethereum',
        'method': 'ownerOf',
        'parameters': ['3112'],
        'returnValueTest': {'comparator': '=', 'value': ':userAddress'}
      }),

      // Must possess any token in an ERC721 collection (NFT Collection)
      randomizeMapKeys({
        'contractAddress': '0xA80617371A5f511Bf4c1dDf822E6040acaa63e71',
        'standardContractType': 'ERC721',
        'chain': 'ethereum',
        'method': 'balanceOf',
        'parameters': [':userAddress'],
        'returnValueTest': {'comparator': '>', 'value': '0'}
      }),

      // Must possess at least one ERC20 token
      randomizeMapKeys({
        'contractAddress': '0x9f8F72aA9304c8B593d555F12eF6589cC3A579A2',
        'standardContractType': 'ERC20',
        'chain': 'ethereum',
        'method': 'balanceOf',
        'parameters': [':userAddress'],
        'returnValueTest': {'comparator': '>', 'value': '0'}
      }),

      // Must possess at least 0.00001 ETH
      randomizeMapKeys({
        'contractAddress': '',
        'standardContractType': '',
        'chain': 'ethereum',
        'method': 'eth_getBalance',
        'parameters': [':userAddress', 'latest'],
        'returnValueTest': {'comparator': '>=', 'value': '10000000000000'}
      })
    ];

    var result =
        canonicalAccessControlConditionFormatter(accessControlConditions);

    for (var item in result) {
      var casedType = CanonicalAccessControlCondition.fromJson(item);

      expect(casedType.chain, 'ethereum');

      var expectedKeysOrder = [
        'contractAddress',
        'chain',
        'standardContractType',
        'method',
        'parameters',
        'returnValueTest'
      ];

      var resultKeysOrder = (item as Map).keys.toList();

      // Check if the keys are in the expected order
      expect(resultKeysOrder, expectedKeysOrder);
    }
  });

  test('canonicalUnifiedAccessControlConditionFormatter', () {
    var unifiedConditions = [
      randomizeMapKeys({
        'operator': 'AND',
      }),
      randomizeMapKeys({
        'conditionType': 'evmBasic',
        'contractAddress': '0xAddress1',
        'chain': 'ethereum',
        'standardContractType': 'ERC20',
        'method': 'balanceOf',
        'parameters': [':userAddress'],
        'returnValueTest': {'comparator': '>', 'value': '10'},
      }),
      randomizeMapKeys({
        'conditionType': 'evmContract',
        'contractAddress': '0xAddress2',
        'functionName': 'someFunction',
        'functionParams': [':param1', ':param2'],
        'functionAbi': {'name': 'somefing'},
        'chain': 'ethereum',
        'returnValueTest': {'comparator': '=', 'value': 'true'},
      }),
    ];

    // Assume this function call returns a list of canonicalized conditions
    var result =
        canonicalUnifiedAccessControlConditionFormatter(unifiedConditions);

    var castedType = CanonicalUnifiedCondition.fromJson(result[1]);
    var castedType2 = CanonicalUnifiedCondition.fromJson(result[2]);

    // Test common property
    expect(castedType.chain, 'ethereum');
    expect(castedType2.chain, 'ethereum');

    for (var item in result) {
      var castedType = CanonicalUnifiedCondition.fromJson(item);

      // Additional checks based on the conditionType
      if (castedType.conditionType == 'evmBasic') {
        expect(castedType.method, 'balanceOf');
        var expectedKeysOrder = [
          'contractAddress',
          'chain',
          'standardContractType',
          'method',
          'parameters',
          'returnValueTest'
        ];
        var resultKeysOrder = (item as Map).keys.toList();
        expect(resultKeysOrder, expectedKeysOrder);
      }

      if (castedType.conditionType == 'evmContract') {
        expect(castedType.functionName, 'someFunction');
        var expectedKeysOrder = [
          'contractAddress',
          'chain',
          'functionName',
          'functionParams',
          'functionAbi',
          'returnValueTest'
        ];
        var resultKeysOrder = (item as Map).keys.toList();
        expect(resultKeysOrder, expectedKeysOrder);
      }

      if (castedType.operator != null) {
        print("castedType: $castedType");
        expect(castedType.operator, 'AND');
        var expectedKeysOrder = ['operator'];
        var resultKeysOrder = (item as Map).keys.toList();
        expect(resultKeysOrder, expectedKeysOrder);
      }
    }
  });
}
