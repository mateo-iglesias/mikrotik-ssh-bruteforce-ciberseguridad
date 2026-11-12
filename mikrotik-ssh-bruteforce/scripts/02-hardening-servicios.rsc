# 02 - Endurecer servicios de gestión
# ACTIVA SAFE MODE ANTES (Ctrl+X). Cambia 192.168.88.0/24 por tu red de gestión.

# Apagar servicios que no se usan
/ip service
disable telnet,ftp,www,api,api-ssl

# SSH y Winbox solo desde la red de gestión; SSH en otro puerto
set ssh port=2222 address=192.168.88.0/24
set winbox address=192.168.88.0/24

# Criptografía fuerte en SSH
/ip ssh
set strong-crypto=yes

# Descubrimiento y acceso por MAC solo en LAN (requiere la interface-list LAN)
/ip neighbor discovery-settings
set discover-interface-list=LAN
/tool mac-server
set allowed-interface-list=none
/tool mac-server mac-winbox
set allowed-interface-list=LAN

# Servicios que suelen abusarse si quedan activos
/tool bandwidth-server
set enabled=no
/ip socks
set enabled=no
/ip proxy
set enabled=no

# Usuario admin: crea primero tu propio usuario full y comprueba que entras con él
# /user add name=TU_USUARIO group=full password="CONTRASEÑA_LARGA"
# /user disable admin
