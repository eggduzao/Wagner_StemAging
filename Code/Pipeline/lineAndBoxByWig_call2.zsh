#!/bin/zsh

###########################
# Histone Graphs
###########################

# Global Parameters
ext="png"
invNeg="n"
ws="10000"
useLog="n"
bl="/hpcwork/izkf/projects/egg/Data/DNase/"
wl="/hpcwork/izkf/projects/egg/TfbsPrediction/Results/Counts/"
ol="/hpcwork/izkf/projects/egg/TfbsPrediction/Results/SignalStatistics/HistoneGraphs/"

# Cell Line Parameters
cellLineList=( "H1hesc" "H1hesc" "HeLaS3" "HeLaS3" "HepG2" "HepG2" "K562" "K562" )
histoneList=( "H3K4me1" "H3K4me3" "H3K4me1" "H3K4me3" "H3K4me1" "H3K4me3" "H3K4me1" "H3K4me3" )
normFactorList=( "0.036648" "0.052073" "0.026018" "0.027857" "0.019113" "0.053703" "0.034249" "0.039757" )

# Cell Line Loop
for i in {1..$#cellLineList}
do

    # Parameters
    bedLabel=$cellLineList[$i]"_"$histoneList[$i]
    bedFile=$bl$cellLineList[$i]"/DNasePeaks.bed"
    wigLabel=$cellLineList[$i]"_"$histoneList[$i]
    wigFile=$wl$cellLineList[$i]"/"$histoneList[$i]".bw"
    normFactor=$normFactorList[$i]
    
    # Execution
    bsub -J $bedLabel"_HGR" -o $bedLabel"_HGR_out.txt" -e $bedLabel"_HGR_err.txt" -W 100:00 -M 12000 -S 100 -P izkf -R "select[hpcwork]" ./lineAndBoxByWig_pipeline.zsh $invNeg $ws $normFactor $useLog $ext $bedLabel $bedFile $wigLabel $wigFile $ol

done


