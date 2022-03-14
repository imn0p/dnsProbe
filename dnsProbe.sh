#!/bin/bash
x=4
if [ $# = 0 ]; then 
	echo "Usage: ./dnsProbe.sh [number of ping requests]";
	echo
	exit 1
	echo
	echo
fi;
if [ "$#" != "1" ] && [ "$#" != "0" ]; then
	echo $#
	echo "You just passed more than one argument"
	exit 1
fi;


touch /tmp/google
touch /tmp/cloudflare
while [ $(wc -l /tmp/google | awk '{print $1}') != "5" ]; do
	echo "Calculating Google DNS ping"
	ping -c "$x" -q 8.8.8.8 > /tmp/google;
	clear	
done;


while [ $(wc -l /tmp/cloudflare | awk '{print $1}') != "5" ]; do
	echo "Calculating CloudFlare DNS ping"
	ping -c "$x" -q 1.1.1.1 > /tmp/cloudflare;
	clear
done;
cloudflare=$(cat /tmp/cloudflare | tail -n 1 | awk '{print $5}' FS="/")
echo "CloudFlare DNS PING: $cloudflare ms"


google=$(cat /tmp/google | tail -n 1 | awk '{print $5}' FS="/")
echo "Google DNS PING: $google ms"

rm /tmp/google
rm /tmp/cloudflare
