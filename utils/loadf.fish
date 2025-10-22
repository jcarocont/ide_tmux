#!/usr/bin/env fish
# Función para abrir archivos en Helix desde tmux

function loadf
    if test (count $argv) -ne 2 -o $argv[1] != -i
        echo "Uso: loadf -i archivo"
        return 1
    end

    set file $argv[2]

    if tmux has-session -t miniide 2>/dev/null
        tmux select-pane -t miniide:0.1
        tmux send-keys -t miniide:0.1 "hx $file" C-m
        tmux select-pane -t miniide:0.2
    else
        echo "Sesión 'miniide' no corriendo"
    end
end
