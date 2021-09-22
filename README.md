Arch/Artix Linux auto configuration scripts
--------------------------------------------

# Rules of application

0) all scripts are to be run as root

1) directories and files with numeral prefix come in ascending order

2) directories and files without numeral prefix come without specified order (except when dependencies exist)

3) .req.sh scripts are essential regardless of the usecase

4) .opt.sh scripts are optional and should be picked according to the usecase

# Contents

## installation-files

Helper scripts to be used during the installation process.

## 1-common

System configuration common to the most usecases.

## 2-specific

Variants of customized configuration for specific usecases.

## extras

Additional info and resources that don't fall into other categories.

