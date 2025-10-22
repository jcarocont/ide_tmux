
#!/usr/bin/env fish
# Configuración para nnn en IDE


source ~/pkg_ide/utils/loadf.fish

# Alias nnn sin preview
alias nnn_ide="nnn -P 0"

# Función para abrir archivo desde nnn en Helix
function nnn_open
    set file $argv[1]
    loadf -i $file
end

# Hook para Enter: cuando se seleccione un archivo en nnn
# nnn moderno permite usar un plugin, pero para simplificar usamos: 
# el usuario puede usar <Enter> y luego escribir: nnn_open <archivo>
# (o configurar plugin de nnn para llamar nnn_open)
