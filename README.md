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


## Usage

You are welcomed to re-use or re-distribute these scripts in any shape or form as you like.
