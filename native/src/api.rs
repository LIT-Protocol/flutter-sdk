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
        Ok(encrypt_time_lock(public_key, message_bytes, identity_bytes)?)
    } else if public_key_bytes.len() == SIGNATURE_G1_PUBLIC_KEY_HEX_LENGTH / 2 {
        // Similarly, if the byte length matches half of SIGNATURE_G1_PUBLIC_KEY_HEX_LENGTH,
        // then we're using a G1 public key.
        Ok(encrypt_time_lock(public_key, message_bytes, identity_bytes)?)
    } else {
        // If the length doesn't match any of the known constants, return an error indicating the mismatch.
        Err(
            format!(
                "Invalid public key length. Received byte length: {}, expected byte lengths corresponding to 96 or 192 hexits.",
                public_key_bytes.len()
            )
        )
    }
}

pub fn encrypt_time_lock(
    public_key: String,
    message: Vec<u8>,
    identity: Vec<u8>,
) -> Result<String, String> {

    // print the public key
    println!("public_key: {}", public_key);

    let jsonHexStringPublicKey = format!("\"{}\"", public_key);


    let key = serde_json::from_str::<PublicKey<Bls12381G2Impl>>(&jsonHexStringPublicKey)
        .map_err(|_e| "Failed to parse public key as a json hex string".to_string())?;

    key.encrypt_time_lock(SignatureSchemes::ProofOfPossession, message, identity)
        .map_err(|_e| "Unable to encrypt data".to_string())
        .map(|ciphertext| {
            let output = serde_bare::to_vec(&ciphertext).unwrap();
            base64_encode_bytes(&output)
        })
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
    String::from("Brown nose attack Hello from Rust! 🦀")
}

pub fn initialize() {
    std::panic::set_hook(Box::new(console_error_panic_hook::hook));
}
