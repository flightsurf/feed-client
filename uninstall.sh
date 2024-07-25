#!/bin/bash
set -x

IPATH=/usr/local/share/flightsurf

systemctl disable --now flightsurf-mlat
systemctl disable --now flightsurf-mlat2 &>/dev/null
systemctl disable --now flightsurf-feed

if [[ -d /usr/local/share/tar1090/html-flightsurf ]]; then
    bash /usr/local/share/tar1090/uninstall.sh flightsurf
fi

rm -f /lib/systemd/system/flightsurf-mlat.service
rm -f /lib/systemd/system/flightsurf-mlat2.service
rm -f /lib/systemd/system/flightsurf-feed.service

cp -f "$IPATH/flightsurf-uuid" /tmp/flightsurf-uuid
rm -rf "$IPATH"
mkdir -p "$IPATH"
mv -f /tmp/flightsurf-uuid "$IPATH/flightsurf-uuid"

set +x

echo -----
echo "FlightSurf feed scripts have been uninstalled!"
