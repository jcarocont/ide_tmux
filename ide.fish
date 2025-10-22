#!/usr/bin/env fish
# Mini IDE con Helix + terminal
# Autor: perrochico
# Fecha: 2025-10-22

# ----------------------------
# Parámetro: clean=True
# ----------------------------
set clean False
if test (count $argv) -ge 1
    if test $argv[1] = "clean=True"
        set clean True
    end
end

# ----------------------------
# Nombre de la sesión
# ----------------------------
set session hxide

# ----------------------------
# Directorio del script
# ----------------------------
set script_dir (dirname (status -f))

# ----------------------------
# Inicialización: permisos y carga de funciones
# ----------------------------
for f in $script_dir/utils/*.fish
    chmod +x $f
    source $f
end

# ----------------------------
# Si clean=True, mata la sesión vieja
# ----------------------------
if test $clean = True
    if tmux has-session -t $session 2>/dev/null
        tmux kill-session -t $session
    end
end

# ----------------------------
# Si la sesión ya existe, conecta
# ----------------------------
if tmux has-session -t $session 2>/dev/null
    tmux attach -t $session
    exit 0
end

# ----------------------------
# Crear nueva sesión tmux CON TERMINAL PRIMERO
# ----------------------------
tmux new-session -d -s $session -n dev fish
sleep 0.2

# ----------------------------
# Dividir y poner Helix ARRIBA (70%)
# ----------------------------
tmux split-window -v -t $session:0
sleep 0.2
tmux send-keys -t $session:0.0 "hx ." C-m

# ----------------------------
# Terminal inferior (30%) - ya existe
# ----------------------------
tmux send-keys -t $session:0.1 "clear && echo 'Terminal lista weón 🤘'" C-m

# ----------------------------
# Selecciona panel de Helix como activo
# ----------------------------
tmux select-pane -t $session:0.0

# ----------------------------
# Adjuntar sesión
# ----------------------------
tmux attach -t $session
