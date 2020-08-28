#!/bin/bash

echo "Usage: ./runScan.sh <rotation_start> <rotation_end> <rotation_increment> "
echo Rotation: Rotation from $1 to $2 with step $3

NCORES=15
IDX=1

if [ $# -ne 3 ]; then
	echo Invalid number of arguments: $#
	exit
fi

for i in `seq $1 $3 $2`; do
  nice -n 10 Gate -a "'[rotation,$i]'" main.mac > terminal_output.txt &
  PIDLIST="$PIDLIST $!"
  echo "Running: $i"

  if (( $IDX % $NCORES == 0 || $i ==$2 )); then
    echo "Waiting for (PIDS $PIDLIST)"
    time wait $PIDLIST
    unset PIDLIST
    IDX=1
  else
    IDX=$(( IDX+1 ))
  fi
done
