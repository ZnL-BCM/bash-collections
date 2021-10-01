OFS="\t" {for (f=1;f<=NF;f++) col[f] = col[f]OFS$f} END {for (f=1;f<=NF;f++) print col[f]}
