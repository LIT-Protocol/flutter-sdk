import 'package:flutter_rust_bridge_template/sdk/helper.dart';
import 'package:test/test.dart';
import 'dart:convert';
import 'dart:typed_data';

void main() {
  group('toUint8List tests', () {
    test('Converts String to Uint8List', () {
      final result = toUint8List("Hello");
      expect(result, isA<Uint8List>());
      expect(result, equals(Uint8List.fromList(utf8.encode("Hello"))));
    });

    test('Converts int to Uint8List', () {
      final result = toUint8List(12345);
      final buffer = Uint8List(4)..buffer.asByteData().setInt32(0, 12345);
      expect(result, isA<Uint8List>());
      expect(result, equals(buffer));
    });

    test('Converts double to Uint8List', () {
      var data = 45.67;
      final result = toUint8List(data);
      final buffer = Uint8List(8)..buffer.asByteData().setFloat64(0, data);
      expect(result, isA<Uint8List>());
      expect(result, equals(buffer));
    });

    test('Converts List<int> to Uint8List', () {
      final data = [72, 101, 108, 108, 111];
      final result = toUint8List(data);
      expect(result, isA<Uint8List>());
      expect(result, equals(Uint8List.fromList(data)));
    });

    test('Throws for unsupported data types', () {
      expect(() => toUint8List(true), throwsA(isA<ArgumentError>()));
      expect(
          () => toUint8List({'key': 'value'}), throwsA(isA<ArgumentError>()));
      expect(() => toUint8List([1.2, 3.4]), throwsA(isA<ArgumentError>()));
    });
  });

  group('getHashedAccessControlConditions tests', () {
    test('Throws error for unsupported keys', () async {
      var params = {'unsupportedKey': 'someValue'};

      expect(() async => await getHashedAccessControlConditions(params),
          throwsA(isA<Exception>()));
    });

    test(
        'getHashedAccessControlConditions with valid keyType "accessControlConditions"',
        () async {
      var params = {
        'accessControlConditions': [
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
        ]
      };

      var result = await getHashedAccessControlConditions(params);
      expect(result[0], 83);
    });

    test(
        'getHashedAccessControlConditions with valid keyType "evmContractConditions"',
        () async {
      var params = {
        'evmContractConditions': [
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
        ]
      };

      var result = await getHashedAccessControlConditions(params);
      expect(result[0], 198);
    });

    test(
        'getHashedAccessControlConditions with valid keyType "unifiedAccessControlConditions"',
        () async {
      var params = {
        'unifiedAccessControlConditions': [
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
        ]
      };

      var result = await getHashedAccessControlConditions(params);
      expect(result[0], 169); // Based on the previously provided mock result
    });
  });
}
