#!/bin/bash
# Converts .gtf to .bed formats


function help (){
  echo -e "Converts .gtf inputs into .bed outputs.\n"
  echo -e "-i | --input: Input gtf file (can be stdin if entered -, stdin, or STDIN)"
  echo -e "-o | --output: Output bed file"
  echo -e "-s | --sort: Sorts output file"
  echo -e "-m | --merge: Merges output file (requires bedtools package)"
  exit 0
}

if [[ $# -eq 0 ]]; then help; fi

while [ ! -z "$1" ]; do
case "$1" in
  -h|--help)
    help;;
  -i|--input)
    shift; In="$1";;
  -o|--output)
    shift; Out="$1";;
  -s|--sort)
    sortflag=1;;
  -m|--merge)
    mergeflag=1;;
*)
echo -e "Incorrect input provided! \nThe remaining inputs are $@; show help: \n"
help
esac
shift
done


echo "Input file: "$In
echo "Output file: "$Out

if [[ $In == "-" ]] || [[ $In == "stdin" ]] || [[ $In == "STDIN" ]]; then
  In="/dev/stdin"
fi

sortcommand='cat -'
if [[ $sortflag == "1" ]]; then
  sortcommand='sort -k1,1 -k2,2n -'
fi

mergecommand='cat -'
if [[ $mergeflag == "1" ]]; then
  mergecommand='bedtools merge -i stdin'
fi


grep -v "#" $In |\
  awk -v OFS="\t" '{print $1,$4-1,$5,$3,$6,$7}' |\
  $sortcommand |\
  $mergecommand > $Out

