### AnyKernel3 Ramdisk Mod Script
## ReSukiSU for Xiaomi Redmi K70 (vermeer)

### AnyKernel setup
properties() { '
kernel.string=ReSukiSU-SUSFS by misaka @ vermeer
do.devicecheck=0
do.modules=0
do.systemless=0
do.cleanup=1
do.cleanuponabort=0
supported.partitions=boot
'; }

### boot install (kernel only)
BLOCK=/dev/block/by-name/boot;
IS_SLOT_DEVICE=auto;
RAMDISK_COMPRESSION=auto;
PATCH_VBMETA_FLAG=auto;

. tools/ak3-core.sh;

# GKI 2.0: boot has no ramdisk, just replace kernel Image
split_boot;
flash_boot;
