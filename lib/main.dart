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
            // const Text("You're running on"),
            LitButton(
              buttonText: 'Run HelloWorld',
              callback: api.helloWorld,
            ),
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
            )
          ],
        ),
      ),
    );
  }
}
