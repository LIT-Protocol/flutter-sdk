import 'dart:convert';
import 'dart:typed_data';

// 1. UTF8 Encode
Uint8List utf8Encode(String str) {
  return Uint8List.fromList(utf8.encode(str));
}

// 2. UTF8 Decode
String utf8Decode(Uint8List bytes) {
  return utf8.decode(bytes);
}

// 3. Base64 to Uint8Array
Uint8List base64ToUint8Array(String base64Str) {
  return base64Decode(base64Str);
}

// 4. Uint8Array to Base64
String uint8ArrayToBase64(Uint8List bytes) {
  return base64Encode(bytes);
}

// 5. base64UrlPadToBase64
String base64UrlPadToBase64(String str) {
  return str.replaceAll('-', '+').replaceAll('_', '/') +
      '=' * ((4 - str.length % 4) % 4);
}

// 6. base64ToBase64UrlPad
String base64ToBase64UrlPad(String str) {
  return str.replaceAll('+', '-').replaceAll('/', '_').replaceAll('=', '');
}

// 7. uint8arrayFromString
Uint8List uint8arrayFromString(dynamic str, [String encoding = 'utf8']) {
  switch (encoding) {
    case 'utf8':
      return utf8Encode(str);
    case 'base16':
      return Uint8List.fromList(List<int>.generate(str.length ~/ 2,
          (i) => int.parse(str.substring(i * 2, i * 2 + 2), radix: 16)));
    case 'base64':
      return base64ToUint8Array(str);
    case 'base64url':
    case 'base64urlpad':
      return base64ToUint8Array(base64UrlPadToBase64(str));
    default:
      throw UnsupportedError('Unsupported encoding $encoding');
  }
}

// 8. uint8arrayToString
String uint8arrayToString(Uint8List bytes, [String encoding = 'utf8']) {
  switch (encoding) {
    case 'utf8':
      return utf8Decode(bytes);
    case 'base16':
      return bytes.map((byte) => byte.toRadixString(16).padLeft(2, '0')).join();
    case 'base64':
      return uint8ArrayToBase64(bytes);
    case 'base64url':
    case 'base64urlpad':
      return base64ToBase64UrlPad(uint8ArrayToBase64(bytes));
    default:
      throw UnsupportedError('Unsupported encoding $encoding');
  }
}

String uint8ListToHex(Uint8List data) {
  return data.map((byte) => byte.toRadixString(16).padLeft(2, '0')).join('');
}
