extern crate quote;

use quote::quote;
use serde::Deserialize;
use base64_light::{ base64_decode, base64_encode_bytes };
use blsful::inner_types::{ G1Projective, G2Projective, GroupEncoding };
use blsful::{
    Bls12381G1Impl,
    Bls12381G2Impl,
    BlsSignatureImpl,
    PublicKey,
    Signature,
    SignatureSchemes,
    SignatureShare,
    TimeCryptCiphertext,
};
use serde::{ de::DeserializeOwned, Serialize };
use serde_json;
use base64;
use hex;
use std::collections::HashMap;
use std::fmt::format;
use blsful::Pairing;

const SIGNATURE_G2_PUBLIC_KEY_HEX_LENGTH: usize = 96;
const SIGNATURE_G1_PUBLIC_KEY_HEX_LENGTH: usize = 192;
const SIGNATURE_G1_SHARE_HEX_LENGTH: usize = 122;
const SIGNATURE_G2_SHARE_HEX_LENGTH: usize = 218;

// The encrypt function takes three parameters:
// - public_key: Expected data type: String (e.g., "0x1234abcd...")
// - message: Expected data type: String (e.g., "0x5678efgh...")
// - identity: Expected data type: String (e.g., "0x9abcde12...")
// All three parameters are hex-encoded strings, where each byte is represented by two hex characters.
pub fn encrypt(public_key: String, message: String, identity: String) -> Result<String, String> {
    // Decode the hex-encoded public_key string to its byte representation.
    // For example, the hex string "48656c6c6f" would be decoded to the byte array [72, 101, 108, 108, 111].
    // After decoding, the byte array's length will be half the length of the original hex string.
    // This is because each byte is represented by two hex characters in the string.
    let public_key_bytes = hex::decode(&public_key).map_err(|e| e.to_string())?;

    // Similarly, decode the hex-encoded message and identity strings.
    let message_bytes = hex::decode(&message).map_err(|e| e.to_string())?;
    let identity_bytes = hex::decode(&identity).map_err(|e| e.to_string())?;

    // Check the length of the decoded public_key_bytes against known constants.
    if public_key_bytes.len() == SIGNATURE_G2_PUBLIC_KEY_HEX_LENGTH / 2 {
        // If the byte length matches half of SIGNATURE_G2_PUBLIC_KEY_HEX_LENGTH,
        // then we're using a G2 public key.
        Ok(encrypt_time_lock_g2(public_key, message_bytes, identity_bytes)?)
    } else if public_key_bytes.len() == SIGNATURE_G1_PUBLIC_KEY_HEX_LENGTH / 2 {
        // Similarly, if the byte length matches half of SIGNATURE_G1_PUBLIC_KEY_HEX_LENGTH,
        // then we're using a G1 public key.
        Ok(encrypt_time_lock_g1(public_key, message_bytes, identity_bytes)?)
    } else {
        // If the length doesn't match any of the known constants, return an error indicating the mismatch.
        Err(
            format!(
                "🚨 Invalid public key length. Received byte length: {}, expected byte lengths corresponding to 96 or 192 hexits.",
                public_key_bytes.len()
            )
        )
    }
}

