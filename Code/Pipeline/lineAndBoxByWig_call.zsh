#!/bin/zsh

# Global Parameters
ws="10000"
ext="png"

#############################
### Signatures vs Histones
#############################

# Parameters
#ol="/work/eg474423/ig440396_dendriticcells/local/stemaging/graphs/signatures_results/"
#bf="/work/eg474423/ig440396_dendriticcells/local/stemaging/graphs/signatures/"
#blList="fibroblasts_f6_hyper,fibroblasts_f6_hypo,fibroblasts_f8_hyper,fibroblasts_f8_hypo,koch_senescence_hyper,koch_senescence_hypo"
#bedList=$bf"fibroblasts_f6_hyper.txt,"$bf"fibroblasts_f6_hypo.txt,"$bf"fibroblasts_f8_hyper.txt,"$bf"fibroblasts_f8_hypo.txt,"$bf"koch_senescence_hyper.txt,"$bf"koch_senescence_hypo.txt"

# Variation
##sl=( "0.018452122" "0.031085193" "0.011894685" "0.022192739" "0.011069611" "0.007285278" "0.007863781" )
#sl=( "1.0" "1.0" "1.0" "1.0" "1.0" "1.0" "1.0" )
#wl="/hpcwork/izkf/projects/stemaging/Data/histone-fibroblast/"
#wList=( $wl"Chromatin_Accessibility/DS18229.bw" $wl"Chromatin_Accessibility/DS18252.bw" $wl"Histone_H3K4me1/H3K4me1_treat_signal.bw" $wl"Histone_H3K4me3/H3K4me3_treat_signal.bw" $wl"Histone_H3K9me3/H3K9me3_treat_signal.bw" $wl"Histone_H3K27me3/H3K27me3_treat_signal.bw" $wl"Histone_H3K36me3/H3K36me3_treat_signal.bw" )
#wLabels=( "DNase_DS18229" "DNase_DS18252" "H3K4me1" "H3K4me3" "H3K9me3" "H3K27me3" "H3K36me3" )

# Execution
#for i in {1..$#wList}
#do
#    bsub -J $wLabels[$i]"_SIG" -o $wLabels[$i]"_SIG_out.txt" -e $wLabels[$i]"_SIG_err.txt" -W 2:00 -M 12000 -S 100 -P izkf -R "select[hpcwork]" ./lineAndBoxByWig_pipeline.zsh $ws $sl[$i] $ext $blList $bedList $wLabels[$i] $wList[$i] $ol
#done


#############################
### Lamina vs Methylation
#############################

# Parameters
#ol="/work/eg474423/ig440396_dendriticcells/local/stemaging/graphs/lamina_results/"
#bf="/work/eg474423/ig440396_dendriticcells/local/stemaging/graphs/lamina/"
#blList="lamina_end_border,lamina_front_border,lamina_merge"
#bedList=$bf"lamina_end_border.bed,"$bf"lamina_front_border.bed,"$bf"lamina_merge.bed"

# Variation
##sl=( "0.065771131" "0.082799621" "0.090301485" "0.062377802" )
#sl=( "1.0" "1.0" "1.0" "1.0" )
#wl="/hpcwork/izkf/projects/stemaging/fibroblast/single_peaks/"
#wList=( $wl"patient5"*"/"*".bw" $wl"patient6"*"/"*".bw" $wl"patient7"*"/"*".bw" $wl"patient8"*"/"*".bw" )
#wLabels=( "patient5" "patient6" "patient7" "patient8" )

# Execution
#for i in {1..$#wList}
#do
#    bsub -J $wLabels[$i]"_LAM" -o $wLabels[$i]"_LAM_out.txt" -e $wLabels[$i]"_LAM_err.txt" -W 2:00 -M 12000 -S 100 -P izkf -R "select[hpcwork]" ./lineAndBoxByWig_pipeline.zsh $ws $sl[$i] $ext $blList $bedList $wLabels[$i] $wList[$i] $ol
#done


