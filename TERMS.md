# FlightSurf feeder terms

Version 1, 23 October 2026

These terms apply when you install this feed client and share data from your receiver with FlightSurf ([flightsurf.io](https://flightsurf.io/)). The setup asks you to accept them before it sends anything.

## What your receiver sends

- **Aircraft messages:** the ADS-B, Mode S and UAT messages your receiver decodes. These are radio broadcasts from aircraft, not data about you.
- **MLAT timing data,** if MLAT is on: message timings and your antenna's location and altitude, which MLAT needs to work out aircraft positions.
- **Your feeder ID:** a random ID created on your device, and the MLAT name you choose.
- **Connection data:** your IP address and connection times, as with any internet service.

## What FlightSurf does with it

- **Shows it:** aircraft positions from your receiver appear on the FlightSurf map, combined with data from other feeders and sources.
- **Keeps it:** flight history is kept for 14 days, then deleted.
- **Shares it:** FlightSurf may share combined aircraft data, for example through its map, exports or an API. Your precise antenna location and your IP address are never shown or shared.
- **MLAT map:** your MLAT name and an approximate location, offset for privacy, appear on the MLAT map. Set `PRIVACY="--privacy"` in `/etc/default/flightsurf` to hide your name.

## Your choices

- You can stop sharing at any time by running `sudo bash /usr/local/share/flightsurf/git/uninstall.sh`.
- To have your feeder ID and its statistics deleted, contact FlightSurf.
- You keep any rights you have in your receiver's data. By feeding, you allow FlightSurf to use it as these terms describe, free of charge, including after you stop feeding.

## Changes

If these terms change, the version number goes up and the setup asks you to accept the new version.
