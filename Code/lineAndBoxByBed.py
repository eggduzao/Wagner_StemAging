#################################################################################################
# Creates a graph representing the mean of multiple signals based on coordinates on the
# intersection of two bed files. The first bed file is the one used as reference.
#################################################################################################
params = []
params.append("###")
params.append("Input: ")
params.append("    1. windowSize = The length of the window. Eg. 1000.")
params.append("    2. normFactorList = Normalization factors separated by ','. Eg. 1.0,1.2.")
params.append("    3. outExt = The extension of the image. Eg. png or eps.")
params.append("    4. bedLabelList = List of bed labels separated by ','. Eg. bed1,bed2.")
params.append("    5. bedFileNameList = List of input bed. Eg. a/b/c.bed,a/b/d.bed.")
params.append("    6. wigLabelList = List of wig labels separated by ','. Eg. wig1,wig2.")
params.append("    7. wigFileNameList = List of signals to be analyzed. Eg. a/b/c.bw,a/b/d.bw.")
params.append("    8. outputLocation = Location of the output and temporary files.")
params.append("###")
params.append("Output: ")
params.append("    1. <bedLabelList>_<box|line>.<outExt> = The resulting graphics.")
params.append("    2. <bedLabelList>_<box|line>.txt = Textual representation of the graphics.")
params.append("###")
#################################################################################################

# Import
import os
import sys
import glob
import math
import pylab
import matplotlib as mpl
from matplotlib import pyplot
import matplotlib.font_manager as fm
from bx.bbi.bigwig_file import BigWigFile
lib_path = os.path.abspath("/".join(os.path.realpath(__file__).split("/")[:-2]))
sys.path.append(lib_path)
from util import *
if(len(sys.argv) <= 1): 
    for e in params: print e
    sys.exit(0)

# Reading input
windowSize = int(sys.argv[1])
normFactorList = [float(e) for e in sys.argv[2].split(",")]
outExt = sys.argv[3]
bedLabelList = sys.argv[4].split(",")
bedFileNameList = sys.argv[5].split(",")
wigLabelList = sys.argv[6].split(",")
wigFileNameList = sys.argv[7].split(",")
outputLocation = sys.argv[8]
if(outputLocation[-1] != "/"): outputLocation+="/"

###############################################################################################################
### INPUT
###############################################################################################################

# Additional input
colorList = ["black", "green", "red", "blue", "orange", "purple", "pink", "cyan", "magenta", "gray", "Brown", "Coral"]

# Getting bed intersection
if(len(bedFileNameList) == 1):
    bedFile = aux.createBedDictFromSingleFile(bedFileNameList[0], separator="\t")
else:
    os.system("intersectBed -wa -a "+bedFileNameList[0]+" -b "+bedFileNameList[1]+" > "+outputLocation+"_".join(bedLabelList)+"temp.bed")
    bedFile = aux.createBedDictFromSingleFile(outputLocation+"_".join(bedLabelList)+"temp.bed", separator="\t")
    os.system("rm "+outputLocation+"_".join(bedLabelList)+"temp.bed")

# Fetching signal
nbSig = len(wigFileNameList)
sumVec = [[0.0 for e in range(0,windowSize)] for k in range(0,nbSig)]
sqSumVec = [[0.0 for e in range(0,windowSize)] for k in range(0,nbSig)]
totVec = [0.0 for k in range(0,nbSig)]
boxplotVec = [[] for k in range(0,nbSig)]
for s in range(0,nbSig):
    bwFile = open(wigFileNameList[s],"r")
    bw = BigWigFile(bwFile)
    for chrName in constants.getChromList(reference=[bedFile]):
        for coord in bedFile[chrName]:
            mid = (coord[0] + coord[1])/2
            bwQuery = aux.correctBW(bw.get(chrName,mid-int(math.floor(windowSize/2.0)),mid+int(math.ceil(windowSize/2.0))),mid-int(math.floor(windowSize/2.0)),mid+int(math.ceil(windowSize/2.0)))
            if(len(bwQuery) < windowSize): continue
            counter = 0; currMean = 0.0
            for value in bwQuery:
                currMean += (value*normFactorList[s])
                sumVec[s][counter] += (value*normFactorList[s])
                sqSumVec[s][counter] += ((value*normFactorList[s])**2)
                counter += 1
            totVec[s] += 1.0
            boxplotVec[s].append(currMean/len(bwQuery))
    bwFile.close()