// The encrypt_time_lock function takes three parameters:
// - public_key: Expected data type: String (e.g., "0x1234abcd...")
// - message: Expected data type: Vec<u8> (e.g., vec![72, 101, 108, 108, 111])
// - identity: Expected data type: Vec<u8> (e.g., vec![9, 10, 11, 12])
// All three parameters are used to encrypt a message with a time lock using the provided public key and identity.
pub fn encrypt_time_lock_g2(
    public_key: String,
    message: Vec<u8>,
    identity: Vec<u8>
) -> Result<String, String> {
    // Convert the public key from a hex string to a PublicKey object.
    // For example, the hex string "0x1234abcd" would be converted to a PublicKey object.
    // After conversion, the PublicKey object can be used for cryptographic operations.
    // This is because the PublicKey object represents the public key in a format that the cryptographic library can understand.
    let json_hex_string_public_key = format!("\"{}\"", public_key);

    let key = serde_json
        ::from_str::<PublicKey<Bls12381G2Impl>>(&json_hex_string_public_key)
        .map_err(|_e| "🚨 Failed to parse public key as a json hex string".to_string())?;

    // Encrypt the message with a time lock using the provided public key and identity.
    // If the encryption is successful, the encrypted data is returned as a base64-encoded string.
    // If the encryption fails, an error message is returned.
    key.encrypt_time_lock(SignatureSchemes::ProofOfPossession, message, identity)
        .map_err(|_e| "🚨 Unable to encrypt data".to_string())
        .map(|ciphertext| {
            let output = serde_bare::to_vec(&ciphertext).unwrap();
            base64_encode_bytes(&output)
        })
}

pub fn encrypt_time_lock_g1(
    public_key: String,
    message: Vec<u8>,
    identity: Vec<u8>
) -> Result<String, String> {
    let json_hex_string_public_key = format!("\"{}\"", public_key);

    let key = serde_json
        ::from_str::<PublicKey<Bls12381G1Impl>>(&json_hex_string_public_key)
        .map_err(|_e| "🚨 Failed to parse public key as a json hex string".to_string())?;

    key.encrypt_time_lock(SignatureSchemes::ProofOfPossession, message, identity)
        .map_err(|_e| "🚨 Unable to encrypt data".to_string())
        .map(|ciphertext| {
            let output = serde_bare::to_vec(&ciphertext).unwrap();
            base64_encode_bytes(&output)
        })
}

// The combine_signature_shares function is designed to take a vector of signature shares
// and combine them into a single signature. The function first checks if there are enough
// shares to form a valid signature. Next, it checks the length of the shares to determine
// which signature scheme (G1 or G2) is being used. Finally, it calls the appropriate helper
// function to combine the shares and return the combined signature.
// shares example:[{"ProofOfPossession":"01b2b44a0bf7184f19efacad98e213818edd3f8909dd798129ef169b877d68d77ba630005609f48b80203717d82092a45b06a9de0e61a97b2672b38b31f9ae43e64383d0375a51c75db8972613cc6b099b95c189fd8549ed973ee94b08749f4cac"}, {"ProofOfPossession":"02a8343d5602f523286c4c59356fdcfc51953290495d98cb91a56b59bd1a837ea969cc521382164e85787128ce7f944de303d8e0b5fc4becede0c894bec1adc490fdc133939cca70fb3f504b9bf7b156527b681d9f0619828cd8050c819e46fdb1"}, {"ProofOfPossession":"03b1594ab0cb56f47437b3720dc181661481ca0e36078b79c9a4acc50042f076bf66b68fbd12a1d55021a668555f0eed0a08dfe74455f557b30f1a9c32435a81479ca8843f5b74b176a8d10c5845a84213441eaaaf2ba57e32581584393541c5aa"}]
pub fn combine_signature_shares(shares: Vec<String>) -> Result<String, String> {
    // Ensure that there are enough shares to create a valid signature.
    if shares.len() < 2 {
        return Err("🚨 At least two shares are required".to_string());
    }

    // Determine the signature scheme based on the length of the shares. (expecting either 122 or 218)
    // The length also includes the "ProofOfPossession" field, hence the constants are used.
    if shares[0].len() == SIGNATURE_G1_SHARE_HEX_LENGTH {
        return combine_signature_shares_inner_g1(shares);
    } else if shares[0].len() == SIGNATURE_G2_SHARE_HEX_LENGTH {
        return combine_signature_shares_inner_g2(shares);
    } else {
        return Err(format!("🚨 Invalid shares. Received {}.", shares[0].len()));
    }
}

