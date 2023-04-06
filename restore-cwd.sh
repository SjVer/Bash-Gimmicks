#!/bin/bash

# restores the last cwd when opening
# the terminal after startup once.

exit_session() {
    pwd > /home/sjoerd/.cwd_on_exit
}
trap exit_session EXIT

# recover cwd only on startup
if ! [ -f "/tmp/cwd_recovered" ]; then
    if [ -f "/home/sjoerd/.cwd_on_exit" ]; then
        cd $(cat /home/sjoerd/.cwd_on_exit)
        rm /home/sjoerd/.cwd_on_exit
        touch /tmp/cwd_recovered
    fi
fi
