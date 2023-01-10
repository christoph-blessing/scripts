#!/bin/sh

session=stress_test
duration=3600

if tmux has-session -t $session 
then
    if [ -z "$TMUX" ]
    then
        tmux attach-session -t $session
    else
        tmux switch-client -t $session
    fi
    exit
fi

tmux new-session -d -s $session

tmux split-window -t $session:0.0 -h
tmux split-window -t $session:0.0 -h
tmux split-window -t $session:0.2 -h

tmux split-window -t $session:0.1 -v
tmux split-window -t $session:0.3 -v

tmux send-keys -t $session:0.0 'htop' C-m
tmux send-keys -t $session:0.1 'watch -n 1 nvidia-smi' C-m
tmux send-keys -t $session:0.2 'watch -n 1 sensors' C-m
tmux send-keys -t $session:0.3 "stress --cpu 24 --timeout $duration" C-m
tmux send-keys -t $session:0.4 "docker run --rm --gpus all --entrypoint ./gpu_burn gpu_burn -tc $duration" C-m

tmux select-pane -t $session:0.5

if [ -z "$TMUX" ]
then
    tmux attach-session -t $session
else
    tmux switch-client -t $session
fi
