# bash-collections
## Zian Liu
### Last updated: 12/30/2020

This repository contains a collection of bash scripts I have written over the years but are small enough that they don't fit into individual repositories. 

See the following individual sections:

## summary_stats.sh

Returns summary statistics (N, mean, stdev, percentiles) given an input list of numbers. This is a task that can be easily done in python/R; however, when external modules are not readily available, doing this with native bash commands can be advantageous. 

Note that this script takes inputs only from STDIN, and the percentiles are hard-coded to be "0 25 50 75 100" at this point. I will update this document if I come up with a way that can take inputs.

As an example, run the following:
```
echo -e "1\n2\n3\n4\n5\n6\n7\n8\n9" | bash summary_stats.sh
```

*Dependencies*: bash

## process_noncoding.sh

This is a two-step script that simultaneously 1) creates a temporary BED file that spans the entire lengths of chromosomes 1-22, X, and Y; and 2) removes BED coordinates from the previous temporary file to create BED coordinates for "noncoding background" regions of the human genome.

Although the output file for step 1 is automatically removed, you are welcomed to comment out the *rm* command to retain the file if you have other uses for it. 

Why this script? If you ever want to study the part of the human genome with no known annotations, this will come in handy. I have one submitted manuscript and another planned that revolve around the noncoding background genome.

For usage, run the following:
```
bash process_noncoding.sh hg38.fa out/noncoding "$(ls annotations/*.bed)"
```

Please be aware that the third input needs to be in double parentheses.

*Dependencies*: bash, bedtools/2.29.2


## Usage

You are welcomed to re-use or re-distribute these scripts in any shape or form as you like.
