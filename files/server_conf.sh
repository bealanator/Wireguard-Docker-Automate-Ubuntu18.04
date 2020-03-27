#!/usr/bin/env bash

listen_port=$1
keystore_path="/opt/wireguard/wireguard_keystore"

printf "[Interface]
Address = 10.254.254.1/24, fdbd:ff5e:07a2:ff9c::1/64
ListenPort = $listen_port
PrivateKey = $( cat $keystore_path/server/privatekey )

PostUp = iptables -A FORWARD -i wg0 -j ACCEPT; iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE ; ip6tables -A FORWARD -i wg0 -j ACCEPT; \
ip6tables -t nat -A POSTROUTING -o eth0 -j MASQUERADE\n" > /opt/wireguard/conf_dir/wg0.conf

chmod 660 /opt/wireguard/conf_dir/wg0.conf
