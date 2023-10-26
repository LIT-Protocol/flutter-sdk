// AUTO GENERATED FILE, DO NOT EDIT.
// Generated by `flutter_rust_bridge`@ 1.82.3.
// ignore_for_file: non_constant_identifier_names, unused_element, duplicate_ignore, directives_ordering, curly_braces_in_flow_control_structures, unnecessary_lambdas, slash_for_doc_comments, prefer_const_literals_to_create_immutables, implicit_dynamic_list_literal, duplicate_import, unused_import, unnecessary_import, prefer_single_quotes, prefer_const_constructors, use_super_parameters, always_use_package_imports, annotate_overrides, invalid_use_of_protected_member, constant_identifier_names, invalid_use_of_internal_member, prefer_is_empty, unnecessary_const

import "bridge_definitions.dart";
import 'dart:convert';
import 'dart:async';
import 'package:meta/meta.dart';
import 'package:flutter_rust_bridge/flutter_rust_bridge.dart';
import 'package:uuid/uuid.dart';

import 'dart:convert';
import 'dart:async';
import 'package:meta/meta.dart';
import 'package:flutter_rust_bridge/flutter_rust_bridge.dart';
import 'package:uuid/uuid.dart';

import 'dart:ffi' as ffi;

class NativeImpl implements Native {
  final NativePlatform _platform;
  factory NativeImpl(ExternalLibrary dylib) =>
      NativeImpl.raw(NativePlatform(dylib));

  /// Only valid on web/WASM platforms.
  factory NativeImpl.wasm(FutureOr<WasmModule> module) =>
      NativeImpl(module as ExternalLibrary);
  NativeImpl.raw(this._platform);
  Future<String> encrypt(
      {required String publicKey,
      required String message,
      required String identity,
      dynamic hint}) {
    var arg0 = _platform.api2wire_String(publicKey);
    var arg1 = _platform.api2wire_String(message);
    var arg2 = _platform.api2wire_String(identity);
    return _platform.executeNormal(FlutterRustBridgeTask(
      callFfi: (port_) => _platform.inner.wire_encrypt(port_, arg0, arg1, arg2),
      parseSuccessData: _wire2api_String,
      parseErrorData: _wire2api_String,
      constMeta: kEncryptConstMeta,
      argValues: [publicKey, message, identity],
      hint: hint,
    ));
  }

  FlutterRustBridgeTaskConstMeta get kEncryptConstMeta =>
      const FlutterRustBridgeTaskConstMeta(
        debugName: "encrypt",
        argNames: ["publicKey", "message", "identity"],
      );

  Future<String> encryptTimeLockG2(
      {required String publicKey,
      required Uint8List message,
      required Uint8List identity,
      dynamic hint}) {
    var arg0 = _platform.api2wire_String(publicKey);
    var arg1 = _platform.api2wire_uint_8_list(message);
    var arg2 = _platform.api2wire_uint_8_list(identity);
    return _platform.executeNormal(FlutterRustBridgeTask(
      callFfi: (port_) =>
          _platform.inner.wire_encrypt_time_lock_g2(port_, arg0, arg1, arg2),
      parseSuccessData: _wire2api_String,
      parseErrorData: _wire2api_String,
      constMeta: kEncryptTimeLockG2ConstMeta,
      argValues: [publicKey, message, identity],
      hint: hint,
    ));
  }

  FlutterRustBridgeTaskConstMeta get kEncryptTimeLockG2ConstMeta =>
      const FlutterRustBridgeTaskConstMeta(
        debugName: "encrypt_time_lock_g2",
        argNames: ["publicKey", "message", "identity"],
      );

  Future<String> encryptTimeLockG1(
      {required String publicKey,
      required Uint8List message,
      required Uint8List identity,
      dynamic hint}) {
    var arg0 = _platform.api2wire_String(publicKey);
    var arg1 = _platform.api2wire_uint_8_list(message);
    var arg2 = _platform.api2wire_uint_8_list(identity);
    return _platform.executeNormal(FlutterRustBridgeTask(
      callFfi: (port_) =>
          _platform.inner.wire_encrypt_time_lock_g1(port_, arg0, arg1, arg2),
      parseSuccessData: _wire2api_String,
      parseErrorData: _wire2api_String,
      constMeta: kEncryptTimeLockG1ConstMeta,
      argValues: [publicKey, message, identity],
      hint: hint,
    ));
  }

