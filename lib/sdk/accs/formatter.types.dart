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
}
