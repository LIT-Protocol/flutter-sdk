#![allow(
    non_camel_case_types,
    unused,
    clippy::redundant_closure,
    clippy::useless_conversion,
    clippy::unit_arg,
    clippy::double_parens,
    non_snake_case,
    clippy::too_many_arguments
)]
// AUTO GENERATED FILE, DO NOT EDIT.
// Generated by `flutter_rust_bridge`@ 1.82.3.

use crate::bls::*;
use core::panic::UnwindSafe;
use flutter_rust_bridge::rust2dart::IntoIntoDart;
use flutter_rust_bridge::*;
use std::ffi::c_void;
use std::sync::Arc;

// Section: imports

// Section: wire functions

fn wire_encrypt_impl(
    port_: MessagePort,
    public_key: impl Wire2Api<String> + UnwindSafe,
    message: impl Wire2Api<String> + UnwindSafe,
    identity: impl Wire2Api<String> + UnwindSafe,
) {
    FLUTTER_RUST_BRIDGE_HANDLER.wrap::<_, _, _, String, _>(
        WrapInfo {
            debug_name: "encrypt",
            port: Some(port_),
            mode: FfiCallMode::Normal,
        },
        move || {
            let api_public_key = public_key.wire2api();
            let api_message = message.wire2api();
            let api_identity = identity.wire2api();
            move |task_callback| encrypt(api_public_key, api_message, api_identity)
        },
    )
}
fn wire_encrypt_time_lock_g2_impl(
    port_: MessagePort,
    public_key: impl Wire2Api<String> + UnwindSafe,
    message: impl Wire2Api<Vec<u8>> + UnwindSafe,
    identity: impl Wire2Api<Vec<u8>> + UnwindSafe,
) {
    FLUTTER_RUST_BRIDGE_HANDLER.wrap::<_, _, _, String, _>(
        WrapInfo {
            debug_name: "encrypt_time_lock_g2",
            port: Some(port_),
            mode: FfiCallMode::Normal,
        },
        move || {
            let api_public_key = public_key.wire2api();
            let api_message = message.wire2api();
            let api_identity = identity.wire2api();
            move |task_callback| encrypt_time_lock_g2(api_public_key, api_message, api_identity)
        },
    )
}
fn wire_encrypt_time_lock_g1_impl(
    port_: MessagePort,
    public_key: impl Wire2Api<String> + UnwindSafe,
    message: impl Wire2Api<Vec<u8>> + UnwindSafe,
    identity: impl Wire2Api<Vec<u8>> + UnwindSafe,
) {
    FLUTTER_RUST_BRIDGE_HANDLER.wrap::<_, _, _, String, _>(
        WrapInfo {
            debug_name: "encrypt_time_lock_g1",
            port: Some(port_),
            mode: FfiCallMode::Normal,
        },
        move || {
            let api_public_key = public_key.wire2api();
            let api_message = message.wire2api();
            let api_identity = identity.wire2api();
            move |task_callback| encrypt_time_lock_g1(api_public_key, api_message, api_identity)
        },
    )
}
fn wire_combine_signature_shares_impl(
    port_: MessagePort,
    shares: impl Wire2Api<Vec<String>> + UnwindSafe,
) {
    FLUTTER_RUST_BRIDGE_HANDLER.wrap::<_, _, _, String, _>(
        WrapInfo {
            debug_name: "combine_signature_shares",
            port: Some(port_),
            mode: FfiCallMode::Normal,
        },
        move || {
            let api_shares = shares.wire2api();
            move |task_callback| combine_signature_shares(api_shares)
        },
    )
}
fn wire_combine_signature_shares_inner_g1_impl(
    port_: MessagePort,
    shares: impl Wire2Api<Vec<String>> + UnwindSafe,
) {
    FLUTTER_RUST_BRIDGE_HANDLER.wrap::<_, _, _, String, _>(
        WrapInfo {
            debug_name: "combine_signature_shares_inner_g1",
            port: Some(port_),
            mode: FfiCallMode::Normal,
        },
        move || {
            let api_shares = shares.wire2api();
            move |task_callback| combine_signature_shares_inner_g1(api_shares)
        },
    )
}
fn wire_combine_signature_shares_inner_g2_impl(
    port_: MessagePort,
    shares: impl Wire2Api<Vec<String>> + UnwindSafe,
) {
    FLUTTER_RUST_BRIDGE_HANDLER.wrap::<_, _, _, String, _>(
        WrapInfo {
            debug_name: "combine_signature_shares_inner_g2",
            port: Some(port_),
            mode: FfiCallMode::Normal,
        },
        move || {
            let api_shares = shares.wire2api();
            move |task_callback| combine_signature_shares_inner_g2(api_shares)
        },
    )
}
fn wire_verify_and_decrypt_with_signature_shares_impl(
    port_: MessagePort,
    public_key: impl Wire2Api<String> + UnwindSafe,
    identity: impl Wire2Api<String> + UnwindSafe,
    ciphertext: impl Wire2Api<String> + UnwindSafe,
    shares: impl Wire2Api<Vec<String>> + UnwindSafe,
) {
    FLUTTER_RUST_BRIDGE_HANDLER.wrap::<_, _, _, String, _>(
        WrapInfo {
            debug_name: "verify_and_decrypt_with_signature_shares",
            port: Some(port_),
            mode: FfiCallMode::Normal,
        },
        move || {
            let api_public_key = public_key.wire2api();
            let api_identity = identity.wire2api();
            let api_ciphertext = ciphertext.wire2api();
            let api_shares = shares.wire2api();
            move |task_callback| {
                verify_and_decrypt_with_signature_shares(
                    api_public_key,
                    api_identity,
                    api_ciphertext,
                    api_shares,
                )
            }
        },
    )
}
fn wire_verify_and_decrypt_g2_impl(
    port_: MessagePort,
    public_key: impl Wire2Api<String> + UnwindSafe,
    identity: impl Wire2Api<Vec<u8>> + UnwindSafe,
    ciphertext: impl Wire2Api<Vec<u8>> + UnwindSafe,
    shares: impl Wire2Api<Vec<String>> + UnwindSafe,
) {
    FLUTTER_RUST_BRIDGE_HANDLER.wrap::<_, _, _, String, _>(
        WrapInfo {
            debug_name: "verify_and_decrypt_g2",
            port: Some(port_),
            mode: FfiCallMode::Normal,
        },
        move || {
            let api_public_key = public_key.wire2api();
            let api_identity = identity.wire2api();
            let api_ciphertext = ciphertext.wire2api();
            let api_shares = shares.wire2api();
            move |task_callback| {
                verify_and_decrypt_g2(api_public_key, api_identity, api_ciphertext, api_shares)
            }
        },
    )
}
fn wire_verify_and_decrypt_g1_impl(
    port_: MessagePort,
    public_key: impl Wire2Api<String> + UnwindSafe,
    identity: impl Wire2Api<Vec<u8>> + UnwindSafe,
    ciphertext: impl Wire2Api<Vec<u8>> + UnwindSafe,
    shares: impl Wire2Api<Vec<String>> + UnwindSafe,
) {
    FLUTTER_RUST_BRIDGE_HANDLER.wrap::<_, _, _, String, _>(
        WrapInfo {
            debug_name: "verify_and_decrypt_g1",
            port: Some(port_),
            mode: FfiCallMode::Normal,
        },
        move || {
            let api_public_key = public_key.wire2api();
            let api_identity = identity.wire2api();
            let api_ciphertext = ciphertext.wire2api();
            let api_shares = shares.wire2api();
            move |task_callback| {
                verify_and_decrypt_g1(api_public_key, api_identity, api_ciphertext, api_shares)
            }
        },
    )
}
fn wire_verify_signature_impl(
    port_: MessagePort,
    public_key: impl Wire2Api<String> + UnwindSafe,
    message: impl Wire2Api<String> + UnwindSafe,
    signature: impl Wire2Api<String> + UnwindSafe,
) {
    FLUTTER_RUST_BRIDGE_HANDLER.wrap::<_, _, _, (), _>(
        WrapInfo {
            debug_name: "verify_signature",
            port: Some(port_),
            mode: FfiCallMode::Normal,
        },
        move || {
            let api_public_key = public_key.wire2api();
            let api_message = message.wire2api();
            let api_signature = signature.wire2api();
            move |task_callback| verify_signature(api_public_key, api_message, api_signature)
        },
    )
}
fn wire_verify_signature_inner_g2_impl(
    port_: MessagePort,
    public_key: impl Wire2Api<String> + UnwindSafe,
    message: impl Wire2Api<Vec<u8>> + UnwindSafe,
    signature: impl Wire2Api<Vec<u8>> + UnwindSafe,
) {
    FLUTTER_RUST_BRIDGE_HANDLER.wrap::<_, _, _, (), _>(
        WrapInfo {
            debug_name: "verify_signature_inner_g2",
            port: Some(port_),
            mode: FfiCallMode::Normal,
        },
        move || {
            let api_public_key = public_key.wire2api();
            let api_message = message.wire2api();
            let api_signature = signature.wire2api();
            move |task_callback| {
                verify_signature_inner_g2(api_public_key, api_message, api_signature)
            }
        },
    )
}
fn wire_verify_signature_inner_g1_impl(
    port_: MessagePort,
    public_key: impl Wire2Api<String> + UnwindSafe,
    message: impl Wire2Api<Vec<u8>> + UnwindSafe,
    signature: impl Wire2Api<Vec<u8>> + UnwindSafe,
) {
    FLUTTER_RUST_BRIDGE_HANDLER.wrap::<_, _, _, (), _>(
        WrapInfo {
            debug_name: "verify_signature_inner_g1",
            port: Some(port_),
            mode: FfiCallMode::Normal,
        },
        move || {
            let api_public_key = public_key.wire2api();
            let api_message = message.wire2api();
            let api_signature = signature.wire2api();
            move |task_callback| {
                verify_signature_inner_g1(api_public_key, api_message, api_signature)
            }
        },
    )
}
fn wire_decrypt_with_signature_shares_impl(
    port_: MessagePort,
    ciphertext: impl Wire2Api<String> + UnwindSafe,
    shares: impl Wire2Api<Vec<String>> + UnwindSafe,
) {
    FLUTTER_RUST_BRIDGE_HANDLER.wrap::<_, _, _, String, _>(
        WrapInfo {
            debug_name: "decrypt_with_signature_shares",
            port: Some(port_),
            mode: FfiCallMode::Normal,
        },
        move || {
            let api_ciphertext = ciphertext.wire2api();
            let api_shares = shares.wire2api();
            move |task_callback| decrypt_with_signature_shares(api_ciphertext, api_shares)
        },
    )
}
fn wire_decrypt_time_lock_g2_impl(
    port_: MessagePort,
    ciphertext: impl Wire2Api<Vec<u8>> + UnwindSafe,
    shares: impl Wire2Api<Vec<String>> + UnwindSafe,
) {
    FLUTTER_RUST_BRIDGE_HANDLER.wrap::<_, _, _, String, _>(
        WrapInfo {
            debug_name: "decrypt_time_lock_g2",
            port: Some(port_),
            mode: FfiCallMode::Normal,
        },
        move || {
            let api_ciphertext = ciphertext.wire2api();
            let api_shares = shares.wire2api();
            move |task_callback| decrypt_time_lock_g2(api_ciphertext, api_shares)
        },
    )
}
fn wire_decrypt_time_lock_g1_impl(
    port_: MessagePort,
    ciphertext: impl Wire2Api<Vec<u8>> + UnwindSafe,
    shares: impl Wire2Api<Vec<String>> + UnwindSafe,
) {
    FLUTTER_RUST_BRIDGE_HANDLER.wrap::<_, _, _, String, _>(
        WrapInfo {
            debug_name: "decrypt_time_lock_g1",
            port: Some(port_),
            mode: FfiCallMode::Normal,
        },
        move || {
            let api_ciphertext = ciphertext.wire2api();
            let api_shares = shares.wire2api();
            move |task_callback| decrypt_time_lock_g1(api_ciphertext, api_shares)
        },
    )
}
// Section: wrapper structs

// Section: static checks

// Section: allocate functions

// Section: related functions

// Section: impl Wire2Api

pub trait Wire2Api<T> {
    fn wire2api(self) -> T;
}

impl<T, S> Wire2Api<Option<T>> for *mut S
where
    *mut S: Wire2Api<T>,
{
    fn wire2api(self) -> Option<T> {
        (!self.is_null()).then(|| self.wire2api())
    }
}

impl Wire2Api<u8> for u8 {
    fn wire2api(self) -> u8 {
        self
    }
}

// Section: impl IntoDart

// Section: executor

support::lazy_static! {
    pub static ref FLUTTER_RUST_BRIDGE_HANDLER: support::DefaultHandler = Default::default();
}

#[cfg(not(target_family = "wasm"))]
#[path = "generated_bls.io.rs"]
mod io;
#[cfg(not(target_family = "wasm"))]
pub use io::*;