// The combine_signature_shares_inner_g1 function is a helper function designed for the G1 signature scheme.
// It iterates through each share, extracts the "ProofOfPossession" value, and then creates a signature share object.
// After processing all shares, it combines them into a single signature and encodes the result as a hexadecimal string.
pub fn combine_signature_shares_inner_g1(shares: Vec<String>) -> Result<String, String> {
    // Ensure that some shares are provided.
    if shares.len() == 0 {
        return Err("🚨 No shares provided".to_string());
    }

    let mut signature_shares: Vec<SignatureShare<Bls12381G1Impl>> = Vec::with_capacity(
        shares.len()
    );

    // Iterate over each share to create the signature share objects.
    for share in shares {
        let parsed_json: serde_json::Value = serde_json
            ::from_str(&share)
            .map_err(|_e| format!("🚨 Failed to parse shares, received {}", share))?;

        let inner_share: <Bls12381G1Impl as Pairing>::SignatureShare = serde_json
            ::from_str(parsed_json["ProofOfPossession"].to_string().as_str())
            .map_err(|_e| format!("🚨 Failed to deserialize possession string: {}", _e))?;
        signature_shares.push(SignatureShare::ProofOfPossession(inner_share));
    }

    let signatures = Signature::from_shares(&signature_shares[..]).map_err(|_e|
        format!("🚨 Failed to combine signature shares: {}", _e)
    )?;

    let raw_value_bytes = signatures.as_raw_value().to_bytes();
    let hex_encoded = hex::encode(raw_value_bytes);

    return Ok(hex_encoded);
}

// The combine_signature_shares_inner_g2 function is similar to its G1 counterpart but is designed for the G2 signature scheme.
// It follows a similar logic: iterating through each share, extracting the "ProofOfPossession", and creating a signature share object.
// Finally, it combines the signature shares and encodes the result as a hexadecimal string.
pub fn combine_signature_shares_inner_g2(shares: Vec<String>) -> Result<String, String> {
    if shares.len() == 0 {
        return Err("🚨 No shares provided".to_string());
    }

    let mut signature_shares: Vec<SignatureShare<Bls12381G2Impl>> = Vec::with_capacity(
        shares.len()
    );

    for share in shares {
        let parsed_json: serde_json::Value = serde_json
            ::from_str(&share)
            .map_err(|_e| format!("🚨 Failed to parse shares, received {}", share))?;

        let inner_share: <Bls12381G2Impl as Pairing>::SignatureShare = serde_json
            ::from_str(parsed_json["ProofOfPossession"].to_string().as_str())
            .map_err(|_e| format!("🚨 Failed to deserialize possession string: {}", _e))?;
        signature_shares.push(SignatureShare::ProofOfPossession(inner_share));
    }

    let signatures = Signature::from_shares(&signature_shares[..]).map_err(|_e|
        format!("🚨 Failed to combine signature shares: {}", _e)
    )?;

    let raw_value_bytes = signatures.as_raw_value().to_bytes();
    let hex_encoded = hex::encode(raw_value_bytes);

    return Ok(hex_encoded);
}