  FlutterRustBridgeTaskConstMeta get kEncryptTimeLockG1ConstMeta =>
      const FlutterRustBridgeTaskConstMeta(
        debugName: "encrypt_time_lock_g1",
        argNames: ["publicKey", "message", "identity"],
      );

  Future<String> combineSignatureShares(
      {required List<String> shares, dynamic hint}) {
    var arg0 = _platform.api2wire_StringList(shares);
    return _platform.executeNormal(FlutterRustBridgeTask(
      callFfi: (port_) =>
          _platform.inner.wire_combine_signature_shares(port_, arg0),
      parseSuccessData: _wire2api_String,
      parseErrorData: _wire2api_String,
      constMeta: kCombineSignatureSharesConstMeta,
      argValues: [shares],
      hint: hint,
    ));
  }

  FlutterRustBridgeTaskConstMeta get kCombineSignatureSharesConstMeta =>
      const FlutterRustBridgeTaskConstMeta(
        debugName: "combine_signature_shares",
        argNames: ["shares"],
      );

  Future<String> combineSignatureSharesInnerG1(
      {required List<String> shares, dynamic hint}) {
    var arg0 = _platform.api2wire_StringList(shares);
    return _platform.executeNormal(FlutterRustBridgeTask(
      callFfi: (port_) =>
          _platform.inner.wire_combine_signature_shares_inner_g1(port_, arg0),
      parseSuccessData: _wire2api_String,
      parseErrorData: _wire2api_String,
      constMeta: kCombineSignatureSharesInnerG1ConstMeta,
      argValues: [shares],
      hint: hint,
    ));
  }

  FlutterRustBridgeTaskConstMeta get kCombineSignatureSharesInnerG1ConstMeta =>
      const FlutterRustBridgeTaskConstMeta(
        debugName: "combine_signature_shares_inner_g1",
        argNames: ["shares"],
      );

  Future<String> combineSignatureSharesInnerG2(
      {required List<String> shares, dynamic hint}) {
    var arg0 = _platform.api2wire_StringList(shares);
    return _platform.executeNormal(FlutterRustBridgeTask(
      callFfi: (port_) =>
          _platform.inner.wire_combine_signature_shares_inner_g2(port_, arg0),
      parseSuccessData: _wire2api_String,
      parseErrorData: _wire2api_String,
      constMeta: kCombineSignatureSharesInnerG2ConstMeta,
      argValues: [shares],
      hint: hint,
    ));
  }

  FlutterRustBridgeTaskConstMeta get kCombineSignatureSharesInnerG2ConstMeta =>
      const FlutterRustBridgeTaskConstMeta(
        debugName: "combine_signature_shares_inner_g2",
        argNames: ["shares"],
      );

  Future<String> verifyAndDecryptWithSignatureShares(
      {required String publicKey,
      required String identity,
      required String ciphertext,
      required List<String> shares,
      dynamic hint}) {
    var arg0 = _platform.api2wire_String(publicKey);
    var arg1 = _platform.api2wire_String(identity);
    var arg2 = _platform.api2wire_String(ciphertext);
    var arg3 = _platform.api2wire_StringList(shares);
    return _platform.executeNormal(FlutterRustBridgeTask(
      callFfi: (port_) => _platform.inner
          .wire_verify_and_decrypt_with_signature_shares(
              port_, arg0, arg1, arg2, arg3),
      parseSuccessData: _wire2api_String,
      parseErrorData: _wire2api_String,
      constMeta: kVerifyAndDecryptWithSignatureSharesConstMeta,
      argValues: [publicKey, identity, ciphertext, shares],
      hint: hint,
    ));
  }

  FlutterRustBridgeTaskConstMeta
      get kVerifyAndDecryptWithSignatureSharesConstMeta =>
          const FlutterRustBridgeTaskConstMeta(
            debugName: "verify_and_decrypt_with_signature_shares",
            argNames: ["publicKey", "identity", "ciphertext", "shares"],
          );

