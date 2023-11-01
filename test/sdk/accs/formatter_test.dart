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
      randomizeMapKeys({
        'contractAddress': '0x3110c39b428221012934A7F617913b095BC1078C',
        'standardContractType': 'ERC1155',
        'chain': 'ethereum',
        'method': 'balanceOf',
        'parameters': [':userAddress', '9541'],
        'returnValueTest': {'comparator': '>', 'value': '0'}
      }),
      randomizeMapKeys({
        'contractAddress': '0xSomeAddress',
        'chain': 'ethereum',
        'standardContractType': 'someType',
        'method': 'someMethod',
        'parameters': 'someParameters',
        'returnValueTest': {'comparator': '=', 'value': '5'}
      }),
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
}
