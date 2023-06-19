Instruction
-----------

1. Copy `gentoo-install`, `gentoo-install.conf` to the root partiotion of the installed system
along with the stage3 archive. Optionally, copy kernel configuration there too.

2. Configure `gentoo-install.conf` in compliance with the installed system requirements.

3. Run `gentoo-install` as root.

4. If `gentoo-install` fails, solve the problem and re-run the script. It is safe to do so
because it self-modifies itself to remove the successfully completed steps.

