#!/bin/zsh

# Global Parameters
ws="500"
ext="png"

#############################
### Mapped
#############################

# Parameters
ol="/work/eg474423/ig440396_dendriticcells/local/stemaging/graphs/mapped_results/"
bf="/work/eg474423/ig440396_dendriticcells/local/stemaging/graphs/mapped/"
blList="hypo,hyper"
bedList=$bf"hypo_mapped.bed,"$bf"hyper_mapped.bed"

# Variation
sl=( "1.0,1.0" "1.0,1.0" )
wl="/hpcwork/izkf/projects/stemaging/fibroblast/single_peaks_6/"
wList=( $wl"patient5_filtered_srt_no_duplicates/patient5_filtered_srt_no_duplicates_treat_signal.bw,"$wl"patient6_filtered_srt_no_duplicates/patient6_filtered_srt_no_duplicates_treat_signal.bw" $wl"patient7_filtered_srt_no_duplicates/patient7_filtered_srt_no_duplicates_treat_signal.bw,"$wl"patient8_filtered_srt_no_duplicates/patient8_filtered_srt_no_duplicates_treat_signal.bw" )
wLabels=( "patient5,patient6" "patient7,patient8" )

# Execution
for i in {1..$#wList}
do
    bsub -J $wLabels[$i]"_LBWD" -o $wLabels[$i]"_LBWD_out.txt" -e $wLabels[$i]"_LBWD_err.txt" -W 5:00 -M 12000 -S 100 -P izkf -R "select[hpcwork]" ./lineAndBoxByWigDiff_pipeline.zsh $ws $sl[$i] $ext $blList $bedList $wLabels[$i] $wList[$i] $ol
done


