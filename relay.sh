#!/bin/sh

case "$1" in
  start)
    if lsof -i -P -n | grep 8000; then
        :
    else
        $0 stop 
        pactl load-module module-simple-protocol-tcp rate=24000 format=s16le channels=1 source=alsa_output.pci-0000_03_00.6.analog-stereo.monitor record=true port=8000
    fi
    ;;
  stop)
    pactl unload-module `pactl list | grep tcp -B1 | grep M | sed 's/[^0-9]//g'`
    ;;
  *)
    echo "Usage: $0 start|stop" >&2
    ;;
esac
