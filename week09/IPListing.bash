#/!bin/bash

# Checks for correct number of arguments
[ $# -ne 1 ] && echo "Usage: ${0} <Prefix>" && exit 1

# gets prefix
prefix=$1

# Verify prefix length
[ ${#prefix} -lt 5 ] && \
printf "Prefix length is too short\nPrefix example: 10.0.17\n" && \
exit 1

# Loop through all possible digits 1-254
for i in {1..254}
do
    # Check each ip address
    ping -c 1 "${prefix}.${i}" | grep "64 bytes" | \
    grep -o -E "[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}"
done
