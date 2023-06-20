#!/bin/bash
if [ ! -f /usr/local/squid/var/cache/squid/ssl_db ]; then
    /usr/local/squid/libexec/security_file_certgen -c -s /usr/local/squid/var/cache/squid/ssl_db -M 20MB
fi

/usr/local/squid/sbin/squid -Nz
/usr/local/squid/sbin/squid -NYC
