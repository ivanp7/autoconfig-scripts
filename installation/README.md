Instruction
-----------

1. Copy `gentoo-install`, `gentoo-install.conf` (and, optionally, kernel configuration: `.config` or `defconfig`)
to the root partition of the newly installed system along with the stage3 archive.

2. Edit `gentoo-install.conf` in compliance with the system requirements.

3. Run `gentoo-install` as root.

4. If `gentoo-install` fails, solve the problem and re-run the script. It is safe to do so
because the script modifies itself to remove successfully completed steps.

