#!/usr/bin/env bash

user=$1

wireguard_keystore="/opt/wireguard/wireguard_keystore"

qrencode -t ansiutf8 < $wireguard_keystore/$user/$user.conf
