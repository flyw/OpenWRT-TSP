#!/bin/sh

# ./update_conf.sh [filename]

file="$1"

if [ $# -eq 0 ]
  then
    echo "Missing file: ./update_conf.sh [filename]"
    exit 0
fi

echo 'Generate /tmp/dnsmasq.d/gfwlist.conf...'
echo '' > /tmp/dnsmasq.d/gfwlist.conf
sed "s/.*/server=\/&\/127.0.0.1#55/" $file >> /tmp/dnsmasq.d/gfwlist.conf
sed "s/.*/ipset=\/&\/gfwlist/" $file >> /tmp/dnsmasq.d/gfwlist.conf

sed "s/.*/server=\/&\/127.0.0.1#55/" /root/TP4OpenW/lists/custom >> /tmp/dnsmasq.d/gfwlist.conf
sed "s/.*/ipset=\/&\/gfwlist/" /root/TP4OpenW/lists/custom >> /tmp/dnsmasq.d/gfwlist.conf

FILE=/root/custom.list
if test -f "$FILE"; then
  sed "s/.*/server=\/&\/127.0.0.1#55/" /root/custom.list >> /tmp/dnsmasq.d/gfwlist.conf
  sed "s/.*/ipset=\/&\/gfwlist/" /root/custom.list >> /tmp/dnsmasq.d/gfwlist.conf
fi

/etc/init.d/unbound restart
echo "Success."

