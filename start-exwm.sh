#!/bin/sh

# Source .profile for common environment vars
. ~/.profile

# Disable access control for the current user
xhost +SI:localuser:$USER

shepherd

# Fire it up
exec dbus-launch --exit-with-session emacs -mm --debug-init --use-exwm
