#!/usr/bin/env bash

user=$1
keystore_path="/opt/wireguard/wireguard_keystore"
mkdir $keystore_path/$user/
cd $keystore_path/$user/
umask 077; wg genkey | tee privatekey | wg pubkey > publickey ; wg genpsk > preshared