  Future<String> verifyAndDecryptG2(
      {required String publicKey,
      required Uint8List identity,
      required Uint8List ciphertext,
      required List<String> shares,
      dynamic hint}) {
    var arg0 = _platform.api2wire_String(publicKey);
    var arg1 = _platform.api2wire_uint_8_list(identity);
    var arg2 = _platform.api2wire_uint_8_list(ciphertext);
    var arg3 = _platform.api2wire_StringList(shares);
    return _platform.executeNormal(FlutterRustBridgeTask(
      callFfi: (port_) => _platform.inner
          .wire_verify_and_decrypt_g2(port_, arg0, arg1, arg2, arg3),
      parseSuccessData: _wire2api_String,
      parseErrorData: _wire2api_String,
      constMeta: kVerifyAndDecryptG2ConstMeta,
      argValues: [publicKey, identity, ciphertext, shares],
      hint: hint,
    ));
  }

  FlutterRustBridgeTaskConstMeta get kVerifyAndDecryptG2ConstMeta =>
      const FlutterRustBridgeTaskConstMeta(
        debugName: "verify_and_decrypt_g2",
        argNames: ["publicKey", "identity", "ciphertext", "shares"],
      );

  Future<String> verifyAndDecryptG1(
      {required String publicKey,
      required Uint8List identity,
      required Uint8List ciphertext,
      required List<String> shares,
      dynamic hint}) {
    var arg0 = _platform.api2wire_String(publicKey);
    var arg1 = _platform.api2wire_uint_8_list(identity);
    var arg2 = _platform.api2wire_uint_8_list(ciphertext);
    var arg3 = _platform.api2wire_StringList(shares);
    return _platform.executeNormal(FlutterRustBridgeTask(
      callFfi: (port_) => _platform.inner
          .wire_verify_and_decrypt_g1(port_, arg0, arg1, arg2, arg3),
      parseSuccessData: _wire2api_String,
      parseErrorData: _wire2api_String,
      constMeta: kVerifyAndDecryptG1ConstMeta,
      argValues: [publicKey, identity, ciphertext, shares],
      hint: hint,
    ));
  }

  FlutterRustBridgeTaskConstMeta get kVerifyAndDecryptG1ConstMeta =>
      const FlutterRustBridgeTaskConstMeta(
        debugName: "verify_and_decrypt_g1",
        argNames: ["publicKey", "identity", "ciphertext", "shares"],
      );

  Future<Platform> platform({dynamic hint}) {
    return _platform.executeNormal(FlutterRustBridgeTask(
      callFfi: (port_) => _platform.inner.wire_platform(port_),
      parseSuccessData: _wire2api_platform,
      parseErrorData: null,
      constMeta: kPlatformConstMeta,
      argValues: [],
      hint: hint,
    ));
  }

  FlutterRustBridgeTaskConstMeta get kPlatformConstMeta =>
      const FlutterRustBridgeTaskConstMeta(
        debugName: "platform",
        argNames: [],
      );

  Future<bool> rustReleaseMode({dynamic hint}) {
    return _platform.executeNormal(FlutterRustBridgeTask(
      callFfi: (port_) => _platform.inner.wire_rust_release_mode(port_),
      parseSuccessData: _wire2api_bool,
      parseErrorData: null,
      constMeta: kRustReleaseModeConstMeta,
      argValues: [],
      hint: hint,
    ));
  }

  FlutterRustBridgeTaskConstMeta get kRustReleaseModeConstMeta =>
      const FlutterRustBridgeTaskConstMeta(
        debugName: "rust_release_mode",
        argNames: [],
      );

  Future<String> helloWorld({dynamic hint}) {
    return _platform.executeNormal(FlutterRustBridgeTask(
      callFfi: (port_) => _platform.inner.wire_hello_world(port_),
      parseSuccessData: _wire2api_String,
      parseErrorData: null,
      constMeta: kHelloWorldConstMeta,
      argValues: [],
      hint: hint,
    ));
  }

  FlutterRustBridgeTaskConstMeta get kHelloWorldConstMeta =>
      const FlutterRustBridgeTaskConstMeta(
        debugName: "hello_world",
        argNames: [],
      );

  void dispose() {
    _platform.dispose();
  }
// Section: wire2api

  String _wire2api_String(dynamic raw) {
    return raw as String;
  }

  bool _wire2api_bool(dynamic raw) {
    return raw as bool;
  }

