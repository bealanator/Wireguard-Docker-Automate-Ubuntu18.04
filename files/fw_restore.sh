#!/usr/bin/env bash

iptables-restore /opt/firewall/v4.rules
ip6tables-restore /opt/firewall/v6.rules
