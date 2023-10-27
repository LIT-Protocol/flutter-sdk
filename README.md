# 🦋 Lit Flutter SDK

![](https://im5.ezgif.com/tmp/ezgif-5-f02a3b99ba.gif)

# Prerequisite

Open iPhone simulator

```
open -a simulator
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