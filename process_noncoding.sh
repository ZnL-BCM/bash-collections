# !/bin/bash
# Gets the noncoding region based on given annotations and exclusion regions

echo "Genome: "$1
echo "Output filename: "$2
echo "All annotations to exclude: "$3

# First, create a mock bed file that spans the whole length of the genome by chopping the fasta genome. 
# The first scratch extracts the chromosomes
grep ">" $1 | sed 's/>//g' > $2_scratch1
# The second scratch extracts the chromosome length, this is a little lengthier:
awk '/^>/ {
      if (seqlen) {print "0\t"seqlen}
        print; seqlen=0; next
    }
    {
      seqlen += length($0)
    } END {
      print "0\t"seqlen
    }' $1 | grep -v ">" > $2_scratch2
# The third scratch concatenates the previous two to form a chromosomal BED file.
# Note that we also want to remove the miscellaneous chromosomes in this step:
paste $2_scratch1 $2_scratch2 |\
   awk '$1 ~ /^chr[0-9,XY]+$/' > $2_scratch3
# Remove scratch1 and scratch2
rm $2_scratch1
rm $2_scratch2

# Next, merge all aforementioned BED regions, and subtract them from the third scratch
# Note that we need to remove certain chromosomes!
cat $3 | cut -f1-3 |\
    bedtools sort -i stdin |\
    bedtools merge -i stdin |\
    bedtools subtract -a $2_scratch3 -b stdin > $2_background.bed
# Remove scratch3
rm $2_scratch3

echo "Done."
