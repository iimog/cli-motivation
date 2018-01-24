#!/bin/bash

# A POSIX variable
OPTIND=1         # Reset in case getopts has been used previously in the shell.

# Initialize our own variables:
outdir="data"
n=10

while getopts "h?n:o:" opt; do
    case "$opt" in
    h|\?)
	echo "USAGE: create_folder_structure.sh -n 100 -o data Jan Niklas Ludwig"
        exit 0
        ;;
    n)  n=$OPTARG
        ;;
    o)  outdir=$OPTARG
        ;;
    esac
done

shift $((OPTIND-1))

[ "$1" = "--" ] && shift

mkdir -p $outdir
for name in $@
do
	for i in $(seq 1 $n) 
	do
		hash=$(echo $RANDOM | md5sum | head -c 4)
		touch ${outdir}/${hash}_${name}.csv
		touch ${outdir}/${hash}_${name}.png
		shuf bavaria_ipsum.txt | head -n 15 >${outdir}/${hash}_${name}.txt
		if [[ $RANDOM < $RANDOM ]]; then echo SUCCESS; else echo FAIL; fi >>${outdir}/${hash}_${name}.txt
	done
done
