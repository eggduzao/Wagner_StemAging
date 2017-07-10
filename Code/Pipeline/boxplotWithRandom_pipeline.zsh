#!/bin/zsh

# Boxplot with Random
# Creates boxplots based on a bed file and random regions.

# Usage:
# ./boxplotWithRandom_pipeline.zsh <useAllNegative> <normFactor> <outExt> <bedLabel> <bedFileName> <wigLabel> <wigFileName> <chromSizesFileName> <outputLocation>

# Parameters:
# <useAllNegative> = 'y' to use all non-bed regions as evidence.
# <normFactor> = Normalization factor for this signal. Eg. 1.0.
# <outExt> = The extension of the image. Eg. png or eps.
# <bedLabel> = bed label.
# <bedFileName> = Input bed.
# <wigLabel> =  Label for the wig file.
# <wigFileName> = Signal file name.
# <chromSizesFileName> = File with the chromosome sizes.
# <outputLocation> = Location of the output and temporary files.

# Imports
export PATH=$PATH:/hpcwork/izkf/bin/:/hpcwork/izkf/opt/bin/:/work/eg474423/eg474423_Projects/trunk/TfbsPrediction/exp/bin/:/work/eg474423/ig440396_dendriticcells/exp/motifanalysis/bin/
export PYTHONPATH=$PYTHONPATH:/hpcwork/izkf/lib64/python2.6/:/hpcwork/izkf/lib64/python2.6/site-packages/:/hpcwork/izkf/lib/python2.6/:/hpcwork/izkf/lib/python2.6/site-packages/:/hpcwork/izkf/opt/lib64/python2.6/:/hpcwork/izkf/opt/lib64/python2.6/site-packages/:/hpcwork/izkf/opt/lib/python2.6/:/hpcwork/izkf/opt/lib/python2.6/site-packages/
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/hpcwork/izkf/lib64/:/hpcwork/izkf/lib/:/hpcwork/izkf/opt/lib/:/hpcwork/izkf/opt/lib64/:/hpcwork/izkf/opt/lib/

# 0. Initializations
useAllNegative=$1
normFactor=$2
outExt=$3
bedLabel=$4
bedFileName=$5
wigLabel=$6
wigFileName=$7
chromSizesFileName=$8
outputLocation=$9

# 1. Creating graphs
echo "1. Creating graphs"
boxplotWithRandom $useAllNegative $normFactor $outExt $bedLabel $bedFileName $wigLabel $wigFileName $chromSizesFileName $outputLocation
echo ""

echo "Script terminated successfully!"
echo "----------------------------------------------"
echo ""


