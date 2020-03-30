# Wireguard-Docker-Automate-Ubuntu18.04

Ansible playbook to install Wireguard inside a Docker container onto a fresh Ubuntu 18.04 server.
Features full IPv4/IPv6 support and host firewall will be configured to allow 22/tcp, icmp (IPv4 & IPv6). 
All other incoming traffic will be dropped.

## Pre-Requesites

Ubuntu 18.04 server with the following:
- Ubuntu 18.04
- SSH enabled & port 22 open.
- Python installed
- SSH Keys configured for your user
  - Or sshpass installed if not using keys
- User added to sudoers

Ansible will also need installed on a remote or local machine. It can also be installed on the target Ubuntu 18.04 server if installing to itself.

## Installation
Clone/download repo, cd into the directory. Edit wireguard_docker_deploy.yml
```yaml
  vars:
    ansible_user: "user"
    #uncomment and install sshpass if not using SSH keys
    #ansible_password: "ssh_password"
    ansible_become_pass: "sudo_password"
  roles:
    - role: "{{ playbook_dir }}"
      vars:
        # Surround in [] if using IPv6 address.
        # Example: [2000:1234::33]
        endpoint: "server_ip_or_hostname"
        # First usable will be taken for docker network
        private_ipv4_network: "192.168.254.0"
        private_ipv4_wireguard_address: "192.168.254.2"
        private_ipv4_netmask: "24"
        server_ipv6_prefix: "2000::XXXX"
        docker_ipv6_net_cidr: "124"
        wireguard_ipv6: "2000::XXX2"
        dns: "desired_client_dns"
        listen_port: 51820
        # Change based on what your Ubuntu install shows
        # from `ip a`
        network_dev: "ens3"
        arch: "amd64"
        users:
          - "user1"
          - "user2"
          - "user3"
          - "user4"
```
Change users list, ansible_user, ansible_become_pass, endpoint, and dns, server_ipv6_prefix, wireguard_ipv6 to fit your needs.
If installing on Raspberry Pi or any non amd64 system, change arch as well.

- armhf: 32-bit Raspberry Pi
- arm64: 64-bit Rasbperry Pi

Next, edit hosts:
```yaml
[wireguard]
# Change to your IP. Set to localhost if installing on local machine
10.10.10.10
```
Change 10.10.10.10 to your server IP. If doing multiple, separate them by a
new line. If installing on the local machine, change the IP to localhost.

Run the following (inside the cloned/downloaded directory):
```bash
ansible-playbook -i hosts wireguard_docker_deploy.yml
```

## Client configuration
All client configs are stored in /opt/wireguard/wireguard_keystore in a folder corresponding with the usernames specified 
in wireguard_docker_deploy.yml.

The configs can be copied & used as is, or for smartphones or any Wireguard app that can read qr codes, run the following from anywhere:

```bash
wireguard-qrgen <username>
```

This will generate a QR Code that can be scanned to create the client profile.

## Updating Docker image
In the /opt/wireguard there is a script called build_image.sh

Simply run the following (as root) to upgrade Wireguard and other packages in the container:

```bash
sudo docker stop wireguard
sudo docker rm wireguard
sudo /opt/wireguard/build_image.sh
sudo /opt/wireguard/start.sh
```

This will stop the running wireguard container, remove the container, and re-build the image (without using the cache) 
and will then restart the container.
