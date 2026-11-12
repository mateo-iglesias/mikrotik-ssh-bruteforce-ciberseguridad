# 03 - Firewall anti fuerza bruta + gestión solo desde lista mgmt
# ACTIVA SAFE MODE ANTES (Ctrl+X).
# IMPORTANTE: estas reglas deben quedar ARRIBA de cualquier regla "accept" del chain input.
# Ajusta el puerto si cambiaste SSH (22 o 2222).

# Lista de equipos/redes autorizados para gestionar el router
/ip firewall address-list
add list=mgmt address=192.168.88.0/24 comment="Red de gestion - CAMBIAR"

/ip firewall filter
# 1) Descartar a quien ya esté en la blacklist
add chain=input protocol=tcp dst-port=22,2222 src-address-list=ssh_blacklist action=drop comment="SSH: drop blacklist"

# 2) Detección por etapas: 4 conexiones nuevas en poco tiempo -> blacklist 10 días
add chain=input protocol=tcp dst-port=22,2222 connection-state=new src-address-list=ssh_stage3 action=add-src-to-address-list address-list=ssh_blacklist address-list-timeout=10d comment="SSH: stage3 -> blacklist"
add chain=input protocol=tcp dst-port=22,2222 connection-state=new src-address-list=ssh_stage2 action=add-src-to-address-list address-list=ssh_stage3 address-list-timeout=1m comment="SSH: stage2 -> stage3"
add chain=input protocol=tcp dst-port=22,2222 connection-state=new src-address-list=ssh_stage1 action=add-src-to-address-list address-list=ssh_stage2 address-list-timeout=1m comment="SSH: stage1 -> stage2"
add chain=input protocol=tcp dst-port=22,2222 connection-state=new src-address-list=!mgmt action=add-src-to-address-list address-list=ssh_stage1 address-list-timeout=1m comment="SSH: nueva conexion -> stage1"

# 3) Puertos de gestión solo desde la lista mgmt (ftp, ssh, telnet, www, winbox, api)
add chain=input protocol=tcp dst-port=21,22,23,80,443,2222,8291,8728,8729 src-address-list=!mgmt action=drop comment="Gestion solo desde mgmt"
