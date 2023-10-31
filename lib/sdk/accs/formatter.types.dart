class CanonicalCondition {
  final dynamic operator;
  final String? contractAddress;
  final String? functionName;
  final dynamic? functionParams;
  final dynamic? functionAbi;
  final String? chain;
  final dynamic? returnValueTest;

  CanonicalCondition({
    this.operator,
    this.contractAddress,
    this.functionName,
    this.functionParams,
    this.functionAbi,
    this.chain,
    this.returnValueTest,
  });
}
