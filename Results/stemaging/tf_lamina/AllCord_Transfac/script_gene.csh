bigBedToBed mpbs.bb mpbs.bed
grep "0,130,0" mpbs.bed > mpbs_filter.bed
grep EGR3 mpbs_filter.bed > EGR3.bed
grep EGR4 mpbs_filter.bed > EGR4.bed
grep EGR1 mpbs_filter.bed > EGR1.bed
grep ARNT mpbs_filter.bed > ARNT.bed

