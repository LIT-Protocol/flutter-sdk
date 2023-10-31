import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'dart:typed_data';
import 'package:convert/convert.dart';
import 'package:flutter_rust_bridge_template/sdk/helper.dart';
import 'package:flutter_rust_bridge_template/sdk/lit.dart';
import './native.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: '🧪 Manual Tests | Lit Flutter SDK'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

extension<L, R> on (FutureOr<L>, FutureOr<R>) {
  // A convenience method enabled by Dart 3, which will be useful later.
  Future<(L, R)> join() async {
    final fut =
        await Future.wait([Future.value(this.$1), Future.value(this.$2)]);
    return (fut[0] as L, fut[1] as R);
  }
}

class LitButton extends StatefulWidget {
  final String buttonText;
  final Future<dynamic> Function() callback;

  LitButton({required this.buttonText, required this.callback});

  @override
  _LitButtonState createState() => _LitButtonState();
}

class _LitButtonState extends State<LitButton> {
  String result = 'Press button to run function';

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: () async {
            var data = await widget.callback();
            if (data == null) {
              data = "Error or null value returned from function";
            }
            setState(() {
              result = data;
            });

            setState(() {
              result = data;
            });
            print('Result from function: $data');
          },
          child: Text(widget.buttonText),
        ),
        Text(result),
      ],
    );
  }
}

