#!/bin/zsh

# Global Parameters
ext="png"
useAllNegative="y"

#############################
### Signatures vs Histones
#############################

# Parameters
ol="/work/eg474423/ig440396_dendriticcells/local/stemaging/graphs/fibroblast_results_all/"
bedFile="/hpcwork/izkf/projects/stemaging/lamina_hg19_filtered.bed"
bedLabel="LaminaHG19filtered"
csf="/hpcwork/izkf/projects/stemaging/fibroblast/single_peaks/hg19.chrom.sizes2"

# Variation
#sl=( "0.065771131" "0.082799621" "0.090301485" "0.062377802" )
sl=( "1.0" "1.0" "1.0" "1.0" )
wl="/hpcwork/izkf/projects/stemaging/fibroblast/single_peaks/"
wList=( $wl"patient5"*"/"*".bw" $wl"patient6"*"/"*".bw" $wl"patient7"*"/"*".bw" $wl"patient8"*"/"*".bw" )
wLabels=( "patient5" "patient6" "patient7" "patient8" )

# Execution
for i in {1..$#wList}
do
    bsub -J $wLabels[$i]"_BBX" -o $wLabels[$i]"_BBX_out.txt" -e $wLabels[$i]"_BBX_err.txt" -W 20:00 -M 12000 -S 100 -P izkf -R "select[hpcwork]" ./boxplotWithRandom_pipeline.zsh $useAllNegative $sl[$i] $ext $bedLabel $bedFile $wLabels[$i] $wList[$i] $csf $ol
done


