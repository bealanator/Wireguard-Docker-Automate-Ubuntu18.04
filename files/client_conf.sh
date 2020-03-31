#!/usr/bin/env bash

user=$1
endpoint=$2
listen_port=$3
dns=$4

keystore_path="/opt/wireguard/wireguard_keystore"

peer_count=$( grep -i peer /opt/wireguard/conf_dir/wg0.conf | wc -l )
peer_count=$(( peer_count + 2 ))
allowed_ipv6=$( python3 /opt/wireguard/ipv6_gen.py "$peer_count" )
allowed_ipv4=$(( peer_count ))

# Add client to wireguard config
printf "\n[Peer]
PublicKey = $( cat $keystore_path/$user/publickey )
PresharedKey = $( cat $keystore_path/$user/preshared )
AllowedIPs = 10.254.254.$allowed_ipv4/32, fdbd:ff5e:07a2:ff9c::$allowed_ipv6/128\n" >> /opt/wireguard/conf_dir/wg0.conf

# Gen client conf
printf "[Interface]
Address = 10.254.254.$allowed_ipv4/24, fdbd:ff5e:07a2:ff9c::$allowed_ipv6/64
PrivateKey = $( cat $keystore_path/$user/privatekey )
DNS = $dns

[Peer]
PublicKey = $( cat $keystore_path/server/publickey )
PresharedKey = $( cat $keystore_path/$user/preshared )
AllowedIPs = 0.0.0.0/0, ::/0
Endpoint = $endpoint:$listen_port\n" > $keystore_path/$user/$user.conf
