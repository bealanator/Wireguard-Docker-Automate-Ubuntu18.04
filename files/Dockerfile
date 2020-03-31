FROM ubuntu

Run apt-get update
Run apt-get install -y --no-install-recommends --no-install-suggests software-properties-common iproute2 iptables
Run add-apt-repository ppa:wireguard/wireguard
Run apt-get update
Run apt-get install -y --no-install-recommends --no-install-suggests wireguard

Copy wg_start.sh /

CMD ["/wg_start.sh"]

