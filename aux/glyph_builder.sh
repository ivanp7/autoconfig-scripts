#!/bin/bash
# desc: bash script for creating yaft's glyph.h

# settings
YAFT_DIR=`pwd`
WORK_DIR=/tmp/glyph_builder
ALIAS_FILE=alias

# infomation of each fonts
# milkjf
# already included in yaft

# unifont
UNIFONT_VERSION=11.0.02
UNIFONT_NAME=unifont-${UNIFONT_VERSION}
UNIFONT_FILE=${UNIFONT_NAME}.bdf.gz
UNIFONT_URL=http://unifoundry.com/pub/unifont/${UNIFONT_NAME}/font-builds/${UNIFONT_FILE}

# terminus font
TERMINUS_VERSION=4.46
TERMINUS_NAME=terminus-font-${TERMINUS_VERSION}
TERMINUS_FILE=${TERMINUS_NAME}.tar.gz
TERMINUS_URL=http://sourceforge.net/projects/terminus-font/files/${TERMINUS_NAME}/${TERMINUS_FILE}

# misc functions
usage()
{
	echo -e "usage: ./glyph_builder.sh FONTS VARIATIONS"
	echo -e "\tavalable fonts: milkjf, unifont, terminus"
	echo -e "depends on: wget"
}

generate()
{
	echo "./mkfont_bdf ./table/${ALIAS_FILE} ${@}  > ${YAFT_DIR}/glyph.h"
	./mkfont_bdf ./table/${ALIAS_FILE} ${@} > ${YAFT_DIR}/glyph.h
}

milkjf()
{
	echo -ne "creating glyph.h from milkjf font...\n"

	ln -sf $YAFT_DIR/mkfont_bdf .
	ln -sf $YAFT_DIR/table .
	ln -sf $YAFT_DIR/fonts .

	FILES=`find -L fonts -type f -name "*.bdf" | tr "\n" " "`

	generate ${FILES}
}

unifont()
{
	echo -ne "creating glyph.h from unifont...\n"
	wget -nc ${UNIFONT_URL}

	if test ! -f ${UNIFONT_NAME}.bdf; then
		gunzip ${UNIFONT_FILE}
	fi

	ln -sf $YAFT_DIR/mkfont_bdf .
	ln -sf $YAFT_DIR/table .

	FILES="${UNIFONT_NAME}.bdf"

	generate ${FILES}
}

terminus()
{
	echo -ne "creating glyph.h from terminus font...\n"
	wget -nc ${TERMINUS_URL}

	if test ! -d ${TERMINUS_NAME}; then
		bsdtar xf ${TERMINUS_FILE}
	fi

	cd ${TERMINUS_NAME}
	ln -sf $YAFT_DIR/mkfont_bdf .
	ln -sf $YAFT_DIR/table .

	case "$1" in
	u*)
		FILES=`find . -type f -name "*${1}.bdf" | tr "\n" " "`;;
	*)
		echo -ne "avalable font variations: u(14|16)v, u(12|14|16|18|20|22|24|28|32)[nb]\n"
		exit -1;;
	esac

	generate ${FILES}
}

# main
echo "LANG: $LANG"
mkdir -p $WORK_DIR
cd $WORK_DIR

case "$1" in 
"milkjf")
	milkjf;;
"unifont")
	unifont;;
"terminus")
	shift
	terminus $1;;
*)
	usage;;
esac