#############################
### Lamina vs Histones
#############################

# Parameters
#ol="/work/eg474423/ig440396_dendriticcells/local/stemaging/graphs/lamborder_histone_results/"
#bf="/work/eg474423/ig440396_dendriticcells/local/stemaging/graphs/lamina/"
#blList="lamina_end_border,lamina_front_border,lamina_merge"
#bedList=$bf"lamina_end_border.bed,"$bf"lamina_front_border.bed,"$bf"lamina_merge.bed"

# Variation
##sl=( "0.018452122" "0.031085193" "0.011894685" "0.022192739" "0.011069611" "0.007285278" "0.007863781" )
#sl=( "1.0" "1.0" "1.0" "1.0" "1.0" "1.0" "1.0" )
#wl="/hpcwork/izkf/projects/stemaging/Data/histone-fibroblast/"
#wList=( $wl"Chromatin_Accessibility/DS18229.bw" $wl"Chromatin_Accessibility/DS18252.bw" $wl"Histone_H3K4me1/H3K4me1_treat_signal.bw" $wl"Histone_H3K4me3/H3K4me3_treat_signal.bw" $wl"Histone_H3K9me3/H3K9me3_treat_signal.bw" $wl"Histone_H3K27me3/H3K27me3_treat_signal.bw" $wl"Histone_H3K36me3/H3K36me3_treat_signal.bw" )
#wLabels=( "DNase_DS18229" "DNase_DS18252" "H3K4me1" "H3K4me3" "H3K9me3" "H3K27me3" "H3K36me3" )

# Execution
#for i in {1..$#wList}
#do
#    bsub -J $wLabels[$i]"_LAMH" -o $wLabels[$i]"_LAMH_out.txt" -e $wLabels[$i]"_LAMH_err.txt" -W 2:00 -M 12000 -S 100 -P izkf -R "select[hpcwork]" ./lineAndBoxByWig_pipeline.zsh $ws $sl[$i] $ext $blList $bedList $wLabels[$i] $wList[$i] $ol
#done


#############################
### Lamina vs Histones
#############################

# Parameters
#ol="/work/eg474423/ig440396_dendriticcells/local/stemaging/graphs/rna_seq_plotFiles/"
#bf="/work/eg474423/ig440396_dendriticcells/local/stemaging/graphs/lamina/"
#blList="lamina_end_border,lamina_front_border,lamina_merge"
#bedList=$bf"lamina_end_border.bed,"$bf"lamina_front_border.bed,"$bf"lamina_merge.bed"

# Variation
#sl=( "1.0" "1.0" "1.0" "1.0" "1.0" "1.0" )
#wl="/hpcwork/izkf/projects/stemaging/edu/rna_seq_bw/"
#wList=( $wl"C1HY5ACXX_A_P4.bw" $wl"C1HY5ACXX_A_P13.bw" $wl"C1HY5ACXX_B_P4.bw" $wl"C1HY5ACXX_B_P13.bw" $wl"C1HY5ACXX_C_P4.bw" $wl"C1HY5ACXX_C_P13.bw" )
#wLabels=( "C1HY5ACXX_A_P4" "C1HY5ACXX_A_P13" "C1HY5ACXX_B_P4" "C1HY5ACXX_B_P13" "C1HY5ACXX_C_P4" "C1HY5ACXX_C_P13" )

# Execution
#for i in {1..$#wList}
#do
#    bsub -J $wLabels[$i]"_LAMR" -o $wLabels[$i]"_LAMR_out.txt" -e $wLabels[$i]"_LAMR_err.txt" -W 2:00 -M 12000 -S 100 -P izkf -R "select[hpcwork]" ./lineAndBoxByWig_pipeline.zsh $ws $sl[$i] $ext $blList $bedList $wLabels[$i] $wList[$i] $ol
#done