  int _wire2api_i32(dynamic raw) {
    return raw as int;
  }

  Platform _wire2api_platform(dynamic raw) {
    return Platform.values[raw as int];
  }

  int _wire2api_u8(dynamic raw) {
    return raw as int;
  }

  Uint8List _wire2api_uint_8_list(dynamic raw) {
    return raw as Uint8List;
  }
}

// Section: api2wire

@protected
int api2wire_u8(int raw) {
  return raw;
}

// Section: finalizer

class NativePlatform extends FlutterRustBridgeBase<NativeWire> {
  NativePlatform(ffi.DynamicLibrary dylib) : super(NativeWire(dylib));

// Section: api2wire

  @protected
  ffi.Pointer<wire_uint_8_list> api2wire_String(String raw) {
    return api2wire_uint_8_list(utf8.encoder.convert(raw));
  }

  @protected
  ffi.Pointer<wire_StringList> api2wire_StringList(List<String> raw) {
    final ans = inner.new_StringList_0(raw.length);
    for (var i = 0; i < raw.length; i++) {
      ans.ref.ptr[i] = api2wire_String(raw[i]);
    }
    return ans;
  }

  @protected
  ffi.Pointer<wire_uint_8_list> api2wire_uint_8_list(Uint8List raw) {
    final ans = inner.new_uint_8_list_0(raw.length);
    ans.ref.ptr.asTypedList(raw.length).setAll(0, raw);
    return ans;
  }
// Section: finalizer

// Section: api_fill_to_wire
}

// ignore_for_file: camel_case_types, non_constant_identifier_names, avoid_positional_boolean_parameters, annotate_overrides, constant_identifier_names

// AUTO GENERATED FILE, DO NOT EDIT.
//
// Generated by `package:ffigen`.
// ignore_for_file: type=lint

/// generated by flutter_rust_bridge
class NativeWire implements FlutterRustBridgeWireBase {
  @internal
  late final dartApi = DartApiDl(init_frb_dart_api_dl);

  /// Holds the symbol lookup function.
  final ffi.Pointer<T> Function<T extends ffi.NativeType>(String symbolName)
      _lookup;

  /// The symbols are looked up in [dynamicLibrary].
  NativeWire(ffi.DynamicLibrary dynamicLibrary)
      : _lookup = dynamicLibrary.lookup;

  /// The symbols are looked up with [lookup].
  NativeWire.fromLookup(
      ffi.Pointer<T> Function<T extends ffi.NativeType>(String symbolName)
          lookup)
      : _lookup = lookup;

  void store_dart_post_cobject(
    DartPostCObjectFnType ptr,
  ) {
    return _store_dart_post_cobject(
      ptr,
    );
  }

  late final _store_dart_post_cobjectPtr =
      _lookup<ffi.NativeFunction<ffi.Void Function(DartPostCObjectFnType)>>(
          'store_dart_post_cobject');
  late final _store_dart_post_cobject = _store_dart_post_cobjectPtr
      .asFunction<void Function(DartPostCObjectFnType)>();

  Object get_dart_object(
    int ptr,
  ) {
    return _get_dart_object(
      ptr,
    );
  }

  late final _get_dart_objectPtr =
      _lookup<ffi.NativeFunction<ffi.Handle Function(ffi.UintPtr)>>(
          'get_dart_object');
  late final _get_dart_object =
      _get_dart_objectPtr.asFunction<Object Function(int)>();

  void drop_dart_object(
    int ptr,
  ) {
    return _drop_dart_object(
      ptr,
    );
  }

  late final _drop_dart_objectPtr =
      _lookup<ffi.NativeFunction<ffi.Void Function(ffi.UintPtr)>>(
          'drop_dart_object');
  late final _drop_dart_object =
      _drop_dart_objectPtr.asFunction<void Function(int)>();

  int new_dart_opaque(
    Object handle,
  ) {
    return _new_dart_opaque(
      handle,
    );
  }

  late final _new_dart_opaquePtr =
      _lookup<ffi.NativeFunction<ffi.UintPtr Function(ffi.Handle)>>(
          'new_dart_opaque');
  late final _new_dart_opaque =
      _new_dart_opaquePtr.asFunction<int Function(Object)>();

