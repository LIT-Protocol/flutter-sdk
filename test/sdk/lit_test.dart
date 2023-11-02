import 'package:flutter_rust_bridge_template/sdk/accs/formatter.types.dart';
import 'package:flutter_rust_bridge_template/sdk/lit.dart';
import 'package:flutter_rust_bridge_template/sdk/lit.types.dart';
import 'package:test/test.dart';

void main() {
  test('encrypt function returns correct values', () async {
    final mockParams = EncryptRequest(
      // Your mock params here, like:
      dataToEncrypt: "Some Data",
      chain: 'ethereum',
      accessControlConditions: [
        CanonicalAccessControlCondition.fromJson({
          'contractAddress': '0x3110c39b428221012934A7F617913b095BC1078C',
          'standardContractType': 'ERC1155',
          'chain': 'ethereum',
          'method': 'balanceOf',
          'parameters': [':userAddress', '9541'],
          'returnValueTest': {'comparator': '>', 'value': '0'}
        }),
      ],
    );

    LitNodeClient litNodeClient = new LitNodeClient();
    await litNodeClient.connect();

    final response = await litNodeClient.encrypt(mockParams);

    // Assert that the response is correctly formed.
    expect(response, 1);

    // Optionally, you can also check the content of the response.
    // Here's an example expecting certain hash values; adjust as needed.
    // expect(response.ciphertext, equals("EXPECTED_CIPHERTEXT_VALUE"));
    // expect(response.dataToEncryptHash, equals("EXPECTED_HASH_VALUE"));
  });
}
