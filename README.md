Arch/Artix Linux auto configuration scripts
--------------------------------------------

# Directories

1. `installation`: helper files and scripts to be used during the installation process

2. `content`: scripts for configuration of an installed system

3. `extras`: additional info and resources

# Rules of application of scripts in `content` directory

1. all scripts are to be run as root

2. `check` scripts determine whether configuration is needed, which is true in case of non-zero exit code

3. `configure` scripts transfer system into specified state

