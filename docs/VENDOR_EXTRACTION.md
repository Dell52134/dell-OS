# Jena vendor extraction

The legacy Jena product makefile includes
`vendor/samsung/jena/jena-vendor.mk`. The upstream Jelly Bean-era Jena
vendor blob manifest identifies four files in a matching stock system image:

- `/cameradata/datapattern_420sp_jena.yuv`
- `/lib/hw/sensors.default.so`
- `/lib/libacdapi_azi.so`
- `/lib/liboemcamera.so`

The helper script extracts these files from a **raw ext4 system image** and
generates the local vendor makefiles:

```bash
bash scripts/extract-jena-vendor.sh \
  /path/to/system.raw.ext4 \
  /path/to/android-source
```

For the current Codespaces layout, the intended paths are:

```bash
bash /workspaces/dell-OS/scripts/extract-jena-vendor.sh \
  /workspaces/dell-OS/firmware/stock/system.raw.ext4 \
  /workspaces/cm10
```

The script checks that all four source files exist before extracting anything.
It writes proprietary binaries under `/workspaces/cm10/vendor/samsung/jena`;
they are not committed to this repository.

## Important limitations

- The source image must be the matching GT-S6500D stock system image converted
  from Android sparse format to raw ext4.
- This prepares the four files listed by the legacy Jelly Bean Jena vendor
  manifest. It does **not** prove that every proprietary dependency needed by
  a complete CM10 build has been supplied.
- Stock Wi-Fi kernel modules are intentionally not copied. Their kernel ABI
  compatibility with the selected CM10 kernel has not been established.
- Do not publish extracted proprietary binaries unless redistribution is
  authorized.
- Successful extraction is not evidence that the ROM compiles or is safe to
  flash. The full source sync, kernel integration, vendor dependency audit,
  build, ZIP validation, and device-specific recovery checks remain separate
  steps.
