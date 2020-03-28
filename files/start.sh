#!/usr/bin/env bash

docker run --network host --detach --sysctl net.ipv6.conf.all.disable_ipv6=0 --sysctl net.ipv6.conf.all.forwarding=1 -v /opt/wireguard/conf_dir:/etc/wireguard --cap-add net_admin --cap-add sys_module --restart=always --name wireguard wireguard
