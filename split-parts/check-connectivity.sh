# test if the host has IPv4/IPv6 connectivity
IPV4_CHECK=$((ping -4 -c 1 -W 4 ipv4.google.com >/dev/null 2>&1 && echo true) || curl -s -4 -m 4 icanhazip.com 2> /dev/null)
IPV6_CHECK=$((ping -6 -c 1 -W 4 ipv6.google.com >/dev/null 2>&1 && echo true) || curl -s -6 -m 4 icanhazip.com 2> /dev/null)
