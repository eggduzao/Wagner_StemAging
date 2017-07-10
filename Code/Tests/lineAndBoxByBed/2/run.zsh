#!/bin/zsh

#wLabels="cDC_WT_H3K4me3,cDC_WT_H3K9me3,cDC_WT_H3K27me3"
#wl="/hpcwork/izkf/projects/dendriticcells/data/zenke_histones/macs/"
#wList=$wl"cDC_WT/cDC_WT_treat_signal.bw,"$wl"MPP_KO/MPP_KO_treat_signal.bw,"$wl"MPP_WT/MPP_WT_treat_signal.bw"

wLabels="cDC_WT_H3K4me3,cDC_WT_H3K9me3,cDC_WT_H3K27me3"
wl="/hpcwork/izkf/projects/dendriticcells/data/zenke_histones/bw/"
wList=$wl"cDC_WT_H3K4me3_L36bp.am1beststrata.bw,"$wl"cDC_WT_H3K9me3_L36bp.am1beststrata.bw,"$wl"cDC_WT_H3K27me3_L36bp.am1beststrata.bw"

multipleSignalMean 30 png PU1,MPP ./PU1_cDC_500.bed,./MPP_WT_peaks.bed $wLabels $wList ./


