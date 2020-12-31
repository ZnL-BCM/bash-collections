# !/bin/bash
# summary_stats.sh
# A simple bash script to return summary statistics from STDIN


# Note that we need to redirect stdin, remove empty lines, and sort numerically first.
# Then, the awk script begins.
cat /dev/stdin | sed '/\S/!d' | sort -n |\
awk -v lines=$linec '
  BEGIN {
    sum=0
    perc[1]=0; perc[2]=25; perc[3]=50; perc[4]=75; perc[5]=100
  }
  {
    sum+=$0
    vals[NR]=$0
  }
  END {
    mean=(sum/NR)

    var=0
    for (i=1; i<=NR; i++) { var += ((vals[i] - mean)*(vals[i] - mean) / (NR - 1)) }

    for (j=1; j<=5; j++) {
      q=((NR-1)*(perc[j]/100)+1); l=int(q); mod=(q-l)
      qv[j]=(vals[l] + (vals[l+1] - val[l]) * mod)
    }

    print "N\tmean\tvar\t"perc[1]"perc\t"perc[2]"perc\t"perc[3]"perc\t"perc[4]"perc\t"perc[5]"perc"
    print NR"\t"mean"\t"var"\t"qv[1]"\t"qv[2]"\t"qv[3]"\t"qv[4]"\t"qv[5]
  }
'