// The verify and decrypt function takes four parameters:
// - public_key: Expected data type: String (e.g., "0x1234abcd...")
// - identity: Expected data type: String (e.g., "0x9abcde12...")
// - ciphertext: Expected data type: String (e.g., "0x5678efgh...")
// - shares: Expected data type [{"ProofOfPossession":"01b2b44a0bf7184f19efacad98e213818edd3f8909dd798129ef169b877d68d77ba630005609f48b80203717d82092a45b06a9de0e61a97b2672b38b31f9ae43e64383d0375a51c75db8972613cc6b099b95c189fd8549ed973ee94b08749f4cac"}, {"ProofOfPossession":"02a8343d5602f523286c4c59356fdcfc51953290495d98cb91a56b59bd1a837ea969cc521382164e85787128ce7f944de303d8e0b5fc4becede0c894bec1adc490fdc133939cca70fb3f504b9bf7b156527b681d9f0619828cd8050c819e46fdb1"}, {"ProofOfPossession":"03b1594ab0cb56f47437b3720dc181661481ca0e36078b79c9a4acc50042f076bf66b68fbd12a1d55021a668555f0eed0a08dfe74455f557b30f1a9c32435a81479ca8843f5b74b176a8d10c5845a84213441eaaaf2ba57e32581584393541c5aa"}]
pub fn verify_and_decrypt_with_signature_shares(
    public_key: String,
    identity: String,
    ciphertext: String,
    shares: Vec<String>
) -> Result<String, String> {
    // Ensure that there are enough shares to create a valid signature.
    if shares.len() < 2 {
        return Err("🚨 At least two shares are required".to_string());
    }

    // -- get byte values for each param
    let public_key_bytes = hex::decode(&public_key).map_err(|e| e.to_string())?;
    let identity_bytes = hex::decode(&identity).map_err(|e| e.to_string())?;
    let ciphertext_bytes = base64::decode(&ciphertext).map_err(|e| e.to_string())?;

    if public_key_bytes.len() == SIGNATURE_G2_PUBLIC_KEY_HEX_LENGTH / 2 {
        // If the byte length matches half of SIGNATURE_G2_PUBLIC_KEY_HEX_LENGTH,
        // then we're using a G2 public key.
        return Ok(verify_and_decrypt_g2(public_key, identity_bytes, ciphertext_bytes, shares)?);
    } else if public_key_bytes.len() == SIGNATURE_G1_PUBLIC_KEY_HEX_LENGTH / 2 {
        // Similarly, if the byte length matches half of SIGNATURE_G1_PUBLIC_KEY_HEX_LENGTH,
        // then we're using a G1 public key.
        return Ok(verify_and_decrypt_g1(public_key, identity_bytes, ciphertext_bytes, shares)?);
        // Ok(verify_and_decrypt_with_signature_shares_g1(public_key, identity, ciphertext, shares)?)
    } else {
        // If the length doesn't match any of the known constants, return an error indicating the mismatch.
        return Err(
            format!(
                "🚨 Invalid public key length. Received byte length: {}, expected byte lengths corresponding to 96 or 192 hexits.",
                public_key_bytes.len()
            )
        );
    }
}

pub fn verify_and_decrypt_g2(
    public_key: String,
    identity: Vec<u8>,
    ciphertext: Vec<u8>,
    shares: Vec<String>
) -> Result<String, String> {
    // Convert the public key from a hex string to a PublicKey object.
    // For example, the hex string "0x1234abcd" would be converted to a PublicKey object.
    // After conversion, the PublicKey object can be used for cryptographic operations.
    // This is because the PublicKey object represents the public key in a format that the cryptographic library can understand.
    let json_hex_string_public_key = format!("\"{}\"", public_key);

    let key = serde_json
        ::from_str::<PublicKey<Bls12381G2Impl>>(&json_hex_string_public_key)
        .map_err(|_e| "🚨 Failed to parse public key as a json hex string".to_string())?;

    // NOTE: The following basically works exactly like combine_signature_shares_inner_g2. fix this to reverse the hex_encoded result from combine_signature_shares_inner_g2 back to SignatureShare<Bls12381G2Impl>
    // -- start combining shares
    if shares.len() == 0 {
        return Err("🚨 No shares provided".to_string());
    }

    let mut signature_shares: Vec<SignatureShare<Bls12381G2Impl>> = Vec::with_capacity(
        shares.len()
    );

    for share in shares {
        let parsed_json: serde_json::Value = serde_json
            ::from_str(&share)
            .map_err(|_e| format!("🚨 Failed to parse shares, received {}", share))?;

        let inner_share: <Bls12381G2Impl as Pairing>::SignatureShare = serde_json
            ::from_str(parsed_json["ProofOfPossession"].to_string().as_str())
            .map_err(|_e| format!("🚨 Failed to deserialize possession string: {}", _e))?;
        signature_shares.push(SignatureShare::ProofOfPossession(inner_share));
    }

    let signatures = Signature::from_shares(&signature_shares[..]).map_err(|_e|
        format!("🚨 Failed to combine signature shares: {}", _e)
    )?;
    // -- end combining shares

    signatures.verify(&key, identity).map_err(|_e| "🚨 Failed to verify signature".to_string())?;

    let ciphertext = serde_bare
        ::from_slice::<TimeCryptCiphertext<Bls12381G2Impl>>(&ciphertext)
        .map_err(|_e| format!("🚨 Failed to hex decode ciphertext: {}", _e))?;

    Option::<Vec<u8>>
        ::from(ciphertext.decrypt(&signatures))
        .map(|c| base64_encode_bytes(&c))
        .ok_or_else(|| "🚨 Failed to decrypt".to_string())
}

