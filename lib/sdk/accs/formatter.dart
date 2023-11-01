import 'package:flutter_rust_bridge_template/sdk/accs/formatter.types.dart';

List<Map<String, dynamic>> canonicalAbiParams(
    List<Map<String, dynamic>> params) {
  return params
      .map((param) => {
            'name': param['name'],
            'type': param['type'],
          })
      .toList();
}

/// Formats the given Ethereum Virtual Machine (EVM) contract condition into a canonical form.
///
/// The function takes a dynamic input `cond` which can be a Map or a List.
/// If it's a List, the function will recurse into each element.
///
/// - For 'operator' key, it returns a map containing just the 'operator'.
/// - For 'returnValueTest' key, it validates and organizes the information into a canonical form.
///
/// @param cond A dynamic type that holds the condition to be formatted.
/// @returns A `CanonicalCondition?` object containing the canonical form of the condition.
canonicalEVMContractConditionFormatter(dynamic cond) {
  if (cond is List && cond.isNotEmpty) {
    return cond.map(canonicalEVMContractConditionFormatter).toList();
  }

  if (cond is Map) {
    if (cond.containsKey('operator')) {
      return {"operator": cond['operator']};
    }

    if (cond.containsKey('returnValueTest')) {
      final functionAbi = cond['functionAbi'] ?? {};
      final returnValueTest = cond['returnValueTest'] ?? {};

      if (functionAbi.isEmpty || returnValueTest.isEmpty) {
        throw Exception('Missing functionAbi or returnValueTest');
      }

      final functionName = functionAbi['name'] ?? '';
      if (functionName.isEmpty) {
        throw Exception(
            'Function name cannot be empty in functionAbi["name"], your functionAbi: $functionAbi');
      }

      var result = {
        "contractAddress": cond['contractAddress'],
        "functionName": functionName,
        "functionParams": cond['functionParams'],
        "functionAbi": {
          'name': functionName,
          'inputs': canonicalAbiParams(functionAbi['inputs'] ?? []),
          'outputs': canonicalAbiParams(functionAbi['outputs'] ?? []),
          'constant': functionAbi['constant'] ?? false,
          'stateMutability': functionAbi['stateMutability'] ?? '',
        },
        "chain": cond['chain'],
        "returnValueTest": {
          'key': returnValueTest['key'],
          'comparator': returnValueTest['comparator'],
          'value': returnValueTest['value'],
        },
      };

      return result;
    }
  }
  return null;
}

dynamic canonicalAccessControlConditionFormatter(dynamic cond) {
  // If it's a List
  if (cond is List && cond.isNotEmpty) {
    return cond.map(canonicalAccessControlConditionFormatter).toList();
  }

  // If there's an 'operator' key in the Map
  if (cond is Map && cond.containsKey('operator')) {
    return {"operator": cond['operator']};
  }

  // If there's a 'returnValueTest' key in the Map
  if (cond is Map && cond.containsKey('returnValueTest')) {
    return {
      'contractAddress': cond['contractAddress'],
      'chain': cond['chain'],
      'standardContractType': cond['standardContractType'],
      'method': cond['method'],
      'parameters': cond['parameters'],
      'returnValueTest': {
        'comparator': cond['returnValueTest']['comparator'],
        'value': cond['returnValueTest']['value'],
      },
    };
  }

  // Throw an error for invalid condition
  throw Exception('You passed an invalid access control condition: $cond');
}

dynamic canonicalUnifiedAccessControlConditionFormatter(dynamic cond) {
  // If it's a list, map each element
  if (cond is List && cond.isNotEmpty) {
    return cond.map(canonicalUnifiedAccessControlConditionFormatter).toList();
  }

  // If there's an 'operator' key in the map
  if (cond is Map && cond.containsKey('operator')) {
    return {"operator": cond['operator']};
  }

  // Otherwise, check for 'returnValueTest'
  if (cond is Map && cond.containsKey('returnValueTest')) {
    final conditionType = cond['conditionType'];

    switch (conditionType) {
      case 'evmBasic':
        return canonicalAccessControlConditionFormatter(cond);
      case 'evmContract':
        if ((cond['functionName'] == null || cond['functionName'] == '')) {
          throw Exception('x Function name cannot be emsspty');
        }

        return canonicalEVMContractConditionFormatter(cond);
      // TODO: feature/0.0.2
      // case 'solRpc':
      //   return canonicalSolRpcConditionFormatter(cond, true);
      // case 'cosmos':
      //   return canonicalCosmosConditionFormatter(cond);
      default:
        throw Exception(
            'You passed an invalid access control condition that is missing or has a wrong "conditionType": ${cond.toString()}');
    }
  }

  throw Exception(
      'You passed an invalid access control condition: ${cond.toString()}');
}
