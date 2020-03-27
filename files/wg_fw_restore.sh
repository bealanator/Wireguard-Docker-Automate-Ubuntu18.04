#!/usr/bin/env bash

iptables -I INPUT -p udp --dport 51820 -j ACCEPT
ip6tables -I INPUT -p udp --dport 51820 -j ACCEPT