pub fn verify_and_decrypt_g1(
    public_key: String,
    identity: Vec<u8>,
    ciphertext: Vec<u8>,
    shares: Vec<String>
) -> Result<String, String> {
    // Convert the public key from a hex string to a PublicKey object.
    // For example, the hex string "0x1234abcd" would be converted to a PublicKey object.
    // After conversion, the PublicKey object can be used for cryptographic operations.
    // This is because the PublicKey object represents the public key in a format that the cryptographic library can understand.
    let json_hex_string_public_key = format!("\"{}\"", public_key);

    let key = serde_json
        ::from_str::<PublicKey<Bls12381G1Impl>>(&json_hex_string_public_key)
        .map_err(|_e| "🚨 Failed to parse public key as a json hex string".to_string())?;

    // NOTE: The following basically works exactly like combine_signature_shares_inner_g2. fix this to reverse the hex_encoded result from combine_signature_shares_inner_g2 back to SignatureShare<Bls12381G2Impl>
    // -- start combining shares
    if shares.len() == 0 {
        return Err("🚨 No shares provided".to_string());
    }

    let mut signature_shares: Vec<SignatureShare<Bls12381G1Impl>> = Vec::with_capacity(
        shares.len()
    );

    for share in shares {
        let parsed_json: serde_json::Value = serde_json
            ::from_str(&share)
            .map_err(|_e| format!("🚨 Failed to parse shares, received {}", share))?;

        let inner_share: <Bls12381G1Impl as Pairing>::SignatureShare = serde_json
            ::from_str(parsed_json["ProofOfPossession"].to_string().as_str())
            .map_err(|_e| format!("🚨 Failed to deserialize possession string: {}", _e))?;
        signature_shares.push(SignatureShare::ProofOfPossession(inner_share));
    }

    let signatures = Signature::from_shares(&signature_shares[..]).map_err(|_e|
        format!("🚨 Failed to combine signature shares: {}", _e)
    )?;
    // -- end combining shares

    signatures.verify(&key, identity).map_err(|_e| "🚨 Failed to verify signature".to_string())?;

    let ciphertext = serde_bare
        ::from_slice::<TimeCryptCiphertext<Bls12381G1Impl>>(&ciphertext)
        .map_err(|_e| format!("🚨 Failed to hex decode ciphertext: {}", _e))?;

    Option::<Vec<u8>>
        ::from(ciphertext.decrypt(&signatures))
        .map(|c| base64_encode_bytes(&c))
        .ok_or_else(|| "🚨 Failed to decrypt".to_string())
}

