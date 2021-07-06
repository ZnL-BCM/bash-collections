#!/bin/bash
# Sorts and combines read files based on common coordinates

Out=$1
In=$2
echo "Input files: "$In
echo "Output file: "$Out

# The first three lines combines, uncomments, 
# amd sorts the input data.
# then, notice that IF fields 1 and 2 are duplicated, 
# the script will add up fields 5, 6, and 7, 
# and then re-calculate field 8 which is a division.
# This is meant for a bisulfite sequencing read file (from Bismark) FYI
# Note that the sort command is NECESSARY. 
# If sort is too slow, add the option -S 50% (50% virtual memory buffering)

cat $In |\
  grep -v "#" |\
  sort -k1,1 -k2,2n |\
  awk -v OFS="\t" 'BEGIN{ FS = OFS = "\t" }
    NR > 1{
      if (($1 == f1) && ($2 == f2)) {
        $5 += f5; $6 += f6; $7 += f7; $8 = ($6/$5)
      } else { print rec }
    }
    {
      rec = $0; f1 = $1; f2 = $2; f5 = $5; f6 = $6; f7 = $7
    }
    END{ print rec }' > $Out

echo "Done."
