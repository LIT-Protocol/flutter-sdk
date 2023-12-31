class CanonicalEVMCondition {
  final String? contractAddress;
  final String? functionName;
  final dynamic functionParams;
  final Map<String, dynamic>? functionAbi;
  final String? chain;
  final Map<String, dynamic>? returnValueTest;

  CanonicalEVMCondition({
    this.contractAddress,
    this.functionName,
    this.functionParams,
    this.functionAbi,
    this.chain,
    this.returnValueTest,
  });

  CanonicalEVMCondition.fromJson(Map<String, dynamic> json)
      : contractAddress = json['contractAddress'],
        functionName = json['functionName'],
        functionParams = json['functionParams'],
        functionAbi = json['functionAbi'],
        chain = json['chain'],
        returnValueTest = json['returnValueTest'];

  Map<String, dynamic> toJson(CanonicalEVMCondition canonicalEVMConditions) {
    return {
      'contractAddress': canonicalEVMConditions.contractAddress,
      'functionName': canonicalEVMConditions.functionName,
      'functionParams': canonicalEVMConditions.functionParams,
      'functionAbi': canonicalEVMConditions.functionAbi,
      'chain': canonicalEVMConditions.chain,
      'returnValueTest': canonicalEVMConditions.returnValueTest,
    };
  }

  static List<Map<String, dynamic>> toJsonList(
      List<CanonicalEVMCondition> list) {
    return list.map((item) => item.toJson(item)).toList();
  }
}

class CanonicalAccessControlCondition {
  final String? contractAddress;
  final String? chain;
  final String? standardContractType;
  final String? method;
  final dynamic parameters;
  final Map<String, dynamic>? returnValueTest;

  CanonicalAccessControlCondition({
    this.contractAddress,
    this.chain,
    this.standardContractType,
    this.method,
    this.parameters,
    this.returnValueTest,
  });

  CanonicalAccessControlCondition.fromJson(Map<String, dynamic> json)
      : contractAddress = json['contractAddress'],
        chain = json['chain'],
        standardContractType = json['standardContractType'],
        method = json['method'],
        parameters = json['parameters'],
        returnValueTest = json['returnValueTest'];

  Map<String, dynamic> toJson(
      CanonicalAccessControlCondition canonicalAccessControlConditions) {
    return {
      'contractAddress': canonicalAccessControlConditions.contractAddress,
      'chain': canonicalAccessControlConditions.chain,
      'standardContractType':
          canonicalAccessControlConditions.standardContractType,
      'method': canonicalAccessControlConditions.method,
      'parameters': canonicalAccessControlConditions.parameters,
      'returnValueTest': canonicalAccessControlConditions.returnValueTest,
    };
  }

  static List<Map<String, dynamic>> toJsonList(
      List<CanonicalAccessControlCondition> list) {
    return list.map((item) => item.toJson(item)).toList();
  }
}

class CanonicalUnifiedConditions {
  // Common properties
  final String? operator;
  final String? conditionType;
  // EVM Basic
  final String? contractAddress;
  final String? chain;
  final String? standardContractType;
  final String? method;
  final dynamic parameters;
  // EVM Contract
  final String? functionName;
  final dynamic functionParams;
  final Map<String, dynamic>? functionAbi;
  // Common for both
  final Map<String, dynamic>? returnValueTest;

  CanonicalUnifiedConditions({
    this.operator,
    this.conditionType,
    // EVM Basic
    this.contractAddress,
    this.chain,
    this.standardContractType,
    this.method,
    this.parameters,
    // EVM Contract
    this.functionName,
    this.functionParams,
    this.functionAbi,
    // Common for both
    this.returnValueTest,
  });

  CanonicalUnifiedConditions.fromJson(Map<String, dynamic> json)
      : operator = json['operator'],
        conditionType = json['conditionType'],
        // EVM Basic
        contractAddress = json['contractAddress'],
        chain = json['chain'],
        standardContractType = json['standardContractType'],
        method = json['method'],
        parameters = json['parameters'],
        // EVM Contract
        functionName = json['functionName'],
        functionParams = json['functionParams'],
        functionAbi = json['functionAbi'],
        // Common for both
        returnValueTest = json['returnValueTest'];

  Map<String, dynamic> toJson(
      CanonicalUnifiedConditions canonicalUnifiedConditions) {
    return {
      'operator': canonicalUnifiedConditions.operator,
      'conditionType': canonicalUnifiedConditions.conditionType,
      // EVM Basic
      'contractAddress': canonicalUnifiedConditions.contractAddress,
      'chain': canonicalUnifiedConditions.chain,
      'standardContractType': canonicalUnifiedConditions.standardContractType,
      'method': canonicalUnifiedConditions.method,
      'parameters': canonicalUnifiedConditions.parameters,
      // EVM Contract
      'functionName': canonicalUnifiedConditions.functionName,
      'functionParams': canonicalUnifiedConditions.functionParams,
      'functionAbi': canonicalUnifiedConditions.functionAbi,
      // Common for both
      'returnValueTest': canonicalUnifiedConditions.returnValueTest,
    };
  }

  static List<Map<String, dynamic>> toJsonList(
      List<CanonicalUnifiedConditions> list) {
    return list.map((item) => item.toJson(item)).toList();
  }
}