pub fn verify_signature(
    public_key: String,
    message: String, // base64 expected
    signature: String // base64 expected
) -> Result<(), String> {
    // Decode the hex-encoded public_key string to its byte representation.
    // For example, the hex string "48656c6c6f" would be decoded to the byte array [72, 101, 108, 108, 111].
    // After decoding, the byte array's length will be half the length of the original hex string.
    // This is because each byte is represented by two hex characters in the string.
    let public_key_bytes = hex::decode(&public_key).map_err(|e| e.to_string())?;
    let message_bytes = base64_decode(&message);
    let signature_bytes = base64_decode(&signature);

    if public_key_bytes.len() == SIGNATURE_G2_PUBLIC_KEY_HEX_LENGTH / 2 {
        return verify_signature_inner_g2(public_key, message_bytes, signature_bytes);
    } else if public_key_bytes.len() == SIGNATURE_G1_PUBLIC_KEY_HEX_LENGTH / 2 {
        return verify_signature_inner_g1(public_key, message_bytes, signature_bytes);
    } else {
        return Err(
            format!(
                "🚨 Invalid public key length. Received byte length: {}, expected byte lengths corresponding to 96 or 192 hexits.",
                public_key_bytes.len()
            )
        );
    }
}

pub fn verify_signature_inner_g2(
    public_key: String,
    message: Vec<u8>,
    signature: Vec<u8>
) -> Result<(), String> {
    // Convert the public key from a hex string to a PublicKey object.
    // For example, the hex string "0x1234abcd" would be converted to a PublicKey object.
    // After conversion, the PublicKey object can be used for cryptographic operations.
    // This is because the PublicKey object represents the public key in a format that the cryptographic library can understand.
    let json_hex_string_public_key = format!("\"{}\"", public_key);

    let key = serde_json
        ::from_str::<PublicKey<Bls12381G2Impl>>(&json_hex_string_public_key)
        .map_err(|_e| "🚨 Failed to parse public key as a json hex string".to_string())?;

    // The compressed signature of 96 bytes.
    let g2_projective = G2Projective::from_compressed(
        &signature.try_into().map_err(|_e| "Failed to cast to compressed byte slice".to_string())?
    ).unwrap();

    let signature: Signature<Bls12381G2Impl> = Signature::ProofOfPossession(g2_projective);

    signature.verify(&key, message).map_err(|_e| "Failed to verify signature".to_string())?;

    Ok(())
}

pub fn verify_signature_inner_g1(
    public_key: String,
    message: Vec<u8>,
    signature: Vec<u8>
) -> Result<(), String> {
    // Convert the public key from a hex string to a PublicKey object.
    // For example, the hex string "0x1234abcd" would be converted to a PublicKey object.
    // After conversion, the PublicKey object can be used for cryptographic operations.
    // This is because the PublicKey object represents the public key in a format that the cryptographic library can understand.
    let json_hex_string_public_key = format!("\"{}\"", public_key);

    let key = serde_json
        ::from_str::<PublicKey<Bls12381G1Impl>>(&json_hex_string_public_key)
        .map_err(|_e| "🚨 Failed to parse public key as a json hex string".to_string())?;

    // The compressed signature of 48 bytes.
    let g1_projective = G1Projective::from_compressed(
        &signature.try_into().map_err(|_e| "Failed to cast to compressed byte slice".to_string())?
    ).unwrap();
    let signature: Signature<Bls12381G1Impl> = Signature::ProofOfPossession(g1_projective);

    signature.verify(&key, message).map_err(|_e| "Failed to verify signature".to_string())?;

    Ok(())
}

pub enum Platform {
    Unknown,
    Android,
    Ios,
    Windows,
    Unix,
    MacIntel,
    MacApple,
    Wasm,
}

pub fn platform() -> Platform {
    if cfg!(windows) {
        Platform::Windows
    } else if cfg!(target_os = "android") {
        Platform::Android
    } else if cfg!(target_os = "ios") {
        Platform::Ios
    } else if cfg!(all(target_os = "macos", target_arch = "aarch64")) {
        Platform::MacApple
    } else if cfg!(target_os = "macos") {
        Platform::MacIntel
    } else if cfg!(target_family = "wasm") {
        Platform::Wasm
    } else if cfg!(unix) {
        Platform::Unix
    } else {
        Platform::Unknown
    }
}

pub fn rust_release_mode() -> bool {
    cfg!(not(debug_assertions))
}

pub fn hello_world() -> String {
    String::from("Hello from Rust! 🦀")
}
