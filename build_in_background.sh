#!/bin/zsh

MXE_DIR=${0:a:h}
sudo systemd-run --uid=${UID} --unit=build-mxe --working-directory=${MXE_DIR} ${MXE_DIR}/build.sh
