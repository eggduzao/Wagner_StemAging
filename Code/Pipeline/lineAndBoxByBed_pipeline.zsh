#!/bin/zsh

# Line and Box Graphs By Bed
# Creates signal mean graphs on multiple signals based on coordinate files.

# Usage:
# ./lineAndBoxByBed_pipeline.zsh <windowSize> <normFactorList> <outExt> <bedLabelList> <bedFileNameList> <wigLabelList> <wigFileNameList> <outputLocation>

# Parameters:
# <windowSize> = The length of the window. Eg. 1000.
# <normFactorList> = Normalization factors separated by ','. Eg. 1.0,1.2.
# <outExt> = The extension of the image. Eg. png or eps.
# <bedLabelList> = List of bed labels separated by ','. Eg. bed1,bed2.
# <bedFileNameList> =  List of input bed. Eg. a/b/c.bed,a/b/d.bed.
# <wigLabelList> =  List of wig labels separated by ','. Eg. wig1,wig2.
# <wigFileNameList> = List of signals to be analyzed. Eg. a/b/c.bw,a/b/d.bw.
# <outputLocation> = Location of the output and temporary files.

# Imports
export PATH=$PATH:/hpcwork/izkf/bin/:/hpcwork/izkf/opt/bin/:/work/eg474423/eg474423_Projects/trunk/TfbsPrediction/exp/bin/:/work/eg474423/ig440396_dendriticcells/exp/motifanalysis/bin/
export PYTHONPATH=$PYTHONPATH:/hpcwork/izkf/lib64/python2.6/:/hpcwork/izkf/lib64/python2.6/site-packages/:/hpcwork/izkf/lib/python2.6/:/hpcwork/izkf/lib/python2.6/site-packages/:/hpcwork/izkf/opt/lib64/python2.6/:/hpcwork/izkf/opt/lib64/python2.6/site-packages/:/hpcwork/izkf/opt/lib/python2.6/:/hpcwork/izkf/opt/lib/python2.6/site-packages/
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/hpcwork/izkf/lib64/:/hpcwork/izkf/lib/:/hpcwork/izkf/opt/lib/:/hpcwork/izkf/opt/lib64/:/hpcwork/izkf/opt/lib/

# 0. Initializations
windowSize=$1
normFactorList=$2
outExt=$3
bedLabelList=$4
bedFileNameList=$5
wigLabelList=$6
wigFileNameList=$7
outputLocation=$8

# 1. Creating graphs
echo "1. Creating graphs"
lineAndBoxByBed $windowSize $normFactorList $outExt $bedLabelList $bedFileNameList $wigLabelList $wigFileNameList $outputLocation
echo ""

echo "Script terminated successfully!"
echo "----------------------------------------------"
echo ""


