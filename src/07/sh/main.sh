#!/bin/bash
# Solution for Advent of Code 2022 day 7.
set -euo pipefail

input="/home/kali/CLionProjects/untitled1/input"

totalSum=0
declare -A map                               # Define dictionary
declare -A line                               # Define dictionary
map["/"]=0                                   # dict of dir sizes
pwd="/"                                      # dir we are at; response to command pwd
file=""                                      # dir+file we are looking; pwd/file
while read -rA txt; do
  line[0]=${txt:0:1}
  line[1]=${txt:1:1}
  line[2]=${txt:2:1}
  line[3]=${txt:3:1}
  if [[ "${line[0]}" == "$" ]]; then           # IF $
    if [[ "${line[1]}" == "$ cd" ]]; then      # IF $ cd
      if [[ "${line[2]}" == "$ cd .." ]]; then # IF $ cd ..
        pwd=${pwd%/*}                        # remove everything that comes after last `/`
      else                                   # ELSE $ cd {folder}
        pwd+="/${line[3]}"                   # pwd+=/{folder}
      fi                                     # END IF
    fi                                       # END IF
  elif [[ "${line[0]}" == "dir" ]]; then                                       # ELSE
    file="$pwd/${line[1]}"                 # file = pwd+/{folder}
    if [[ -v ${map[$file]} ]]; then          # if map contains `file`
      map[$file]=0                         # value of key file = 0
    fi                                     # END IF
  else                                     # ELSE
    a=${map[$pwd]}                          # a = size of the current path
    b=${line[0]}                           # b = size of the current file
    map[$pwd]=$((a + b))                   # map[current path] =
    file=${pwd%/*}                         # remove everything that comes after last `/`
    set +u                                 # treat unset variables as NOT an error
    while [ ${#file} -gt 0 ]; do           # WHILE file > 0 TODO
      a=${map[$file]}                      # a = map[file]; value of key
      b=${line[0]}                         # b = size of the file
      map[$file]=$((a + b))                # value of file = dir size + file size
      file=${file%/*}                      # remove current file
    done                                   #
    set -u                                 # treat unset variables as an error
  fi                                       # END IF
done <"$input"                               #
echo "$totalSum"                             # PRINT totalSum
total=0

# There is some weird bug here `"${!map[@]}"` !!!
for k in "${!map[@]}"; do
    val=${map[$k]}
    if [[ $val -le 100000 ]]; then
        total=$((total+val))
    fi
done
echo "Total <100,000: "$total