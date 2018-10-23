#!/bin/bash

echo ""
echo "==================================="
echo "DigiMachinist's FC660C Flash Script"
echo "==================================="
echo ""
echo "TMK Wiki: https://github.com/tmk/tmk_keyboard/wiki"
echo ""
if [ -z ${1+x} ];
then
	echo "Syntax: ./flash_fc660c.sh <layout file>"
	echo ""
	[[ "$0" = "$BASH_SOURCE" ]] && exit 1 || return 1 # Exit gracefully
fi
echo "Layout File: $1"
echo ""
echo "Press the button on the bottom of the keyboard to enter bootloader mode."
echo "You will hear the USB disconnect and reconnect sounds."
echo "Have you done this? Are you ready to continue?"
read -n 1 -r
echo ""
if [[ ! $REPLY =~ ^[Yy]$ ]]
then
	echo "Well then come back when you are!"
	echo ""
	[[ "$0" = "$BASH_SOURCE" ]] && exit 1 || return 1 # Exit gracefully
fi
echo ""
echo "Flashing..."
dfu-programmer atmega32u4 erase
dfu-programmer atmega32u4 flash $1
dfu-programmer atmega32u4 reset
echo ""
echo "Done!"
echo ""

