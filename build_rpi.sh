#!/bin/bash

# Build file for Raspberry Pi command line
gnatmake -f -d -Pdogrobot.gpr -XModule=MOD_RPI
