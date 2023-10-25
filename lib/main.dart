import 'dart:async';
import 'package:flutter/material.dart';
import 'ffi.dart' if (dart.library.html) 'ffi_web.dart';
import 'dart:typed_data';

String byteArrayToHex(Uint8List byteArray) {
  return byteArray.map((byte) {
    return byte.toRadixString(16).padLeft(2, '0');
  }).join('');
}

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
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
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
  late Future<Platform> platform;
  late Future<bool> isRelease;

  @override
  void initState() {
    super.initState();
    platform = api.platform();
    isRelease = api.rustReleaseMode();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text("BLS-SDK Manual Tests"),
            // LitButton(
            //   buttonText: 'Run HelloWorld',
            //   callback: api.helloWorld,
            // ),
            LitButton(
              buttonText: "encrypt",
              callback: () async {

                  const publicKey = '8e29447d7b0666fe41c357dbbdbdac0ac8ac973f88439a07f85fa31fa6fa3cea87c2eaa8b367e1c97764800fb5636892';
                  final secretMessage = Uint8List.fromList([
                    240, 23, 185, 6, 87, 33, 173, 216, 53, 84, 80, 135, 190, 16, 58, 85, 97, 75,
                    3, 192, 215, 82, 217, 5, 40, 65, 2, 214, 40, 177, 53, 150,
                  ]);
                  final identityParam = Uint8List.fromList([
                    101, 110, 99, 114, 121, 112, 116, 95, 100, 101, 99, 114, 121, 112, 116, 95,
                    119, 111, 114, 107, 115,
                  ]);

                  String encodedMessage = byteArrayToHex(secretMessage);
                  String encodedIdentity = byteArrayToHex(identityParam);

                  var data = await api.encrypt(
                    publicKey: publicKey, 
                    message: encodedMessage, 
                    identity: encodedIdentity
                  );
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
                var data = await api.combineSignatureShares(shares: signatureShares);
                print("Rust returned data: $data");

                const expectedResult = '911bf01a53576c53cf7667e32ef76799711f881a72d8894aa6a7186b5189e0345065a29e5dda5a19571b63ada860b03d07125369bfd902280599052475959f34a937f1075ef1acfb8baff9b8a22fc8b0d0655ad7b6e2860117029ebc98e47898';

                if(expectedResult == data){
                  print("✅ SUCCESS, data matches expected result");
                } else {
                  print("❌ FAILED, expected: $expectedResult, got: $data");
                }
                return data;
              }
            ),
          ],
        ),
      ),
    );
  }
}
