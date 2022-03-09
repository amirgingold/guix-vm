#!/bin/sh

# Source .profile for common environment vars
. ~/.profile

# Disable access control for the current user
xhost +SI:localuser:$USER

# Start Shepherd to manage user daemons
if [ -z "$(pgrep -u me shepherd)" ]; then
  shepherd
fi

# Fire it up
exec dbus-launch --exit-with-session emacs --debug-init
