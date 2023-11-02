import 'package:flutter_rust_bridge_template/sdk/accs/uint8arrays.dart';
import 'package:test/test.dart';

void main() {
  test('UTF8 encode and decode', () {
    var str = 'Hello, world!';
    final encoded = utf8Encode(str);
    final decoded = utf8Decode(encoded);
    expect(decoded, equals(str));
  });

  test('Base64 encode and decode', () {
    var base64Str = 'SGVsbG8gd29ybGQ=';
    final bytes = base64ToUint8Array(base64Str);
    final reEncoded = uint8ArrayToBase64(bytes);
    expect(reEncoded, equals(base64Str));
  });

  test('Uint8Array from string and back for utf8', () {
    var str = 'Hello, world!';
    final bytes = uint8arrayFromString(str, 'utf8');
    final backToStr = uint8arrayToString(bytes, 'utf8');
    expect(backToStr, equals(str));
  });

  test('Uint8Array from string and back for base16', () {
    var hexStr = '48656c6c6f2c20776f726c64';
    final bytes = uint8arrayFromString(hexStr, 'base16');
    final backToStr = uint8arrayToString(bytes, 'base16');
    expect(backToStr, equals(hexStr));
  });

  test('Uint8Array from string and back for base64', () {
    var base64Str = 'SGVsbG8gd29ybGQ=';
    final bytes = uint8arrayFromString(base64Str, 'base64');
    final backToStr = uint8arrayToString(bytes, 'base64');
    expect(backToStr, equals(base64Str));
  });

  test('Uint8Array from string and back for base64url', () {
    var base64UrlStr = 'SGVsbG8gd29ybGQ';
    final bytes = uint8arrayFromString(base64UrlStr, 'base64url');
    final backToStr = uint8arrayToString(bytes, 'base64url');
    expect(backToStr, equals(base64UrlStr));
  });

  test('Base64UrlPad to Base64 and back', () {
    var base64Str = 'SGVsbG8gd29ybGQ=';
    final base64UrlPadStr = 'SGVsbG8gd29ybGQ';
    final backToBase64 = base64UrlPadToBase64(base64UrlPadStr);
    final backToBase64UrlPad = base64ToBase64UrlPad(backToBase64);
    expect(backToBase64, equals(base64Str));
    expect(backToBase64UrlPad, equals(base64UrlPadStr));
  });
}
