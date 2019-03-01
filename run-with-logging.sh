#!/bin/bash

cd $(dirname $1)
SCRIPT=$(basename $1)

./$SCRIPT 2>&1 | tee -a "$SCRIPT.log"

