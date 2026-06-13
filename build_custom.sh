#!/bin/bash
# ======================================================
#  Xiaomi Redmi K70 (vermeer) Kernel Build Script
#  ReSukiSU + SUSFS Integrated
# ======================================================

KERNEL_DIR="/home/misaka1145/Xiaomi_Kernel_OpenSource"
DEFCONFIG_FRAGMENT="arch/arm64/configs/vendor/vermeer_GKI.config"
JOBS=$(nproc)

echo "=============================================="
echo "  vermeer Kernel Builder"
echo "  ReSukiSU + SUSFS"
echo "=============================================="
echo ""

# --- Step 1: Kernel name ---
read -p "Modify kernel name? [y/N]: " MODIFY_NAME
case "$MODIFY_NAME" in
    [Yy]*)
        read -p "Enter your name: " USERNAME
        if [ -n "$USERNAME" ]; then
            EXTRA_VER="-Misaka-NO.114514_${USERNAME}"
            cd "$KERNEL_DIR" || exit 1
            sed -i "s/^EXTRAVERSION =.*/EXTRAVERSION = ${EXTRA_VER}/" Makefile
            echo ">>> Kernel version will be: 5.15.78${EXTRA_VER}"
        else
            echo ">>> Name empty, skipping."
        fi
        ;;
    *)
        echo ">>> Keeping current kernel version."
        ;;
esac

# --- Step 2: Clean build? ---
echo ""
read -p "Clean build (mrproper)? [y/N]: " CLEAN_BUILD

# --- Step 3: AnyKernel3? ---
echo ""
read -p "Package as AnyKernel3 zip after build? [y/N]: " AK3_BUILD

cd "$KERNEL_DIR" || exit 1

# Always build Image only, AK3 just copies it after
BUILD_TARGETS="Image"

case "$CLEAN_BUILD" in
    [Yy]*)
        echo ""
        echo ">>> [1/3] Cleaning..."
        make ARCH=arm64 mrproper

        echo ">>> [2/3] Generating defconfig..."
        make ARCH=arm64 LLVM=1 gki_defconfig
        ARCH=arm64 scripts/kconfig/merge_config.sh -m -r .config "$DEFCONFIG_FRAGMENT"
        make ARCH=arm64 LLVM=1 olddefconfig
        ;;
    *)
        echo ">>> Skipping clean, incremental build..."
        ;;
esac

# --- Step 4: Build ---
echo ""
echo ">>> [3/3] Building kernel (jobs: $JOBS)..."
make ARCH=arm64 LLVM=1 -j"$JOBS" $BUILD_TARGETS

# --- Result ---
echo ""
if [ ! -f "$KERNEL_DIR/arch/arm64/boot/Image" ]; then
    echo "=============================================="
    echo "  BUILD FAILED!"
    echo "=============================================="
    exit 1
fi

KVER=$(cat "$KERNEL_DIR/include/generated/utsrelease.h" 2>/dev/null | awk '{print $3}' | tr -d '"')
echo "=============================================="
echo "  BUILD SUCCESS!"
echo "  Version : ${KVER:-unknown}"
echo "  Image   : arch/arm64/boot/Image"
echo "  Size    : $(du -h arch/arm64/boot/Image | cut -f1)"
echo "=============================================="

# --- AnyKernel3 packaging ---
case "$AK3_BUILD" in
    [Yy]*)
        echo ""
        echo ">>> Packaging AnyKernel3 zip..."

        AK3_DIR="$KERNEL_DIR/anykernel"
        AK3_ZIP="$KERNEL_DIR/out/vermeer-kernel-${KVER:-custom}.zip"
        mkdir -p "$KERNEL_DIR/out"

        # Copy kernel Image
        cp arch/arm64/boot/Image "$AK3_DIR/"
        echo "    [+] Image"

        # Create zip
        rm -f "$AK3_ZIP"
        cd "$AK3_DIR" || exit 1
        zip -r "$AK3_ZIP" . -x "*.zip" > /dev/null 2>&1
        cd "$KERNEL_DIR" || exit 1

        echo ""
        echo "=============================================="
        echo "  AnyKernel3 ZIP ready!"
        echo "  File: out/vermeer-kernel-${KVER:-custom}.zip"
        echo "  Size: $(du -h "$AK3_ZIP" | cut -f1)"
        echo ""
        echo "  Flash via TWRP or KernelSU Manager"
        echo "=============================================="
        ;;
esac
