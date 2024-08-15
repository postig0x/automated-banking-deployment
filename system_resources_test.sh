#!/bin/bash

# system_resources_test.sh
# check for system resources (memory, cpu, disk, etc)
# set up conditions for thresholds

# define thresholds
CPU_CAP=80

# use idle CPU% (awk $7) to calculate %CPU being used (bc IDLE - 100)
CPU_USAGE_PCT=$(top -bn1 | grep "Cpu(s)" | awk '{ print $7 }' | cut -d"," -f2 | xargs -I {} echo "{} - 100" | bc)

# get disk usage %
# NR > 1 skips the first line (header line from df)
# use awk at the end to sum up all the disk % to get total disk usage %
DISK_USAGE_PCT=$(df | awk 'NR > 1 { print $5 }' | cut -d'%' -f1 | awk '{ sum += $1 } END { print sum }')

echo "CPU USAGE: $CPU_USAGE_PCT%"
echo "DISK USAGE: $DISK_USAGE_PCT%"
