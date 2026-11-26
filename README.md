# DELL OS

Custom Android ROM project for **Samsung Galaxy Mini 2 (GT-S6500D, codename jena)**.

## Target platform

- Base: CyanogenMod 10 / Android 4.1.2 (Jelly Bean)
- Device tree: `TheWhisp/android_device_samsung_jena`, branch `jellybean`
- Kernel source: `kodok17/android_kernel_samsung_msm7x27a`, branch `cm-10.0`
- Kernel family: Linux 3.4.x
- Recovery target: ClockworkMod (CWM), subject to package and partition verification

## Project status

This repository currently contains project documentation and configuration checks. **It is not a ROM and does not contain a flashable ZIP.** A successful CI check does not mean Android has been built.

## Planned components

- DELL Shell — home screen and app launcher
- DELL Settings — system settings front end
- DELL Files — file browser
- DELL Music — local music player
- DELL System Info — device and build information
- DELL boot animation and visual theme

## Safety

Do not flash experimental images until the exact device variant, partition layout, boot image format, recovery compatibility, and a restorable stock backup have all been verified. The GT-S6500D must not be treated as interchangeable with every Galaxy Mini 2 variant.

## Build strategy

The full legacy Android build needs substantially more disk space and memory than the current small Cloud Shell home volume. The first GitHub Actions workflow only validates project metadata. A full ROM build workflow will be added after a suitable runner and complete source/vendor inputs are established.