# Evaluating mean and std
meanVec = [[0.0 for e in range(0,windowSize)] for k in range(0,nbSig)]
stdVec = [[0.0 for e in range(0,windowSize)] for k in range(0,nbSig)]
for s in range(0,nbSig):
    for i in range(0,windowSize):
        if(totVec[s] > 0.0):
            meanVec[s][i] = sumVec[s][i]/totVec[s]
            stdVec[s][i] = math.sqrt( ((sqSumVec[s][i])-((sumVec[s][i]**2)/totVec[s]))/(totVec[s]-1) )
        else:
            meanVec[s][i] = 0.0
            stdVec[s][i] = 0.0      

###############################################################################################################
### WRITING RESULTS
###############################################################################################################

# Writing line graph
outputFile = open(outputLocation+"_".join(bedLabelList)+"_line.txt","w")
outputFile.write("\t".join(wigLabelList)+"\n")
for e in meanVec: outputFile.write("\t".join([str(k) for k in e])+"\n")
outputFile.close()

# writing boxplot graph
outputFile = open(outputLocation+"_".join(bedLabelList)+"_box.txt","w")
outputFile.write("\t".join(wigLabelList)+"\n")
for e in boxplotVec: outputFile.write("\t".join([str(k) for k in e])+"\n")
outputFile.close()

###############################################################################################################
### LINE GRAPH
###############################################################################################################

# Creating figure
fig = pyplot.figure(figsize=(4,3), facecolor='w', edgecolor='k')
mpl.rcParams.update({'font.size': 8})
ax = fig.add_subplot(111)

# Plot
for s in range(0,nbSig):
    ax.plot(range(0,len(meanVec[s])), meanVec[s], color=colorList[s], linestyle="-", label=wigLabelList[s])
    #ax.plot(range(0,len(stdVec[s])), [meanVec[s][i]+stdVec[s][i] for i in range(0,len(meanVec[s]))], color=colorList[s], linestyle=":")
    #ax.plot(range(0,len(stdVec[s])), [meanVec[s][i]-stdVec[s][i] for i in range(0,len(meanVec[s]))], color=colorList[s], linestyle=":")

# Titles and Axis Labels
ax.set_title("  ".join(bedLabelList))
ax.set_ylabel("Average signal intensity")

# Ticks
it = 10
ax.set_xticks(range(0,len(meanVec[0])+1,len(meanVec[0])/it))
ax.set_xticklabels(range(int(-math.floor(windowSize/2.0)),int(math.ceil(windowSize/2.0))+1,len(meanVec[0])/it))
ax.grid(True, which='both')
for tick in ax.xaxis.get_major_ticks(): tick.label.set_fontsize(8)
for tick in ax.yaxis.get_major_ticks(): tick.label.set_fontsize(8)

# Line legend
leg = ax.legend(bbox_to_anchor=(1.0, 0.0, 1.0, 1.0), loc=2, ncol=1, borderaxespad=0.)
for e in leg.legendHandles: e.set_linewidth(3.0)

# Setting graph limits -- ERASE IF YOU WANT AUTOSCALE!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
pylab.ylim([-1.0,1.0])

# Saving figure
fig.savefig(outputLocation+"_".join(bedLabelList)+"_line."+outExt, format=outExt, dpi=300, bbox_inches='tight', bbox_extra_artists=[leg]) 

###############################################################################################################
### BOX PLOT
###############################################################################################################

# Creating figure
fig = pyplot.figure(figsize=(4,3), facecolor='w', edgecolor='k')
mpl.rcParams.update({'font.size': 8})
ax = fig.add_subplot(111)

# Plot
bp = ax.boxplot(boxplotVec, sym='k+', positions=range(1,len(boxplotVec)+1))
pyplot.setp(bp['whiskers'], color='k',  linestyle='-' )
pyplot.setp(bp['fliers'], markersize=3.0)

# Titles and Axis Labels
ax.set_title("  ".join(bedLabelList))
ax.set_ylabel("Average signal intensity")

# Ticks
ax.set_xticks(range(1,len(boxplotVec)+1))
ax.set_xticklabels(wigLabelList)
ax.grid(True, which='both')
for tick in ax.xaxis.get_major_ticks(): tick.label.set_fontsize(5)
for tick in ax.yaxis.get_major_ticks(): tick.label.set_fontsize(6)

# Rotate labels
labels = ax.get_xticklabels()
for label in labels: label.set_rotation(90)

# Saving figure
fig.savefig(outputLocation+"_".join(bedLabelList)+"_box."+outExt, format=outExt, dpi=300, bbox_inches='tight') 


