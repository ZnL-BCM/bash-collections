#!/bin/bash
# Simple script to show image slides with a pointer highlighter overlay 

SlideDir=''
Size=5
ColorReleased='#d62728'
ColorPressed='#1f77b4'

print_help() {
  echo "Use -i for input directory, -s for size of pointers, and -r|-p for released/pressed colors in hex code with #."
  exit
}

while getopts i:s:r:p: flag
do 
  case "${flag}" in
    i) SlideDir=${OPTARG};;
    s) Size=${OPTARG};;
    r) ColorReleased=${OPTARG};;
    p) ColorPressed=${OPTARG};;
    #h) print_help;;
    *) print_help;;
  esac
done


trap "kill 0" EXIT   # Runs background commands until script exits

  # Calls a highlighter
  highlight-pointer -r $Size -c $ColorReleased -p $ColorPressed &

  # Main script
  feh $SlideDir; exit

wait
