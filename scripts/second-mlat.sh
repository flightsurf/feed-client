#!/bin/bash
SERVICE="/lib/systemd/system/flightsurf-mlat2.service"

if [[ -z ${1} ]]; then
    echo --------------
    echo ERROR: requires a parameter
    exit 1
fi

cat >"$SERVICE" <<"EOF"
[Unit]
Description=flightsurf-mlat2
Wants=network.target
After=network.target

[Service]
User=flightsurf
EnvironmentFile=/etc/default/flightsurf
ExecStart=/usr/local/share/flightsurf/venv/bin/mlat-client \
    --input-type $INPUT_TYPE --no-udp \
    --input-connect $INPUT \
    --server feed.flightsurf.io:SERVERPORT \
    --user $USER \
    --lat $LATITUDE \
    --lon $LONGITUDE \
    --alt $ALTITUDE \
    $UUID_FILE \
    $PRIVACY \
    $RESULTS
Type=simple
Restart=always
RestartSec=30
StartLimitInterval=1
StartLimitBurst=100
SyslogIdentifier=flightsurf-mlat2
Nice=-1

[Install]
WantedBy=default.target
EOF

if [[ -f /boot/flightsurf-config.txt ]]; then
    sed -i -e 's#EnvironmentFile.*#EnvironmentFile=/boot/flightsurf-env\nEnvironmentFile=/boot/flightsurf-config.txt#' "$SERVICE"
fi

sed -i -e "s/SERVERPORT/${1}/" "$SERVICE"
if [[ -n ${2} ]]; then
    sed -i -e "s/\$RESULTS/${2}/" "$SERVICE"
fi

systemctl enable flightsurf-mlat2
systemctl restart flightsurf-mlat2
