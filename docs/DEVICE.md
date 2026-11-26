# Device configuration: Jena

## Confirmed project inputs

| Item | Value |
|---|---|
| Product codename | `jena` |
| Product model | `GT-S6500D` |
| Product makefile | `full_jena.mk` |
| Device tree branch | `jellybean` |
| Kernel repository | `kodok17/android_kernel_samsung_msm7x27a` |
| Kernel branch | `cm-10.0` |
| Kernel defconfig file | `arch/arm/configs/cyanogenmod/jenad_defconfig` |
| Kernel config symbol | `CONFIG_MACH_JENA=y` |

## Important configuration detail

The device tree's original `BoardConfig.mk` referred to `cyanogenmod_jena_defconfig`, but the checked-out kernel source contains `cyanogenmod/jenad_defconfig`. The local Cloud Shell copy was changed to:

```make
TARGET_KERNEL_CONFIG := cyanogenmod/jenad_defconfig
```

This repository records the observed values; it does not yet prove that the legacy CM10 build system consumes this path as expected. That integration must be tested in a real build environment.

## Known board settings from the device tree

- Architecture: ARM
- Platform: Qualcomm MSM7x27A
- GPU: Qualcomm Adreno 200
- Display/boot animation: 320x480
- Product model: GT-S6500D

Partition sizes and block-device mappings from old device-tree files are historical configuration values, not independently verified hardware facts. Do not use them for flashing until checked against the exact phone.
