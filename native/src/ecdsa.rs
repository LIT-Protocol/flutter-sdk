use std::collections::HashSet;
use serde_json::Value;
use k256::Secp256k1;

// ==================== ECDSA SDK ====================
pub fn combine_signature(in_shares: Vec<String>, key_type: u8) -> Result<String, String> {
    let required_keys: HashSet<&str> = [
        "sig_type",
        "signature_share",
        "share_index",
        "big_r",
        "public_key",
        "data_signed",
        "sig_name",
    ]
        .iter()
        .cloned()
        .collect();

    let supported_keys = [2, 3];

    if !supported_keys.contains(&key_type) {
        return Err(
            format!(
                "🚨 Unsupported key type: {}. Supported keys are: {:?}",
                key_type,
                supported_keys
            )
        );
    }

    let mut shares: Vec<String> = Vec::with_capacity(in_shares.len());

    for share in in_shares {
        let parsed_json: serde_json::Value = serde_json
            ::from_str(&share)
            .map_err(|_e| format!("🚨 Failed to parse shares, received {}", share))?;

        // -- check if there are missing keys. The idea is that "missing keys" starts with all required keys
        // and we remove the ones that are present in the JSON object. If there are any keys left, then
        // we know that the JSON object is missing some keys.
        let mut missing_keys = required_keys.clone();
        if let Value::Object(map) = &parsed_json {
            for key in map.keys() {
                missing_keys.remove(key.as_str());
            }
        }

        if !missing_keys.is_empty() {
            return Err(format!("🚨 Missing keys: {:?}", missing_keys));
        }

        // -- push the share
        shares.push(share);
    }

    if key_type == 2 {
        return Ok(lit_ecdsa_wasm_combine::combiners::k256_cait_sith::combine_signature(shares));
    } else if key_type == 3 {
        return Ok(lit_ecdsa_wasm_combine::combiners::p256_cait_sith::combine_signature(shares));
    } else {
        return Err(format!("🚨 Unsupported key type: {}", key_type));
    }
}

pub fn compute_public_key(id: String, public_keys: Vec<String>) -> String {
    use k256::elliptic_curve::sec1::FromEncodedPoint;
    use k256::elliptic_curve::sec1::ToEncodedPoint;

    let mut hd_pub_keys = Vec::with_capacity(public_keys.len() as usize);
    for pubkey in public_keys.iter() {
        let hex_pub_key = hex::decode(pubkey).unwrap();
        let a_p = k256::ProjectivePoint
            ::from_encoded_point(&k256::EncodedPoint::from_bytes(hex_pub_key.as_slice()).unwrap())
            .unwrap();
        hd_pub_keys.push(a_p);
    }
    let deriver = lit_ecdsa_wasm_combine::combiners::hd_ecdsa::HdKeyDeriver::<Secp256k1>
        ::new(id.as_bytes(), lit_ecdsa_wasm_combine::combiners::hd_ecdsa::CXT)
        .unwrap();

    let pubkey = deriver.compute_public_key(&hd_pub_keys.as_slice());
    let pubkey = hex::encode(pubkey.to_encoded_point(false).as_bytes());
    return pubkey;
}
