rm -f ./lib/bridge_generated.dart
rm -f ./lib/bridge_definitions.dart
rm -f ./native/src/bridge_generated.io.rs
rm -f ./native/src/bridge_generated.rs

flutter_rust_bridge_codegen --rust-input native/src/api.rs --dart-output lib/bridge_generated.dart --dart-decl-output lib/bridge_definitions.dart
