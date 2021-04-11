# Luzifer-Docker / znc

This container setup contains a ZNC IRC bouncer setup with automatic config bootstrap support.

## Configuration

The container can be configured on first startup and should have a volume mounted at `/data`. If the file `/data/configs/znc.conf` does exist **all environment config is ignored**.

Available environment config:
- `LISTEN_PORT` - 16667 - Where to listen (you should not use 6667-6669 as modern browsers will block your access to them)
- `USE_IPV4` - true - Listen on IPv4 IPs
- `USE_IPV6` - true - Listen on IPv6 IPs
- `USER` - admin - Initial user to create
- `PASS` - <generated> - Password to set for the user (if auto-generated the password will be logged to STDERR)

After the initial startup you can configure the ZNC instance through the web-interface.
