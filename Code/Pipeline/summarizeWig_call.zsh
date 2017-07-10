#!/bin/zsh

# Parameters
wSize="1000000"
wigLoc="/hpcwork/izkf/projects/stemaging/fibroblast/single_peaks_6/"
outLoc="/hpcwork/izkf/projects/stemaging/edu/circosSummary/"

# Execution
bsub -J "p56_w6_SBW" -o "p56_w6_SBW_out.txt" -e "p56_w6_SBW_err.txt" -W 100:00 -M 12000 -S 100 -P izkf -R "select[hpcwork]" ./summarizeWig_pipeline.zsh $wSize $wigLoc"patient6"*"/patient6"*".bw" $wigLoc"patient5"*"/patient5"*".bw" $outLoc
bsub -J "p78_w6_SBW" -o "p78_w6_SBW_out.txt" -e "p78_w6_SBW_err.txt" -W 100:00 -M 12000 -S 100 -P izkf -R "select[hpcwork]" ./summarizeWig_pipeline.zsh $wSize $wigLoc"patient8"*"/patient8"*".bw" $wigLoc"patient7"*"/patient7"*".bw" $outLoc


