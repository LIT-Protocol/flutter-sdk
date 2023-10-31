import 'dart:convert';

import 'package:flutter_rust_bridge_template/sdk/accs/formatter.dart';
import 'package:flutter_rust_bridge_template/sdk/accs/formatter.types.dart';
import 'package:test/test.dart';

void main() {
  test('canonicalEVMContractConditionFormatter', () {
    var evmContractConditions = [
      {
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
      }
    ];

    var result = canonicalEVMContractConditionFormatter(evmContractConditions);
    var item = result[0];

    var expectedKeysOrder = [
      'contractAddress',
      'functionName',
      'functionParams',
      'functionAbi',
      'chain',
      'returnValueTest',
    ];

    var resultKeysOrder = item.keys.toList();

    expect(resultKeysOrder, expectedKeysOrder);
  });
}
