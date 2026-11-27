#!/usr/bin/env bash
# Extract the Jena proprietary files listed by the legacy Jelly Bean vendor
# blob manifest from a matching GT-S6500D stock system image.
#
# Usage:
#   scripts/extract-jena-vendor.sh SYSTEM_RAW_EXT4 ANDROID_SOURCE_ROOT
#
# This script writes proprietary binaries only to ANDROID_SOURCE_ROOT/vendor.
# Do not commit or publish that generated vendor directory unless you have
# confirmed you have permission to redistribute those files.

set -euo pipefail

if [[ $# -ne 2 ]]; then
    echo "Usage: $0 SYSTEM_RAW_EXT4 ANDROID_SOURCE_ROOT" >&2
    exit 2
fi

IMAGE=$(realpath "$1")
ANDROID_ROOT=$(realpath -m "$2")

if [[ ! -f "$IMAGE" ]]; then
    echo "ERROR: system image not found: $IMAGE" >&2
    exit 1
fi

if ! command -v debugfs >/dev/null 2>&1; then
    echo "ERROR: debugfs is required (Ubuntu/Debian package: e2fsprogs)." >&2
    exit 1
fi

# These are the Jena blobs referenced by the Jelly Bean-era vendor manifest.
# Paths are relative to the root of the raw system.ext4 filesystem.
declare -A FILES=(
    ["/cameradata/datapattern_420sp_jena.yuv"]="cameradata/datapattern_420sp_jena.yuv"
    ["/lib/hw/sensors.default.so"]="lib/hw/sensors.default.so"
    ["/lib/libacdapi_azi.so"]="lib/libacdapi_azi.so"
    ["/lib/liboemcamera.so"]="lib/liboemcamera.so"
)

echo "Checking source files in: $IMAGE"
missing=0
for source in "${!FILES[@]}"; do
    if ! debugfs -R "stat $source" "$IMAGE" 2>&1 | grep -q "Inode:"; then
        echo "MISSING: $source"
        missing=1
    else
        echo "FOUND:   $source"
    fi
done

if [[ "$missing" -ne 0 ]]; then
    echo "ERROR: one or more expected Jena blobs are absent. Nothing was extracted." >&2
    exit 1
fi

VENDOR="$ANDROID_ROOT/vendor/samsung/jena"
mkdir -p "$VENDOR/proprietary/cameradata" "$VENDOR/proprietary/lib/hw" "$VENDOR/proprietary/lib"

for source in "${!FILES[@]}"; do
    destination="$VENDOR/proprietary/${FILES[$source]}"
    mkdir -p "$(dirname "$destination")"
    debugfs -R "dump $source $destination" "$IMAGE" >/dev/null 2>&1
    test -s "$destination"
    echo "EXTRACTED: $destination"
done

cat > "$VENDOR/blobs.mk" <<'EOF'
# Proprietary Jena files extracted locally from matching GT-S6500D stock firmware.
# Keep these binaries out of public commits unless redistribution is authorized.
PRODUCT_COPY_FILES += \\
    vendor/samsung/jena/proprietary/cameradata/datapattern_420sp_jena.yuv:system/cameradata/datapattern_420sp_jena.yuv \\
    vendor/samsung/jena/proprietary/lib/hw/sensors.default.so:system/lib/hw/sensors.default.so \\
    vendor/samsung/jena/proprietary/lib/libacdapi_azi.so:system/lib/libacdapi_azi.so \\
    vendor/samsung/jena/proprietary/lib/liboemcamera.so:system/lib/liboemcamera.so
EOF

cat > "$VENDOR/jena-vendor.mk" <<'EOF'
# Generated locally by scripts/extract-jena-vendor.sh
$(call inherit-product, vendor/samsung/jena/blobs.mk)
EOF

cat > "$VENDOR/BoardConfigVendor.mk" <<'EOF'
# No additional BoardConfig overrides are currently generated for Jena.
EOF

echo
echo "Vendor makefiles created at: $VENDOR"
echo "Proprietary binaries remain local and are not added to Git."
echo "NOTE: stock Wi-Fi kernel modules were deliberately not included; their"
echo "      compatibility with the CM10 kernel has not been established."
