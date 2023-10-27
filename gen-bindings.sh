rm ./lib/bridge_*
rm ./native/src/generated_*

flutter_rust_bridge_codegen \
  --rust-input "native/src/api.rs" "native/src/ecdsa.rs" "native/src/bls.rs" \
  --dart-output "lib/bridge_generated_api.dart" "lib/bridge_generated_ecdsa.dart" "lib/bridge_generated_bls.dart" \
  --class-name NativeAPI ECDSA BLS\
  --rust-output "native/src/generated_api.rs" "native/src/generated_ecdsa.rs" "native/src/generated_bls.rs"

# declare -a modules=("api" "ecdsa" "bls")

# for mod in "${modules[@]}"; do
#   flutter_rust_bridge_codegen \
#     --rust-input "native/src/${mod}.rs" \
#     --dart-output "lib/bridge_generated_${mod}.dart" \
#     --class-name $(echo $mod | awk '{print toupper(substr($0,1,1)) tolower(substr($0,2));}') \
#     --rust-output "native/src/generated_${mod}.rs"
# done