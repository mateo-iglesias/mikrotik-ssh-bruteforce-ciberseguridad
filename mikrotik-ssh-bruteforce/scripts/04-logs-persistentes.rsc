# 04 - Logs persistentes
# Por defecto el log vive en RAM (1000 líneas) y se pierde al reiniciar.

# Más líneas en memoria
/system logging action
set memory memory-lines=5000

# Guardar en disco los eventos de acceso y errores
set disk disk-file-name=log-seguridad disk-lines-per-file=5000 disk-file-count=3
/system logging
add topics=account action=disk
add topics=critical action=disk

# Opcional: enviar a un servidor syslog remoto (cambiar IP)
# /system logging action add name=syslog target=remote remote=192.168.88.10 remote-port=514
# /system logging add topics=account action=syslog
# /system logging add topics=critical action=syslog
