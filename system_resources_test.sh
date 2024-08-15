#!/bin/bash

# system_resources_test.sh
# check for system resources (memory, cpu, disk, etc)
# set up conditions for thresholds

# define thresholds
CPU_CAP=80

# use idle CPU% (awk $7) to calculate %CPU being used (bc IDLE - 100)
CPU_USAGE_PCT=$(top -bn1 | grep "Cpu(s)" | awk '{ print $7 }' | cut -d"," -f2) | xargs -I {} echo "{} - 100" | bc

