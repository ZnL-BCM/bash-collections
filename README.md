# bash-collections
## Zian Liu
### Last updated: 4/18/2022

This repository contains a collection of bash scripts I have written over the years but are small enough that they don't fit into individual repositories. 

See the following individual sections:

## Completed

These scripts are tested to work as intended. Listed by alphabetical order.

### bedchopper.awk

This is an AWK script that functions analogously to ``bedops --chop 1 <input_bed>``. This is useful when we want to cut a BED region to 1bp increments but don't have bedops installed (hopefully this never happens to you!).


### example_function.sh

This is a bash executable template that contains a basic example for how to write a functional executable.

Please feel free to use it as a template to build your custom functions. For help, run ``./example_function.sh -h`` for more information.

Requires python and numpy to be installed.


### gtf2bed.sh

Converts .gtf files into .bed files, with optional sorting and regions merging (requires *bedtools* for merging). 

Run ``./gtf2bed.sh -h`` for help.


### process_noncoding.sh

This is a two-step script that simultaneously 1) creates a temporary BED file that spans the entire lengths of chromosomes 1-22, X, and Y; and 2) removes BED coordinates from the previous temporary file to create BED coordinates for "noncoding background" regions of the human genome.

Although the output file for step 1 is automatically removed, you are welcomed to comment out the *rm* command to retain the file if you have other uses for it. 

Why this script? If you ever want to study the part of the human genome with no known annotations, this will come in handy. I have one submitted manuscript and another planned that revolve around the noncoding background genome.

For usage, run the following:
```
bash process_noncoding.sh hg38.fa out/noncoding "$(ls annotations/*.bed)"
```

Please be aware that the third input needs to be in double parentheses.


### slideshow.sh

Runs an image slideshow from a directory with feh, paired with a fancy mouse highlighter.

Requires [feh](https://github.com/derf/feh) and [highlight-pointer](https://github.com/swillner/highlight-pointer), both should be available on official/unofficial repos if you are using a linux-based system. 


### sumcounts_bycoord.sh

Concatenates, sorts, and adds records with duplicated genomic coordinates across certain fields. 

See the in-file comments for more description. This is meant for a Bismark (CpG) read file!

Credits to [this Unix and Linux Forum thread](https://www.unix.com/shell-programming-and-scripting/278229-do-replace-operation-awk-sum-multiple-columns-if-another-column-has-duplicate-values.html), I do not claim ownership to the script. 


### tictactoe executable

This is a linux executable that runs tic tac toe on your screen. The cross ("X") moves first. Only supports numerical input combinations of two values ranging from 1-3.


### transposer.awk / transposer_slow.awk

These are two awk scripts for transposing data; the first one is faster since it loads the entire data into RAM, while the second is theoretically slower but should work with larger datasets. These can be very helpful when it is impossible to install something like **rs** or **datamash** (a school cluster for example, *cough cough*)

Copied from [this Stack Overflow thread](https://stackoverflow.com/questions/1729824/an-efficient-way-to-transpose-a-file-in-bash) and I do not claim ownership to either script.


## Under development

These scripts are uploaded here but may not function correctly, use at your own risk.

### summary_stats.sh

Returns summary statistics (N, mean, stdev, percentiles) given an input list of numbers. This is a task that can be easily done in python/R; however, when external modules are not readily available, doing this with native bash commands can be advantageous. 

Note that this script takes inputs only from STDIN, and the percentiles are hard-coded to be "0 25 50 75 100" at this point. I will update this document if I come up with a way that can take inputs.

As an example, run the following:
```
echo -e "1\n2\n3\n4\n5\n6\n7\n8\n9" | bash summary_stats.sh
```

*Dependencies*: bash

## Usage

You are welcomed to re-use or re-distribute these scripts in any shape or form as you like.
