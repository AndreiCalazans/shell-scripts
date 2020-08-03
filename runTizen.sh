#!/usr/bin/env bash

echo "Build Tizen"
# TODO
# - Allow to add extra arguments
# - Implement defaults if empty

echo "Remote debugging on? (y/n)"
read withDebug

if [ "$withDebug" != "y" ] && [ "$withDebug" != "n" ]
then
  echo "Only y/z is accepted input"
  exit 1
fi

echo "Build for emulator? (y/n)"
read isForEmulator

if [ $isForEmulator != "y" ] && [ $isForEmulator != "n" ]
then
  echo "Only y/z is accepted input"
  exit 1
fi

localIp=$(ipconfig getifaddr en0)

YI_ARCH="armv7"
if [ $isForEmulator == "y" ] 
then
  YI_ARCH="x86_32"
fi

YI_DEBUG_LOGGER="OFF"

if [ $withDebug == "y" ] 
then
 YI_DEBUG_LOGGER="ON"
fi

youi-tv build -p tizen-nacl -d YI_ARCH=${YI_ARCH} -d YI_NETWORK_LOGGER_ENABLED=${YI_DEBUG_LOGGER} -d YI_NETWORK_LOGGER_IP=${localIp}