class _MyHomePageState extends State<MyHomePage> {
  // These futures belong to the state and are only initialized once,
  // in the initState method.
  // late Future<Platform> platform;
  // late Future<bool> isRelease;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Text("SDK",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              Container(margin: const EdgeInsets.only(top: 6)),
              LitButton(
                buttonText: "Connect to Lit Nodes",
                callback: () async {
                  LitNodeClient litNodeClient = new LitNodeClient();
                  bool connected = await litNodeClient.connect();
                  return "connected: $connected";
                },
              ),
              LitButton(
                buttonText: "Connect to Lit Nodes",
                callback: () async {
                  LitNodeClient litNodeClient = new LitNodeClient();
                  bool connected = await litNodeClient.connect();
                  return "connected: $connected";
                },
              ),
              Container(margin: const EdgeInsets.only(top: 24)),
              Text("BLS-SDK",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              Container(margin: const EdgeInsets.only(top: 6)),
              LitButton(
                buttonText: "encrypt",
                callback: () async {
                  const publicKey =
                      '8e29447d7b0666fe41c357dbbdbdac0ac8ac973f88439a07f85fa31fa6fa3cea87c2eaa8b367e1c97764800fb5636892';
                  final secretMessage = Uint8List.fromList([
                    240,
                    23,
                    185,
                    6,
                    87,
                    33,
                    173,
                    216,
                    53,
                    84,
                    80,
                    135,
                    190,
                    16,
                    58,
                    85,
                    97,
                    75,
                    3,
                    192,
                    215,
                    82,
                    217,
                    5,
                    40,
                    65,
                    2,
                    214,
                    40,
                    177,
                    53,
                    150,
                  ]);

                  // String = "encrypt_decrypt_works"
                  final identityParam = Uint8List.fromList([
                    101,
                    110,
                    99,
                    114,
                    121,
                    112,
                    116,
                    95,
                    100,
                    101,
                    99,
                    114,
                    121,
                    112,
                    116,
                    95,
                    119,
                    111,
                    114,
                    107,
                    115,
                  ]);

                  String encodedMessage = hex.encode(secretMessage);
                  String encodedIdentity = hex.encode(identityParam);
                  var data = await bls.encrypt(
                      publicKey: publicKey,
                      message: encodedMessage,
                      identity: encodedIdentity);
                  return data;
                },
              ),
              LitButton(
                  buttonText: "combineSignatureShares",
                  callback: () async {
                    final signatureShares = [
                      '01b2b44a0bf7184f19efacad98e213818edd3f8909dd798129ef169b877d68d77ba630005609f48b80203717d82092a45b06a9de0e61a97b2672b38b31f9ae43e64383d0375a51c75db8972613cc6b099b95c189fd8549ed973ee94b08749f4cac',
                      '02a8343d5602f523286c4c59356fdcfc51953290495d98cb91a56b59bd1a837ea969cc521382164e85787128ce7f944de303d8e0b5fc4becede0c894bec1adc490fdc133939cca70fb3f504b9bf7b156527b681d9f0619828cd8050c819e46fdb1',
                      '03b1594ab0cb56f47437b3720dc181661481ca0e36078b79c9a4acc50042f076bf66b68fbd12a1d55021a668555f0eed0a08dfe74455f557b30f1a9c32435a81479ca8843f5b74b176a8d10c5845a84213441eaaaf2ba57e32581584393541c5aa',
                    ].map((s) => '{"ProofOfPossession":"$s"}').toList();

                    print("\n---------- 🦋 Flutter Frontend ----------\n");
                    print("signatureShares: $signatureShares");

                    print("\n---------- 🦀 RUST Backend ----------\n");
                    var data = await bls.combineSignatureShares(
                        shares: signatureShares);
                    print("Rust returned data: $data");

                    // -- assert
                    const expectedResult =
                        '911bf01a53576c53cf7667e32ef76799711f881a72d8894aa6a7186b5189e0345065a29e5dda5a19571b63ada860b03d07125369bfd902280599052475959f34a937f1075ef1acfb8baff9b8a22fc8b0d0655ad7b6e2860117029ebc98e47898';

                    if (expectedResult == data) {
                      print("✅ SUCCESS, data matches expected result");
                    } else {
                      print("❌ FAILED, expected: $expectedResult, got: $data");
                    }
                    return data;
                  }),
              LitButton(
                buttonText: "verifyAndDecryptWithSignatureShares",
                callback: () async {
                  const publicKey =
                      '8e29447d7b0666fe41c357dbbdbdac0ac8ac973f88439a07f85fa31fa6fa3cea87c2eaa8b367e1c97764800fb5636892';

                  // -- original data
                  final secretMessage = Uint8List.fromList([
                    240,
                    23,
                    185,
                    6,
                    87,
                    33,
                    173,
                    216,
                    53,
                    84,
                    80,
                    135,
                    190,
                    16,
                    58,
                    85,
                    97,
                    75,
                    3,
                    192,
                    215,
                    82,
                    217,
                    5,
                    40,
                    65,
                    2,
                    214,
                    40,
                    177,
                    53,
                    150,
                  ]);

                  // -- This is copied from the output of the encrypt function
                  const ciphertext =
                      'jxRc7vOr+ubf/Z1fAOr0VXT2veeqE+r90eLPpnrxnV5VcrjnhHxKXfM92nAAGBQ/5KU5BH5NpBjfozjAECBzd2ncD9qe48lnVo8pBoE5evwhfDtxv/CI4U0UR8eXlsvywxjiUbNVja9vzwvD+r7IGli7Aw==';

                  final signatureShares = [
                    '01b2b44a0bf7184f19efacad98e213818edd3f8909dd798129ef169b877d68d77ba630005609f48b80203717d82092a45b06a9de0e61a97b2672b38b31f9ae43e64383d0375a51c75db8972613cc6b099b95c189fd8549ed973ee94b08749f4cac',
                    '02a8343d5602f523286c4c59356fdcfc51953290495d98cb91a56b59bd1a837ea969cc521382164e85787128ce7f944de303d8e0b5fc4becede0c894bec1adc490fdc133939cca70fb3f504b9bf7b156527b681d9f0619828cd8050c819e46fdb1',
                    '03b1594ab0cb56f47437b3720dc181661481ca0e36078b79c9a4acc50042f076bf66b68fbd12a1d55021a668555f0eed0a08dfe74455f557b30f1a9c32435a81479ca8843f5b74b176a8d10c5845a84213441eaaaf2ba57e32581584393541c5aa',
                  ].map((s) => '{"ProofOfPossession":"$s"}').toList();

                  // String = "encrypt_decrypt_works"
                  final identityParam = Uint8List.fromList([
                    101,
                    110,
                    99,
                    114,
                    121,
                    112,
                    116,
                    95,
                    100,
                    101,
                    99,
                    114,
                    121,
                    112,
                    116,
                    95,
                    119,
                    111,
                    114,
                    107,
                    115,
                  ]);

                  print("\n---------- 🦀 RUST Backend ----------\n");

                  String encodedIdentity = hex.encode(identityParam);

                  var decryptedBase64Data =
                      await bls.verifyAndDecryptWithSignatureShares(
                          publicKey: publicKey,
                          identity: encodedIdentity,
                          ciphertext: ciphertext,
                          shares: signatureShares);

                  // -- assert
                  print("Rust returned (base64): $decryptedBase64Data");
                  var decryptedUint8ArrayData =
                      base64Decode(decryptedBase64Data);

                  var expectedBase64Encoded = base64Encode(secretMessage);
                  ;
                  print("Expected (base64): $expectedBase64Encoded");

                  if (expectedBase64Encoded == decryptedBase64Data) {
                    print("✅ SUCCESS, data matches expected result");
                  } else {
                    print(
                        "❌ FAILED, expected: $expectedBase64Encoded, got: $decryptedBase64Data");
                  }

                  return decryptedBase64Data;
                },
              ),
              LitButton(
                  buttonText: "verifySignature",
                  callback: () async {
                    const publicKey =
                        'ad1bd6c66f849ccbcc20fa08c26108f3df7db0068df032cc184779cc967159da4dd5669de563af7252b540f0759aee5a';

                    // base64 str
                    const message =
                        'ZXlKaGJHY2lPaUpDVEZNeE1pMHpPREVpTENKMGVYQWlPaUpLVjFRaWZRLmV5SnBjM01pT2lKTVNWUWlMQ0p6ZFdJaU9pSXdlRFF5TlRsbE5EUTJOekF3TlRNME9URmxOMkkwWm1VMFlURXlNR00zTUdKbE1XVmhaRFkwTm1JaUxDSmphR0ZwYmlJNkltVjBhR1Z5WlhWdElpd2lhV0YwSWpveE5qZzNOVFl5TWpjMUxDSmxlSEFpT2pFMk9EYzJNRFUwTnpVc0ltRmpZMlZ6YzBOdmJuUnliMnhEYjI1a2FYUnBiMjV6SWpwYmV5SmpiMjUwY21GamRFRmtaSEpsYzNNaU9pSWlMQ0pqYUdGcGJpSTZJbVYwYUdWeVpYVnRJaXdpYzNSaGJtUmhjbVJEYjI1MGNtRmpkRlI1Y0dVaU9pSWlMQ0p0WlhSb2IyUWlPaUlpTENKd1lYSmhiV1YwWlhKeklqcGJJanAxYzJWeVFXUmtjbVZ6Y3lKZExDSnlaWFIxY201V1lXeDFaVlJsYzNRaU9uc2lZMjl0Y0dGeVlYUnZjaUk2SWowaUxDSjJZV3gxWlNJNklqQjROREkxT1VVME5EWTNNREExTXpRNU1VVTNZalJHUlRSQk1USXdRemN3WW1VeFpVRkVOalEyWWlKOWZWMHNJbVYyYlVOdmJuUnlZV04wUTI5dVpHbDBhVzl1Y3lJNmJuVnNiQ3dpYzI5c1VuQmpRMjl1WkdsMGFXOXVjeUk2Ym5Wc2JDd2lkVzVwWm1sbFpFRmpZMlZ6YzBOdmJuUnliMnhEYjI1a2FYUnBiMjV6SWpwdWRXeHNmUQ==';

                    // base64 str
                    const signature =
                        'trkIFY8XLxWAHvErjc5sEMfyEMjDVW0m4zSEiO8Ladb+F2vsaUmBMPIR4axyHdayDJ7/qdxUsxM1Xt/AUMcYRCVbUqNZZmkAGtOFGODAjieGdv9Q3aPnsrQXkDzW0ITP';

                    print("\n---------- 🦀 RUST Backend ----------\n");
                    try {
                      await bls.verifySignature(
                          publicKey: publicKey,
                          message: message,
                          signature: signature);
                      print("✅ SUCCESS, signature is valid");
                      return "✅ SUCCESS, signature is valid";
                    } catch (e) {
                      print("❌ FAILED, signature is invalid");
                      return "❌ FAILED, signature is invalid";
                    }
                  }),
              LitButton(
                buttonText: "decryptWithSignatureShares",
                callback: () async {
                  // -- original data
                  final secretMessage = Uint8List.fromList([
                    240,
                    23,
                    185,
                    6,
                    87,
                    33,
                    173,
                    216,
                    53,
                    84,
                    80,
                    135,
                    190,
                    16,
                    58,
                    85,
                    97,
                    75,
                    3,
                    192,
                    215,
                    82,
                    217,
                    5,
                    40,
                    65,
                    2,
                    214,
                    40,
                    177,
                    53,
                    150,
                  ]);

                  // -- This is copied from the output of the encrypt function
                  const ciphertext =
                      'jxRc7vOr+ubf/Z1fAOr0VXT2veeqE+r90eLPpnrxnV5VcrjnhHxKXfM92nAAGBQ/5KU5BH5NpBjfozjAECBzd2ncD9qe48lnVo8pBoE5evwhfDtxv/CI4U0UR8eXlsvywxjiUbNVja9vzwvD+r7IGli7Aw==';

                  final signatureShares = [
                    '01b2b44a0bf7184f19efacad98e213818edd3f8909dd798129ef169b877d68d77ba630005609f48b80203717d82092a45b06a9de0e61a97b2672b38b31f9ae43e64383d0375a51c75db8972613cc6b099b95c189fd8549ed973ee94b08749f4cac',
                    '02a8343d5602f523286c4c59356fdcfc51953290495d98cb91a56b59bd1a837ea969cc521382164e85787128ce7f944de303d8e0b5fc4becede0c894bec1adc490fdc133939cca70fb3f504b9bf7b156527b681d9f0619828cd8050c819e46fdb1',
                    '03b1594ab0cb56f47437b3720dc181661481ca0e36078b79c9a4acc50042f076bf66b68fbd12a1d55021a668555f0eed0a08dfe74455f557b30f1a9c32435a81479ca8843f5b74b176a8d10c5845a84213441eaaaf2ba57e32581584393541c5aa',
                  ].map((s) => '{"ProofOfPossession":"$s"}').toList();

                  print("\n---------- 🦀 RUST Backend ----------\n");
                  var data = await bls.decryptWithSignatureShares(
                      ciphertext: ciphertext, shares: signatureShares);

                  // -- assert
                  var expectedBase64Encoded = base64Encode(secretMessage);
                  ;
                  print("Expected (base64): $expectedBase64Encoded");

                  if (expectedBase64Encoded == data) {
                    print("✅ SUCCESS, data matches expected result");
                    return "✅ SUCCESS, data matches expected result";
                  } else {
                    print(
                        "❌ FAILED, expected: $expectedBase64Encoded, got: $data");
                  }
                },
              ),
              Container(margin: const EdgeInsets.only(top: 24)),
              Text("ECDSA-SDK",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              Container(margin: const EdgeInsets.only(top: 6)),
              LitButton(
                  buttonText: "combineSignature",
                  callback: () async {
                    List<Map<String, dynamic>> shares = [
                      {
                        "sig_type": 'ECDSA_CAIT_SITH',
                        "signature_share":
                            'FEFC58B0E9399B0D1DDAA3AAC084757B0A49D0980C42A5B340C70CB9C36579B0',
                        "share_index": 0,
                        "big_r":
                            '0331654A77AD671F40E5B59AF11F4D78355869973C089AA2846966A024D804AEFC',
                        "public_key":
                            '0473DB2CF6ECEB4E308EFC0B35597C1135B95F5E167445190D2D43CE9E5B6E7C88849422AE5895F0B4C436B3789E292E3C18B30648E9442868B21E088248F28E77',
                        "data_signed":
                            '7D87C5EA75F7378BB701E404C50639161AF3EFF66293E9F375B5F17EB50476F4',
                        "sig_name": 'sig'
                      },
                      {
                        "sig_type": 'ECDSA_CAIT_SITH',
                        "signature_share":
                            '41343580C056A85CD856AF4FB3735AF5A4FB7DF4EEF34286B3F80D305B78F5E4',
                        "share_index": 0,
                        "big_r":
                            '0331654A77AD671F40E5B59AF11F4D78355869973C089AA2846966A024D804AEFC',
                        "public_key":
                            '0473DB2CF6ECEB4E308EFC0B35597C1135B95F5E167445190D2D43CE9E5B6E7C88849422AE5895F0B4C436B3789E292E3C18B30648E9442868B21E088248F28E77',
                        "data_signed":
                            '7D87C5EA75F7378BB701E404C50639161AF3EFF66293E9F375B5F17EB50476F4',
                        "sig_name": 'sig'
                      }
                    ];

                    List<String> sharesString =
                        shares.map((e) => jsonEncode(e)).toList();

                    try {
                      var data = await ecdsa.combineSignature(
                          inShares: sharesString, keyType: 2);

                      if (data == 'Could not deserialize value') {
                        print("❌ FAILED, Could not deserialize value");
                        return "❌ FAILED, Could not deserialize value";
                      }

                      print("✅ SUCCESS, shares combined ${data.toString()}");
                      return data;
                    } catch (e) {
                      print("❌ FAILED, signature is invalid ${e.toString()}");
                      return "❌ FAILED, signature is invalid ${e.toString()}";
                    }
                  }),
              LitButton(
                buttonText: "computePublicKey",
                callback: () async {
                  const id =
                      "d856c933322bb32c0f055522c68fc8ffd7bed30c41fffd4e2c4562c28894a7c0";
                  const publicKeys = [
                    "040416ff2418dbd58b05a99b7b8fa0f090d6c24ecc6964fef4239ef151db163f024b7da356854844c1b46556ed5ffcb4f8f11a169bbf33121aa18e29dc76b99843",
                    "04504f9e8ddaf44a34e0aaed868b938cc1e7d5c3d3e1576581cd81650f5efa63c7694da0503f00711f347e62e06e78bf68674d75a668ca5a3c0f63422ed0869117",
                    "04dcb77cea0bed0f619423254369228ff4f8b858a83eda1292183783cf376b4e43803dac382c56b84679789726734da92c54091c4cbcc4aebe83d9d0114ebe9c30",
                    "040c50ac90bfd40319ec55d249298be693125991a5fd5007e44ab110fd79ec4f4c0b66051b85934a778059af2e091b9f291643510bc8889a1ea6e61f2766114b96",
                    "0466c80a363c8888611a3e2c5af737693aae7150462b1d3a9efeb45c3704233f3427200762d2aa06810553e5d3495e3d84803eac2555078cefc34abb5007b63e9e",
                    "04988e9d83be771461988fe8f6d787102e139547086fbf316f81e97d688e5da5983ad24260a1d730d288cd4281826ddb50ba053be513fbf1776593856b2b142b44",
                    "0412c6bb58d88f64b922c7460214029feaaa4a0190234636f483c44d8135e99c65683f9a989a376b34ba61a496c2b8581f2ad7f9c22ece3b9405663798cb76eae2",
                    "04bf4b5de0b17b4855bdc65a7594f16a2fc3fb2df837f63fb750e1bde06e6016df338207e922b0ca27f84525dc92190b3d912ce655289929618dd2933bc71ad7a6",
                    "04d037c42f8d4bbf7d3aad9fdf92bcbb3e6fd1fef723ddee50668123b2464381701faf86fbba8742a272f319ea0781af5093d02da153f8f09546e2a921a30482e1",
                    "0443c902f5aa2a845bc11caa0f69bb74ee06a9ebabbb0ce4473616987045296ec621c36351bf6e4075bea08fdbbbe93e6de071768f8df9f6452cf54e15109a4aee",
                  ];

                  try {
                    var data = await ecdsa.computePublicKey(
                        id: id, publicKeys: publicKeys);
                    print("✅ SUCCESS, public key computed ${data.toString()}");
                    return data;
                  } catch (e) {
                    print("❌ FAILED, signature is invalid ${e.toString()}");
                    return "❌ FAILED, signature is invalid ${e.toString()}";
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
