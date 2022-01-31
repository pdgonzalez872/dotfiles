#!/bin/bash

#
# Use this when you want to create a bunch of tmux windows, like I like to.
#

tmux start
tmux new-session -d -t monitor

tmux new-window -t monitor
tmux new-window -t monitor
tmux new-window -t monitor
tmux new-window -t monitor
tmux new-window -t monitor
tmux new-window -t monitor
tmux new-window -t monitor
tmux new-window -t monitor
tmux new-window -t monitor

tmux rename-window -t monitor:0 'main'
tmux rename-window -t monitor:1 'vim'
tmux rename-window -t monitor:2 'console'
tmux rename-window -t monitor:3 'tests'
tmux rename-window -t monitor:4 'server'
tmux rename-window -t monitor:5 'docker'
tmux rename-window -t monitor:6 'bash'
tmux rename-window -t monitor:7 'logs'
tmux rename-window -t monitor:8 'htop'
tmux rename-window -t monitor:9 'psql'

tmux send-keys -t monitor:1 'nvim' Enter
tmux split -t monitor:7
tmux split -t monitor:7
tmux send-keys -t monitor:8 'htop' Enter
