import 'dart:math';
import 'package:flutter_rust_bridge_template/sdk/accs/hasher.dart';
import 'package:test/test.dart';

void main() {
  test('hashEVMContractConditions should return expected hash', () async {
    var mockEvmContractConditions = [
      {
        'contractAddress': '0xb71a679cfff330591d556c4b9f21c7739ca9590c',
        'functionName': 'members',
        'functionParams': [':userAddress'],
        'functionAbi': {
          'constant': true,
          'inputs': [
            {
              'name': '',
              'type': 'address',
            },
          ],
          'name': 'members',
          'outputs': [
            {
              'name': 'delegateKey',
              'type': 'address',
            },
            {
              'name': 'shares',
              'type': 'uint256',
            },
            {
              'name': 'loot',
              'type': 'uint256',
            },
            {
              'name': 'exists',
              'type': 'bool',
            },
            {
              'name': 'highestIndexYesVote',
              'type': 'uint256',
            },
            {
              'name': 'jailed',
              'type': 'uint256',
            },
          ],
          'payable': false,
          'stateMutability': 'view',
          'type': 'function',
        },
        'chain': 'xdai',
        'returnValueTest': {
          'key': 'shares',
          'comparator': '>=',
          'value': '1',
        },
      },
    ];

    var result = await hashEVMContractConditions(mockEvmContractConditions);

    expect(result[0], 198);
  });

  test('hashAccessControlConditions should return expected hash', () async {
    var mockAccessControlConditions = [
      {
        'conditionType': 'evmBasic',
        'contractAddress': '',
        'standardContractType': '',
        'chain': 'ethereum',
        'method': 'eth_getBalance',
        'parameters': [':userAddress', 'latest'],
        'returnValueTest': {
          'comparator': '>=',
          'value': '0',
        },
      },
    ];

    var result = await hashAccessControlConditions(mockAccessControlConditions);
    expect(result[0], 83);
  });

  test('hashUnifiedCondition should return expected hash', () async {
    var mockUnifiedConditions = [
      {
        'conditionType': 'evmBasic',
        'contractAddress': '',
        'standardContractType': '',
        'chain': 'ethereum',
        'method': 'eth_getBalance',
        'parameters': [':userAddress', 'latest'],
        'returnValueTest': {
          'comparator': '>=',
          'value': '0',
        },
      },
    ];

    var result =
        await hashUnifiedAccessControlConditions(mockUnifiedConditions);
    expect(result[0], 169);
  });
}
