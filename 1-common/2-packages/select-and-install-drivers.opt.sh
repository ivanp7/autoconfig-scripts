#!/bin/sh

SCRIPT_NAME="$(basename "$0")"
cd -- "$(dirname "$0")"
SCRIPT_DIR="$PWD"

SCRIPT_TITLE="Select and install drivers"
: ${AUTOCONFIG_SELF_LOGGING:=deferred}
. "./.init.sh"

####################################################################

choose_packages_and_start_self_logging \
`# Video drivers` \
    xf86-video-nouveau      "Open Source 3D acceleration driver for nVidia cards" off \
    xf86-video-intel        "X.org Intel i810/i830/i915/945G/G965+ video drivers" off \
    xf86-video-amdgpu       "X.org amdgpu video driver" off \
    xf86-video-ati          "X.org ati video driver" off \
    xf86-video-vmware       "X.org vmware video driver" off \
    xf86-video-openchrome   "X.Org Openchrome drivers" off \
    xf86-video-qxl          "Xorg X11 qxl video driver" off \
    xf86-video-voodoo       "X.org 3dfx Voodoo1/Voodoo2 2D video driver" off \
    xf86-video-dummy        "X.org dummy video driver" off \
`# Input drivers` \
    xf86-input-vmmouse      "X.org VMWare Mouse input driver" off \
    xf86-input-synaptics    "Synaptics driver for notebook touchpads" off \
    xf86-input-evdev        "X.org evdev input driver" off \
    xf86-input-void         "X.org void input driver" off

install_packages $AUTOCONFIG_CHOSEN_PACKAGES