  int init_frb_dart_api_dl(
    ffi.Pointer<ffi.Void> obj,
  ) {
    return _init_frb_dart_api_dl(
      obj,
    );
  }

  late final _init_frb_dart_api_dlPtr =
      _lookup<ffi.NativeFunction<ffi.IntPtr Function(ffi.Pointer<ffi.Void>)>>(
          'init_frb_dart_api_dl');
  late final _init_frb_dart_api_dl = _init_frb_dart_api_dlPtr
      .asFunction<int Function(ffi.Pointer<ffi.Void>)>();

  void wire_encrypt(
    int port_,
    ffi.Pointer<wire_uint_8_list> public_key,
    ffi.Pointer<wire_uint_8_list> message,
    ffi.Pointer<wire_uint_8_list> identity,
  ) {
    return _wire_encrypt(
      port_,
      public_key,
      message,
      identity,
    );
  }

  late final _wire_encryptPtr = _lookup<
      ffi.NativeFunction<
          ffi.Void Function(
              ffi.Int64,
              ffi.Pointer<wire_uint_8_list>,
              ffi.Pointer<wire_uint_8_list>,
              ffi.Pointer<wire_uint_8_list>)>>('wire_encrypt');
  late final _wire_encrypt = _wire_encryptPtr.asFunction<
      void Function(int, ffi.Pointer<wire_uint_8_list>,
          ffi.Pointer<wire_uint_8_list>, ffi.Pointer<wire_uint_8_list>)>();

  void wire_encrypt_time_lock_g2(
    int port_,
    ffi.Pointer<wire_uint_8_list> public_key,
    ffi.Pointer<wire_uint_8_list> message,
    ffi.Pointer<wire_uint_8_list> identity,
  ) {
    return _wire_encrypt_time_lock_g2(
      port_,
      public_key,
      message,
      identity,
    );
  }

  late final _wire_encrypt_time_lock_g2Ptr = _lookup<
      ffi.NativeFunction<
          ffi.Void Function(
              ffi.Int64,
              ffi.Pointer<wire_uint_8_list>,
              ffi.Pointer<wire_uint_8_list>,
              ffi.Pointer<wire_uint_8_list>)>>('wire_encrypt_time_lock_g2');
  late final _wire_encrypt_time_lock_g2 =
      _wire_encrypt_time_lock_g2Ptr.asFunction<
          void Function(int, ffi.Pointer<wire_uint_8_list>,
              ffi.Pointer<wire_uint_8_list>, ffi.Pointer<wire_uint_8_list>)>();

  void wire_encrypt_time_lock_g1(
    int port_,
    ffi.Pointer<wire_uint_8_list> public_key,
    ffi.Pointer<wire_uint_8_list> message,
    ffi.Pointer<wire_uint_8_list> identity,
  ) {
    return _wire_encrypt_time_lock_g1(
      port_,
      public_key,
      message,
      identity,
    );
  }

  late final _wire_encrypt_time_lock_g1Ptr = _lookup<
      ffi.NativeFunction<
          ffi.Void Function(
              ffi.Int64,
              ffi.Pointer<wire_uint_8_list>,
              ffi.Pointer<wire_uint_8_list>,
              ffi.Pointer<wire_uint_8_list>)>>('wire_encrypt_time_lock_g1');
  late final _wire_encrypt_time_lock_g1 =
      _wire_encrypt_time_lock_g1Ptr.asFunction<
          void Function(int, ffi.Pointer<wire_uint_8_list>,
              ffi.Pointer<wire_uint_8_list>, ffi.Pointer<wire_uint_8_list>)>();

  void wire_combine_signature_shares(
    int port_,
    ffi.Pointer<wire_StringList> shares,
  ) {
    return _wire_combine_signature_shares(
      port_,
      shares,
    );
  }

  late final _wire_combine_signature_sharesPtr = _lookup<
      ffi.NativeFunction<
          ffi.Void Function(ffi.Int64,
              ffi.Pointer<wire_StringList>)>>('wire_combine_signature_shares');
  late final _wire_combine_signature_shares = _wire_combine_signature_sharesPtr
      .asFunction<void Function(int, ffi.Pointer<wire_StringList>)>();

