# DELL OS — build status

Target device: Samsung Galaxy Mini 2 GT-S6500D (codename: jena).
Target base: CyanogenMod 10 / Android 4.1.2.

## Current state

- [x] Repository and project README exist.
- [ ] Device tree compatibility verified against the selected kernel.
- [ ] Kernel configuration and build output verified.
- [x] Matching GT-S6500D stock firmware archive received and its embedded MD5 verified.
- [ ] Required proprietary vendor files identified and extracted from the stock system image.
- [ ] Full Android source manifest pinned and synced.
- [ ] ROM build completed.
- [ ] ZIP contents and updater-script validated.
- [ ] Recovery installation tested on a recoverable test setup.

**The matching stock firmware archive and embedded MD5 were verified, and its sparse system image was converted for analysis. Required proprietary files have not yet been extracted. The Java 7 CI setup failed because the available Zulu versions no longer include Java 7; the workflow now tests Temurin JDK 8. That retry is still in progress and has not yet confirmed Java setup or source sync. There is currently no built ROM and no flashable ZIP in this repository.**

## Build safety

Do not flash experimental images until the exact device variant, partition layout,
recovery compatibility, boot image, and a tested restoration path are confirmed.
A GT-S6500 and GT-S6500D must not be assumed interchangeable.

## Build strategy

The repository has metadata-validation workflows and an experimental full CM10 build workflow. The full build workflow is still being validated; it must not be treated as a successful build until it completes source sync, passes the proprietary-file checks, compiles, and uploads a verified ZIP.
