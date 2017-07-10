#!/bin/zsh

#############################
### GFI graphs
#############################

# Parameters
#ws="10000"
#ext="png"
#ol="/work/eg474423/ig440396_dendriticcells/local/results/gfi1graphs/"

# Histones - all
#sl="0.0173204999514,0.00435751232532,0.0168818725576,0.0165583998453,0.0067556137343,0.0336644489986,0.00486277340968,0.0043515451066,0.00509868686889,0.00433161619981,0.00496417922732,0.00538815875386"
#wLabels="CDP_H3K27me3,CDP_H3K9me3,CDP_h3k4me3,MPP_H3K27me3,MPP_H3K9me3,MPP_h3k4me3,cDC_H3K27me3,cDC_H3K9me3,cDC_h3k4me3,pDC_H3K27me3,pDC_H3K9me3,pDC_h3k4me3"
#wl="/hpcwork/izkf/projects/dendriticcells/data/zenke_histones/macs/"
#wList=$wl"CDP_WT_H3K27me3/CDP_WT_H3K27me3_treat_signal.bw,"$wl"CDP_WT_H3K9me3/CDP_WT_H3K9me3_treat_signal.bw,"$wl"CDP_WT_h3k4me3/CDP_WT_treat_signal.bw,"$wl"MPP_WT_H3K27me3/MPP_WT_H3K27me3_treat_signal.bw,"$wl"MPP_WT_H3K9me3/MPP_WT_H3K9me3_treat_signal.bw,"$wl"MPP_WT_h3k4me3/MPP_WT_treat_signal.bw,"$wl"cDC_WT_H3K27me3/cDC_WT_H3K27me3_treat_signal.bw,"$wl"cDC_WT_H3K9me3/cDC_WT_H3K9me3_treat_signal.bw,"$wl"cDC_WT_h3k4me3/cDC_WT_treat_signal.bw,"$wl"pDC_WT_H3K27me3/pDC_WT_H3K27me3_treat_signal.bw,"$wl"pDC_WT_H3K9me3/pDC_WT_H3K9me3_treat_signal.bw,"$wl"pDC_WT_h3k4me3/pDC_WT_treat_signal.bw"

# Histones - repress
#sl="0.0173204999514,0.00435751232532,0.0165583998453,0.0067556137343,0.00486277340968,0.0043515451066,0.00433161619981,0.00496417922732"
#wLabels="CDP_H3K27me3,CDP_H3K9me3,MPP_H3K27me3,MPP_H3K9me3,cDC_H3K27me3,cDC_H3K9me3,pDC_H3K27me3,pDC_H3K9me3"
#wl="/hpcwork/izkf/projects/dendriticcells/data/zenke_histones/macs/"
#wList=$wl"CDP_WT_H3K27me3/CDP_WT_H3K27me3_treat_signal.bw,"$wl"CDP_WT_H3K9me3/CDP_WT_H3K9me3_treat_signal.bw,"$wl"MPP_WT_H3K27me3/MPP_WT_H3K27me3_treat_signal.bw,"$wl"MPP_WT_H3K9me3/MPP_WT_H3K9me3_treat_signal.bw,"$wl"cDC_WT_H3K27me3/cDC_WT_H3K27me3_treat_signal.bw,"$wl"cDC_WT_H3K9me3/cDC_WT_H3K9me3_treat_signal.bw,"$wl"pDC_WT_H3K27me3/pDC_WT_H3K27me3_treat_signal.bw,"$wl"pDC_WT_H3K9me3/pDC_WT_H3K9me3_treat_signal.bw"

# Histones - repress no cdp H3K9me3
#sl="0.0173204999514,0.0165583998453,0.0067556137343,0.00486277340968,0.0043515451066,0.00433161619981,0.00496417922732"
#wLabels="CDP_H3K27me3,MPP_H3K27me3,MPP_H3K9me3,cDC_H3K27me3,cDC_H3K9me3,pDC_H3K27me3,pDC_H3K9me3"
#wl="/hpcwork/izkf/projects/dendriticcells/data/zenke_histones/macs/"
#wList=$wl"CDP_WT_H3K27me3/CDP_WT_H3K27me3_treat_signal.bw,"$wl"MPP_WT_H3K27me3/MPP_WT_H3K27me3_treat_signal.bw,"$wl"MPP_WT_H3K9me3/MPP_WT_H3K9me3_treat_signal.bw,"$wl"cDC_WT_H3K27me3/cDC_WT_H3K27me3_treat_signal.bw,"$wl"cDC_WT_H3K9me3/cDC_WT_H3K9me3_treat_signal.bw,"$wl"pDC_WT_H3K27me3/pDC_WT_H3K27me3_treat_signal.bw,"$wl"pDC_WT_H3K9me3/pDC_WT_H3K9me3_treat_signal.bw"

# Beds
#bLabels=( "MPP_CDP_PU1,GFI1" "CDC_PDC_PU1,GFI1" )
#bf1="/work/eg474423/ig440396_dendriticcells/exp/diffpeakdc/diff/res/"
#bf2="/hpcwork/izkf/projects/dendriticcells/data/gfi/macs/GSM786037_MLL-ENL_Gfi1/"
#bList=( $bf1"mpp_cdp_pu1.bed,"$bf2"GSM786037_MLL-ENL_Gfi1_peaks.bed" $bf1"cdc_pdc_pu1.bed,"$bf2"GSM786037_MLL-ENL_Gfi1_peaks.bed" )

# Execution
#for i in {1..$#bList}
#do
#    bsub -J $bLabels[$i]"_GFIG" -o $bLabels[$i]"_GFIG_out.txt" -e $bLabels[$i]"_GFIG_err.txt" -W 5:00 -M 12000 -S 100 -P izkf -R "select[hpcwork]" ./lineAndBoxByBed_pipeline.zsh $ws $sl $ext $bLabels[$i] $bList[$i] $wLabels $wList $ol
#done


#############################
### HMM TP/FP/TN/FN Profiling
#############################

# Parameters
ws="2000"
ext="png"
ol="/hpcwork/izkf/projects/egg/TfbsPrediction/Results/HMM/K562/Profiling/Slope/"
sl="1.0,1.0,1.0"
wLabels="DNase,H3K4me1,H3K4me3"
wl="/hpcwork/izkf/projects/egg/TfbsPrediction/Results/HMM/K562/InputSignal/"
wList=$wl"DNase_slope.bw,"$wl"H3K4me1_slope.bw,"$wl"H3K4me3_slope.bw"

# Variation
bedList=( "/hpcwork/izkf/projects/egg/TfbsPrediction/Results/HMM/K562/Profiling/Input/"*".bed" )

# Execution
for bedFile in $bedList
do
    splitSlash=(${(s:/:)bedFile})
    splitSlashLast=$splitSlash[-1]
    splitDot=(${(s/./)splitSlashLast})
    cn=$splitDot[1]
    bsub -J $cn"_PRF" -o $cn"_PRF_out.txt" -e $cn"_PRF_err.txt" -W 2:00 -M 12000 -S 100 -P izkf -R "select[hpcwork]" ./lineAndBoxByBed_pipeline.zsh $ws $sl $ext $cn $bedFile $wLabels $wList $ol
done