  void wire_combine_signature_shares_inner_g1(
    int port_,
    ffi.Pointer<wire_StringList> shares,
  ) {
    return _wire_combine_signature_shares_inner_g1(
      port_,
      shares,
    );
  }

  late final _wire_combine_signature_shares_inner_g1Ptr = _lookup<
          ffi.NativeFunction<
              ffi.Void Function(ffi.Int64, ffi.Pointer<wire_StringList>)>>(
      'wire_combine_signature_shares_inner_g1');
  late final _wire_combine_signature_shares_inner_g1 =
      _wire_combine_signature_shares_inner_g1Ptr
          .asFunction<void Function(int, ffi.Pointer<wire_StringList>)>();

  void wire_combine_signature_shares_inner_g2(
    int port_,
    ffi.Pointer<wire_StringList> shares,
  ) {
    return _wire_combine_signature_shares_inner_g2(
      port_,
      shares,
    );
  }

  late final _wire_combine_signature_shares_inner_g2Ptr = _lookup<
          ffi.NativeFunction<
              ffi.Void Function(ffi.Int64, ffi.Pointer<wire_StringList>)>>(
      'wire_combine_signature_shares_inner_g2');
  late final _wire_combine_signature_shares_inner_g2 =
      _wire_combine_signature_shares_inner_g2Ptr
          .asFunction<void Function(int, ffi.Pointer<wire_StringList>)>();

  void wire_verify_and_decrypt_with_signature_shares(
    int port_,
    ffi.Pointer<wire_uint_8_list> public_key,
    ffi.Pointer<wire_uint_8_list> identity,
    ffi.Pointer<wire_uint_8_list> ciphertext,
    ffi.Pointer<wire_StringList> shares,
  ) {
    return _wire_verify_and_decrypt_with_signature_shares(
      port_,
      public_key,
      identity,
      ciphertext,
      shares,
    );
  }

  late final _wire_verify_and_decrypt_with_signature_sharesPtr = _lookup<
          ffi.NativeFunction<
              ffi.Void Function(
                  ffi.Int64,
                  ffi.Pointer<wire_uint_8_list>,
                  ffi.Pointer<wire_uint_8_list>,
                  ffi.Pointer<wire_uint_8_list>,
                  ffi.Pointer<wire_StringList>)>>(
      'wire_verify_and_decrypt_with_signature_shares');
  late final _wire_verify_and_decrypt_with_signature_shares =
      _wire_verify_and_decrypt_with_signature_sharesPtr.asFunction<
          void Function(
              int,
              ffi.Pointer<wire_uint_8_list>,
              ffi.Pointer<wire_uint_8_list>,
              ffi.Pointer<wire_uint_8_list>,
              ffi.Pointer<wire_StringList>)>();

  void wire_verify_and_decrypt_g2(
    int port_,
    ffi.Pointer<wire_uint_8_list> public_key,
    ffi.Pointer<wire_uint_8_list> identity,
    ffi.Pointer<wire_uint_8_list> ciphertext,
    ffi.Pointer<wire_StringList> shares,
  ) {
    return _wire_verify_and_decrypt_g2(
      port_,
      public_key,
      identity,
      ciphertext,
      shares,
    );
  }

  late final _wire_verify_and_decrypt_g2Ptr = _lookup<
      ffi.NativeFunction<
          ffi.Void Function(
              ffi.Int64,
              ffi.Pointer<wire_uint_8_list>,
              ffi.Pointer<wire_uint_8_list>,
              ffi.Pointer<wire_uint_8_list>,
              ffi.Pointer<wire_StringList>)>>('wire_verify_and_decrypt_g2');
  late final _wire_verify_and_decrypt_g2 =
      _wire_verify_and_decrypt_g2Ptr.asFunction<
          void Function(
              int,
              ffi.Pointer<wire_uint_8_list>,
              ffi.Pointer<wire_uint_8_list>,
              ffi.Pointer<wire_uint_8_list>,
              ffi.Pointer<wire_StringList>)>();

  void wire_verify_and_decrypt_g1(
    int port_,
    ffi.Pointer<wire_uint_8_list> public_key,
    ffi.Pointer<wire_uint_8_list> identity,
    ffi.Pointer<wire_uint_8_list> ciphertext,
    ffi.Pointer<wire_StringList> shares,
  ) {
    return _wire_verify_and_decrypt_g1(
      port_,
      public_key,
      identity,
      ciphertext,
      shares,
    );
  }

