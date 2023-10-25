use super::*;
// Section: wire functions

#[no_mangle]
pub extern "C" fn wire_encrypt(
    port_: i64,
    public_key: *mut wire_uint_8_list,
    message: *mut wire_uint_8_list,
    identity: *mut wire_uint_8_list,
) {
    wire_encrypt_impl(port_, public_key, message, identity)
}

#[no_mangle]
pub extern "C" fn wire_encrypt_time_lock(
    port_: i64,
    public_key: *mut wire_uint_8_list,
    message: *mut wire_uint_8_list,
    identity: *mut wire_uint_8_list,
) {
    wire_encrypt_time_lock_impl(port_, public_key, message, identity)
}

#[no_mangle]
pub extern "C" fn wire_combine_signature_shares(port_: i64, shares: *mut wire_StringList) {
    wire_combine_signature_shares_impl(port_, shares)
}

#[no_mangle]
pub extern "C" fn wire_combine_signature_shares_inner_g1(port_: i64, shares: *mut wire_StringList) {
    wire_combine_signature_shares_inner_g1_impl(port_, shares)
}

#[no_mangle]
pub extern "C" fn wire_combine_signature_shares_inner_g2(port_: i64, shares: *mut wire_StringList) {
    wire_combine_signature_shares_inner_g2_impl(port_, shares)
}

#[no_mangle]
pub extern "C" fn wire_platform(port_: i64) {
    wire_platform_impl(port_)
}

#[no_mangle]
pub extern "C" fn wire_rust_release_mode(port_: i64) {
    wire_rust_release_mode_impl(port_)
}

#[no_mangle]
pub extern "C" fn wire_hello_world(port_: i64) {
    wire_hello_world_impl(port_)
}

#[no_mangle]
pub extern "C" fn wire_initialize(port_: i64) {
    wire_initialize_impl(port_)
}

// Section: allocate functions

#[no_mangle]
pub extern "C" fn new_StringList_0(len: i32) -> *mut wire_StringList {
    let wrap = wire_StringList {
        ptr: support::new_leak_vec_ptr(<*mut wire_uint_8_list>::new_with_null_ptr(), len),
        len,
    };
    support::new_leak_box_ptr(wrap)
}

#[no_mangle]
pub extern "C" fn new_uint_8_list_0(len: i32) -> *mut wire_uint_8_list {
    let ans = wire_uint_8_list {
        ptr: support::new_leak_vec_ptr(Default::default(), len),
        len,
    };
    support::new_leak_box_ptr(ans)
}

// Section: related functions

// Section: impl Wire2Api

impl Wire2Api<String> for *mut wire_uint_8_list {
    fn wire2api(self) -> String {
        let vec: Vec<u8> = self.wire2api();
        String::from_utf8_lossy(&vec).into_owned()
    }
}
impl Wire2Api<Vec<String>> for *mut wire_StringList {
    fn wire2api(self) -> Vec<String> {
        let vec = unsafe {
            let wrap = support::box_from_leak_ptr(self);
            support::vec_from_leak_ptr(wrap.ptr, wrap.len)
        };
        vec.into_iter().map(Wire2Api::wire2api).collect()
    }
}

impl Wire2Api<Vec<u8>> for *mut wire_uint_8_list {
    fn wire2api(self) -> Vec<u8> {
        unsafe {
            let wrap = support::box_from_leak_ptr(self);
            support::vec_from_leak_ptr(wrap.ptr, wrap.len)
        }
    }
}
// Section: wire structs

#[repr(C)]
#[derive(Clone)]
pub struct wire_StringList {
    ptr: *mut *mut wire_uint_8_list,
    len: i32,
}

#[repr(C)]
#[derive(Clone)]
pub struct wire_uint_8_list {
    ptr: *mut u8,
    len: i32,
}

// Section: impl NewWithNullPtr

pub trait NewWithNullPtr {
    fn new_with_null_ptr() -> Self;
}

impl<T> NewWithNullPtr for *mut T {
    fn new_with_null_ptr() -> Self {
        std::ptr::null_mut()
    }
}

// Section: sync execution mode utility

#[no_mangle]
pub extern "C" fn free_WireSyncReturn(ptr: support::WireSyncReturn) {
    unsafe {
        let _ = support::box_from_leak_ptr(ptr);
    };
}
