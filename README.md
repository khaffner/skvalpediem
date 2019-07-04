# Skvalpe Diem
Named after the boat I'm part owner of. This repo contains code for logging data relevant for the boat using various sensors.

## Software used
- Raspbian
  - Linux distro for Raspberry Pi
- Pwsh
  - My preferred scripting language
- http://osoyoo.com/driver/voltage.py
  - Script that gets the actual voltage. Slightly modified by me for this project.
- gpsd
  - Daemon for GPS signals
- gpsd-clients
  - Clients for accessing GPS data.
    - Example: gpspipe
- Syncthing
  - Used for syncing the boatdata folder to various devices


## Services used
- api.met.no
  - Getting weather forecast for a given coordinate
- api.ipify.org
  - Getting external IP and checking if online at all
- maps.google.com
  - Generate url with coordinates
  - "Normal" map.
- Gulesider.no
  - Generate url with coordinates
  - Nautical map

## Hardware used
- Raspberry Pi 3 Model B+
  - The computer
- GlobalSat BU-353S4
  - GPS receiver
- MCP3008
  - Analog to Digital converter
- Voltage Sensor VCC<25V
  - Divides input voltage by 5. 25V --> 5V
- Breadboard and wires