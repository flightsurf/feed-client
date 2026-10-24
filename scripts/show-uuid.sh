#!/bin/bash
# Prints this feeder's UUID and where to claim it, so its owner can see its
# stats under My feeders on flightsurf.io.

UUID_FILE="/usr/local/share/flightsurf/flightsurf-uuid"
if [ -f /boot/flightsurf-config.txt ]; then
    UUID_FILE="/boot/flightsurf-uuid"
fi

if ! [ -f "$UUID_FILE" ]; then
    echo "No UUID file at $UUID_FILE. Run the FlightSurf update script first."
    exit 1
fi

UUID=$(tr -d '{}[:space:]' < "$UUID_FILE")
echo "Your FlightSurf feeder UUID: $UUID"
echo "To see this feeder's stats, sign in at https://flightsurf.io/feeders"
echo "and claim it with this UUID. Keep it private: whoever claims it first owns it."
