#!/bin/bash
set -eu

maincfg=/data/configs/znc.conf

[[ -f $maincfg ]] || {
  echo "WARNING: No configuration file found, will generate the default config now..." >&2

  password_salt="$(tr -dc 'A-Za-z0-9!?.,:;/*-+_()' </dev/urandom | head -c 20)"
  password=${PASS:-}
  [[ -n $password ]] || {
    password="$(tr -dc 'A-Za-z0-9!?.,:;/*-+_()' </dev/urandom | head -c 32)"
    echo "WARNING: Empty password detected, auto-generated password is used for ${USER:-admin}: ${password}" >&2
  }

  mkdir -p "$(dirname "${maincfg}")"
  korvike -o "${maincfg}" <<EOF
HideVersion = true
LoadModule = webadmin
Skin = dark-clouds
Version = 1.8.2

<Listener l>
  Port = {{  env "LISTEN_PORT" | default "16667" }}
  IPv4 = {{  env "USE_IPV4" | default "true" }}
  IPv6 = {{  env "USE_IPV6" | default "true" }}
  SSL = false
</Listener>

<User {{  env "USER" | default "admin" }}>
  Admin      = true
  Nick       = {{  env "USER" | default "admin" }}
  AltNick    = {{  env "USER" | default "admin" }}_
  Ident      = {{  env "USER" | default "admin" }}
  LoadModule = chansaver
  LoadModule = controlpanel

  <Pass password>
    Hash = {{ sha256sum "${password}${password_salt}" }}
    Method = SHA256
    Salt = ${password_salt}
  </Pass>
</User>
EOF
}

chown -R znc:znc /data
exec gosu znc znc -d /data -f
