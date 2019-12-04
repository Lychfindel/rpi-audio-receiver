#!/bin/bash -e

echo -n "Do you want to install Startup sound? [y/N] "
read REPLY
if [[ ! "$REPLY" =~ ^(yes|y|Y)$ ]]; then exit 0; fi

mkdir -p /usr/local/share/sounds/WoodenBeaver/stereo
if [ ! -f /usr/local/share/sounds/WoodenBeaver/stereo/device-added.wav ]; then
    curl -so /usr/local/share/sounds/WoodenBeaver/stereo/device-added.wav https://raw.githubusercontent.com/nicokaiser/rpi-audio-receiver/master/device-added.wav
fi
if [ ! -f /usr/local/share/sounds/WoodenBeaver/stereo/device-removed.wav ]; then
    curl -so /usr/local/share/sounds/WoodenBeaver/stereo/device-removed.wav https://raw.githubusercontent.com/nicokaiser/rpi-audio-receiver/master/device-removed.wav
fi

cat <<'EOF' > /etc/systemd/system/startup-sound.service
[Unit]
Description=Startup sound
After=multi-user.target

[Service]
Type=simple
ExecStart=/usr/bin/aplay -q /usr/local/share/sounds/WoodenBeaver/stereo/device-added.wav

[Install]
WantedBy=multi-user.target
EOF
systemctl enable startup-sound.service