  late final _wire_verify_and_decrypt_g1Ptr = _lookup<
      ffi.NativeFunction<
          ffi.Void Function(
              ffi.Int64,
              ffi.Pointer<wire_uint_8_list>,
              ffi.Pointer<wire_uint_8_list>,
              ffi.Pointer<wire_uint_8_list>,
              ffi.Pointer<wire_StringList>)>>('wire_verify_and_decrypt_g1');
  late final _wire_verify_and_decrypt_g1 =
      _wire_verify_and_decrypt_g1Ptr.asFunction<
          void Function(
              int,
              ffi.Pointer<wire_uint_8_list>,
              ffi.Pointer<wire_uint_8_list>,
              ffi.Pointer<wire_uint_8_list>,
              ffi.Pointer<wire_StringList>)>();

  void wire_platform(
    int port_,
  ) {
    return _wire_platform(
      port_,
    );
  }

  late final _wire_platformPtr =
      _lookup<ffi.NativeFunction<ffi.Void Function(ffi.Int64)>>(
          'wire_platform');
  late final _wire_platform =
      _wire_platformPtr.asFunction<void Function(int)>();

  void wire_rust_release_mode(
    int port_,
  ) {
    return _wire_rust_release_mode(
      port_,
    );
  }

  late final _wire_rust_release_modePtr =
      _lookup<ffi.NativeFunction<ffi.Void Function(ffi.Int64)>>(
          'wire_rust_release_mode');
  late final _wire_rust_release_mode =
      _wire_rust_release_modePtr.asFunction<void Function(int)>();

  void wire_hello_world(
    int port_,
  ) {
    return _wire_hello_world(
      port_,
    );
  }

  late final _wire_hello_worldPtr =
      _lookup<ffi.NativeFunction<ffi.Void Function(ffi.Int64)>>(
          'wire_hello_world');
  late final _wire_hello_world =
      _wire_hello_worldPtr.asFunction<void Function(int)>();

  ffi.Pointer<wire_StringList> new_StringList_0(
    int len,
  ) {
    return _new_StringList_0(
      len,
    );
  }

  late final _new_StringList_0Ptr = _lookup<
          ffi.NativeFunction<ffi.Pointer<wire_StringList> Function(ffi.Int32)>>(
      'new_StringList_0');
  late final _new_StringList_0 = _new_StringList_0Ptr
      .asFunction<ffi.Pointer<wire_StringList> Function(int)>();

  ffi.Pointer<wire_uint_8_list> new_uint_8_list_0(
    int len,
  ) {
    return _new_uint_8_list_0(
      len,
    );
  }

  late final _new_uint_8_list_0Ptr = _lookup<
          ffi
          .NativeFunction<ffi.Pointer<wire_uint_8_list> Function(ffi.Int32)>>(
      'new_uint_8_list_0');
  late final _new_uint_8_list_0 = _new_uint_8_list_0Ptr
      .asFunction<ffi.Pointer<wire_uint_8_list> Function(int)>();

  void free_WireSyncReturn(
    WireSyncReturn ptr,
  ) {
    return _free_WireSyncReturn(
      ptr,
    );
  }

  late final _free_WireSyncReturnPtr =
      _lookup<ffi.NativeFunction<ffi.Void Function(WireSyncReturn)>>(
          'free_WireSyncReturn');
  late final _free_WireSyncReturn =
      _free_WireSyncReturnPtr.asFunction<void Function(WireSyncReturn)>();
}

final class _Dart_Handle extends ffi.Opaque {}

final class wire_uint_8_list extends ffi.Struct {
  external ffi.Pointer<ffi.Uint8> ptr;

  @ffi.Int32()
  external int len;
}

final class wire_StringList extends ffi.Struct {
  external ffi.Pointer<ffi.Pointer<wire_uint_8_list>> ptr;

  @ffi.Int32()
  external int len;
}

typedef DartPostCObjectFnType = ffi.Pointer<
    ffi.NativeFunction<
        ffi.Bool Function(DartPort port_id, ffi.Pointer<ffi.Void> message)>>;
typedef DartPort = ffi.Int64;
