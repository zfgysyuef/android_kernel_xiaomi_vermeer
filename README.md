# Android Kernel for Xiaomi Redmi K70 (vermeer)

[中文](#中文) | English

Kernel source based on [MiCode/Xiaomi_Kernel_OpenSource](https://github.com/MiCode/Xiaomi_Kernel_OpenSource), integrated with [ReSukiSU](https://github.com/ReSukiSU/ReSukiSU) + [SuSFS](https://gitlab.com/simonpunk/susfs4ksu).

## Device Info

- **Device**: Xiaomi Redmi K70
- **Codename**: vermeer
- **Platform**: Snapdragon 8 Gen 2 (Kalama)
- **Kernel Version**: 5.15.78
- **Android**: 13 / GKI 2.0

## Features

- [x] ReSukiSU v4.1.0 (KernelSU fork)
- [x] SuSFS v2.1.0 Inline Hook
- [x] ThinLTO (faster builds)
- [x] AnyKernel3 packaging support

## Build

### Prerequisites

- Ubuntu 22.04 / WSL2
- clang, lld, llvm (LLVM 14+)

```bash
sudo apt install clang lld llvm
```

### Quick Build

```bash
git clone https://github.com/zfgysyuef/android_kernel_xiaomi_vermeer.git
cd android_kernel_xiaomi_vermeer
bash KernelSU/kernel/setup.sh
./build_custom.sh
```

### Manual Build

```bash
make ARCH=arm64 LLVM=1 gki_defconfig
ARCH=arm64 scripts/kconfig/merge_config.sh -m -r .config arch/arm64/configs/vendor/vermeer_GKI.config
make ARCH=arm64 LLVM=1 olddefconfig
make ARCH=arm64 LLVM=1 -j$(nproc) Image
```

Output: `arch/arm64/boot/Image`

### AnyKernel3

Select the AnyKernel3 option in `build_custom.sh` to auto-package a flashable ZIP into the `out/` directory.

## Kernel Config

| Option | Status |
|--------|--------|
| CONFIG_KSU | Enabled |
| CONFIG_KSU_SUSFS | Enabled |
| CONFIG_LTO_CLANG_THIN | ThinLTO |
| CONFIG_DEVTMPFS | Enabled |
| CONFIG_MODULE_SIG | Disabled |

## Flash

1. Build to get `out/vermeer-kernel-*.zip`
2. Flash via TWRP or KernelSU Manager
3. Install ReSukiSU Manager APK

## Credits

- [ReSukiSU](https://github.com/ReSukiSU/ReSukiSU)
- [SukiSU-Ultra](https://github.com/SukiSU-Ultra/SukiSU-Ultra)
- [KernelSU](https://github.com/tiann/KernelSU)
- [SuSFS](https://gitlab.com/simonpunk/susfs4ksu)
- [AnyKernel3](https://github.com/osm0sis/AnyKernel3)
- [MiCode](https://github.com/MiCode)

---

## 中文

基于小米开源内核 [MiCode/Xiaomi_Kernel_OpenSource](https://github.com/MiCode/Xiaomi_Kernel_OpenSource)，集成 [ReSukiSU](https://github.com/ReSukiSU/ReSukiSU) + [SuSFS](https://gitlab.com/simonpunk/susfs4ksu)。

## 设备信息

- **设备**: Xiaomi Redmi K70
- **代号**: vermeer
- **平台**: Snapdragon 8 Gen 2 (Kalama)
- **内核版本**: 5.15.78
- **Android**: 13 / GKI 2.0

## 特性

- [x] ReSukiSU v4.1.0 (KernelSU fork)
- [x] SuSFS v2.1.0 Inline Hook
- [x] ThinLTO (快速编译)
- [x] AnyKernel3 打包支持

## 编译

### 环境要求

- Ubuntu 22.04 / WSL2
- clang lld llvm (LLVM 14+)

```bash
sudo apt install clang lld llvm
```

### 快速编译

```bash
git clone https://github.com/zfgysyuef/android_kernel_xiaomi_vermeer.git
cd android_kernel_xiaomi_vermeer
bash KernelSU/kernel/setup.sh
./build_custom.sh
```

### 手动编译

```bash
make ARCH=arm64 LLVM=1 gki_defconfig
ARCH=arm64 scripts/kconfig/merge_config.sh -m -r .config arch/arm64/configs/vendor/vermeer_GKI.config
make ARCH=arm64 LLVM=1 olddefconfig
make ARCH=arm64 LLVM=1 -j$(nproc) Image
```

产物位于 `arch/arm64/boot/Image`。

### AnyKernel3 打包

编译完成后，`build_custom.sh` 可选择自动打包为 AnyKernel3 ZIP，产物位于 `out/` 目录。

## 内核配置

| 选项 | 状态 |
|------|------|
| CONFIG_KSU | 已启用 |
| CONFIG_KSU_SUSFS | 已启用 |
| CONFIG_LTO_CLANG_THIN | ThinLTO |
| CONFIG_DEVTMPFS | 已启用 |
| CONFIG_MODULE_SIG | 已关闭 |

## 刷入

1. 编译得到 `out/vermeer-kernel-*.zip`
2. 通过 TWRP 或 KernelSU Manager 刷入
3. 安装 ReSukiSU Manager APK

## 如何联系我

QQ@1806034839
Coolapk 御坂114514号
https://www.coolapk.com/u/36938523

## 致谢

- [ReSukiSU](https://github.com/ReSukiSU/ReSukiSU)
- [SukiSU-Ultra](https://github.com/SukiSU-Ultra/SukiSU-Ultra)
- [KernelSU](https://github.com/tiann/KernelSU)
- [SuSFS](https://gitlab.com/simonpunk/susfs4ksu)
- [AnyKernel3](https://github.com/osm0sis/AnyKernel3)
- [MiCode](https://github.com/MiCode)
