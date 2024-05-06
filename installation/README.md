Instruction
-----------

0. Download `gentoo-install` and [`gentoo-install.conf`](https://gist.github.com/ivanp7/32739a5cebd2a0f6b1bfbdcd04fb775e):

```sh
wget 'https://raw.githubusercontent.com/ivanp7/autoconfig-scripts/gentoo/installation/gentoo-install'
wget 'https://gist.githubusercontent.com/ivanp7/32739a5cebd2a0f6b1bfbdcd04fb775e/raw/gentoo-install.conf'
```

1. Copy `gentoo-install`, `gentoo-install.conf` (and, optionally, kernel configuration: `.config` or `defconfig`)
to the root partition of the newly installed system along with the stage3 archive.

2. Edit `gentoo-install.conf` in compliance with the system requirements.

3. Run `gentoo-install` as root.

4. If `gentoo-install` fails, solve the problem and re-run the script.
It is safe to do so because the script is idempotent:
it modifies itself to remove successfully completed steps
(this guarantee is only valid while everything is mounted,
because the mounting step is done early in the script and is getting removed from it).

