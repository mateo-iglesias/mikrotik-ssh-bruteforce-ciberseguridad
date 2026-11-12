# 01 - Bloquear la IP atacante y su red
# RouterOS v6/v7

/ip firewall address-list
add list=blacklist address=176.53.159.197 comment="SSH brute force - AS154383 TR - 2026-11-12"
add list=blacklist address=176.53.159.0/24 comment="Red AS154383 con reportes de SSH brute force"

# Drop en RAW: se descarta antes del connection tracking (menos carga de CPU)
/ip firewall raw
add chain=prerouting src-address-list=blacklist action=drop comment="Drop blacklist"
