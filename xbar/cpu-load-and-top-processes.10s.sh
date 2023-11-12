#!/usr/bin/env bash

# <xbar.title>CPU Load & top processes</xbar.title>
# <xbar.version>v1.0</xbar.version>
# <xbar.author>Pierre-Adrien Buisson</xbar.author>
# <xbar.author.github>pabuisson</xbar.author.github>
# <xbar.desc>Shows CPU load as a percentage & the 5 most CPU-consuming processes</xbar.desc>
# <xbar.image></xbar.image>
# <xbar.dependencies>bash</xbar.dependencies>

ncpu=$(sysctl -n hw.logicalcpu)
total=$(ps -Ao %cpu= | paste -sd+ - | bc)
usage=$(echo "$total / $ncpu" | bc)

# ps c: print only the process name, not its whole path
# tail -n +2: keep output starting from 2nd line
# awk: $1 references 1st field, $2 nd field, etc
# tail -n +5: remove the last empty line caused by the \n
# TODO: display an emoji if cpu > 100%
top_processes=$(ps auxc | tail -n +2 | head -n 5 | awk '{printf("%s %% :: %s\n", $3, $11)}')

printf "CPU: %0.1f%%\n" "$usage"
echo "---"
echo -e "$top_processes"
