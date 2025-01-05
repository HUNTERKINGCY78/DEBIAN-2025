#!/bin/bash

# Set up the VNC server password
VNC_PASSWORD=${VNC_PASSWORD:-"password"}
mkdir -p ~/.vnc
echo "$VNC_PASSWORD" | vncpasswd -f > ~/.vnc/passwd
chmod 600 ~/.vnc/passwd

# Start the VNC server
vncserver :1 -geometry 1280x720 -depth 24

# Kill the VNC server to allow noVNC to bind properly
vncserver -kill :1

# Start noVNC with the websockify wrapper
/opt/novnc/utils/launch.sh --vnc localhost:5901 --listen 8080 &
echo "noVNC running on http://localhost:8080"

# Keep the container running
tail -f /dev/null
