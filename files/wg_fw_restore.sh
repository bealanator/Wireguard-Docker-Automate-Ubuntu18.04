#!/usr/bin/env bash

iptables -A INPUT -m conntrack --ctstate RELATED,ESTABLISHED -j ACCEPT
iptables -A INPUT -i lo -j ACCEPT
iptables -A INPUT -p icmp -j ACCEPT
iptables -A INPUT -p tcp -m tcp --dport 22 -j ACCEPT
iptables -A INPUT -p udp --dport 51820 -j ACCEPT

ip6tables -A INPUT -p udp --dport 51820 -j ACCEPT
ip6tables -A INPUT -m conntrack --ctstate RELATED,ESTABLISHED -j ACCEPT
ip6tables -A INPUT -i lo -j ACCEPT
ip6tables -A INPUT -p icmp -j ACCEPT
ip6tables -A INPUT -p tcp -m tcp --dport 22 -j ACCEPT
ip6tables -A INPUT -p udp --dport 51820 -j ACCEPT

ip6tables -t nat -A POSTROUTING -s fdd6:89cb:ea4c:32e5::/64 ! -o docker0 -j MASQUERADE
