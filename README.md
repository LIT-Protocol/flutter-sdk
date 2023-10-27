# 🦋 Lit Flutter SDK

![](https://im5.ezgif.com/tmp/ezgif-5-f02a3b99ba.gif)

# Prerequisite

## Simulator
Open iPhone simulator

```
open -a simulator
```

## Real devices

### IOS Setup

iOS requires some additional Rust targets for cross-compilation ([read more]((https://web.archive.org/web/20230408050003/https://cjycode.com/flutter_rust_bridge/template/setup_ios.html)))

```
# 64 bit targets (real device & simulator):
rustup target add aarch64-apple-ios x86_64-apple-ios
# New simulator target for Xcode 12 and later
rustup target add aarch64-apple-ios-sim
# 32 bit targets (you probably don't need these):
rustup target add armv7-apple-ios i386-apple-ios
```

# Getting Started

```
./gen-bindings.sh && flutter run
```

# BLS-SDK Flutter API

> Note: Do not append `0x` to hex values.

| Method                                | Parameters                                                                                                                                                                                                                                                                                                                                                      | Returns                                             |
| ------------------------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | --------------------------------------------------- |
| `encrypt`                             | - `publicKey`: String (Hex) Example: "1234abcd..."<br>- `message`: String (Hex) Example: "5678efgh..."<br>- `identity`: String (Hex) Example: "9abcde12..."                                                                                                                                                                                                     | Future<String>: Encrypted data in Base64 format     |
| `combineSignatureShares`              | - `shares`: List<String> (JSON-like Strings) Example: [ "{\"ProofOfPossession\":\"01b2b4...\"}", "{\"ProofOfPossession\":\"02a834...\"}", "{\"ProofOfPossession\":\"03b159...\"}" ]                                                                                                                                                                             | Future<String>: Combined signature in Base64 format |
| `verifyAndDecryptWithSignatureShares` | - `publicKey`: String (Hex) Example: "1234abcd..."<br>- `identity`: String (Hex) Example: "9abcde12..."<br>- `ciphertext`: String (Base64) Example: "encrypted_base64=="<br>- `shares`: List<String> (JSON-like Strings) Example: [ "{\"ProofOfPossession\":\"01b2b4...\"}", "{\"ProofOfPossession\":\"02a834...\"}", "{\"ProofOfPossession\":\"03b159...\"}" ] | Future<String>: Decrypted data as Base64 string     |
| `decryptWithSignatureShares`          | - `ciphertext`: String (Base64) Example: "encrypted_base64=="<br>- `shares`: List<String> (JSON-like Strings) Example: [ "{\"ProofOfPossession\":\"01b2b4...\"}", "{\"ProofOfPossession\":\"02a834...\"}", "{\"ProofOfPossession\":\"03b159...\"}" ]                                                                                                            | Future<String>: Decrypted data as Base64 string     |
| `verifySignature`                     | - `publicKey`: String (Hex) Example: "1234abcd..."<br>- `message`: String (Base64) Example: "bWVzc2FnZQ=="<br>- `signature`: String (Base64) Example: "signature_base64=="                                                                                                                                                                                      | Future<bool>: Verification result (true or false)   |

# ECDSA Flutter API

> Note: Do not append `0x` to hex values.

| Method             | Parameters                                                                                           | Returns                                              |
| ------------------ | ---------------------------------------------------------------------------------------------------- | ---------------------------------------------------- |
| `combineSignature` | - `inShares`: List<String> (JSON-encoded share objects)<br>- `keyType`: int (Supported values: 2, 3) | Future<String>: Combined signature or error message  |
| `computePublicKey` | - `id`: String (Hex)<br>- `publicKeys`: List<String> (Hex-encoded public keys)                       | Future<String>: Computed public key or error message |