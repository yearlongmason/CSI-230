#/!bin/bash

ip addr | awk '{print $2}' | \
grep -o -E "[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}" | \
grep -v -E "127|255"
