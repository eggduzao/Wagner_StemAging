#################################################################################################
# Creates a graph representing the mean of multiple signals based on coordinates on the
# intersection of two bed files. The first bed file is the one used as reference.
#################################################################################################
params = []
params.append("###")
params.append("Input: ")
params.append("    1. invNeg = If 'y' then invert the values of negative strand.")
params.append("    2. windowSize = The length of the window. Eg. 1000.")
params.append("    3. normFactor1,normFactor2 = Normalization factors for the signals. Eg. 1.0,1.0.")
params.append("    4. useLog = If 'y' then log the values after normalization.")
params.append("    5. outExt = The extension of the image. Eg. png or eps.")
params.append("    6. bedLabelList = List of bed labels separated by ','. Eg. bed1,bed2.")
params.append("    7. bedFileNameList = List of input bed. Eg. a/b/c.bed,a/b/d.bed.")
params.append("    8. wigLabel1,wigLabel2 = Label for the wig files.")
params.append("    9. wigFileName1,wigFileName2 = Signal file names.")
params.append("   10. outputLocation = Location of the output and temporary files.")
params.append("###")
params.append("Output: ")
params.append("    1. <wigLabel1>_<wigLabel2>_<windowSize>_<box|line>.<outExt> = The resulting graphics.")
params.append("    2. <wigLabel1>_<wigLabel2>_<windowSize>_<box|line>.txt = Textual representation of the graphics.")
params.append("###")
#################################################################################################

# Import
import os
import sys
import glob
import math
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
invNeg = sys.argv[1]
if(invNeg == "y"): invNeg = True
else: invNeg = False
windowSize = int(sys.argv[2])+1
normFactors = sys.argv[3].split(",")
normFactor1 = float(normFactors[0])
normFactor2 = float(normFactors[1])
useLog = sys.argv[4]
if(useLog == "y"): useLog = True
else: useLog = False
outExt = sys.argv[5]
bedLabelList = sys.argv[6].split(",")
bedFileNameList = sys.argv[7].split(",")
wigLabels = sys.argv[8].split(",")
wigLabel1 = wigLabels[0]
wigLabel2 = wigLabels[1]
wigFileNames = sys.argv[9].split(",")
wigFileName1 = wigFileNames[0]
wigFileName2 = wigFileNames[1]
outputLocation = sys.argv[10]
if(outputLocation[-1] != "/"): outputLocation+="/"

###############################################################################################################
### INPUT
###############################################################################################################

# Additional input
colorList = ["black", "green", "red", "blue", "orange", "purple", "pink", "cyan", "magenta", "gray", "violet", "Brown", "Coral", "CadetBlue", "DarkGray", "DarkSalmon", "LightSalmon", "LightPink", "LightSlateGray", "NavajoWhite", "Olive"]

# Fetching signal
wigFile1 = open(wigFileName1,"r")
bw1 = BigWigFile(wigFile1)
wigFile2 = open(wigFileName2,"r")
bw2 = BigWigFile(wigFile2)

# Iterating on bed files
nbBed = len(bedFileNameList)
sumVec = [[0.0 for e in range(0,windowSize)] for k in range(0,nbBed)]
sqSumVec = [[0.0 for e in range(0,windowSize)] for k in range(0,nbBed)]
totVec = [0.0 for k in range(0,nbBed)]
boxplotVec = [[] for k in range(0,nbBed)]
for b in range(0,len(bedFileNameList)):
    
    # Fetching bed coordinates
    bedDict = aux.createBedDictFromSingleFile(bedFileNameList[b], separator="\t")

    # Iterating on chromosomes
    for chrName in constants.getChromList(reference=[bedDict]):

        # Iterating on coordinates
        for coord in bedDict[chrName]:

            # Positions
            mid = (coord[0] + coord[1])/2
            p1 = mid-int(math.floor(windowSize/2.0))
            p2 = mid+int(math.ceil(windowSize/2.0))

            # Fetching sequence
            sequence1 = aux.correctBW(bw1.get(chrName,p1,p2),p1,p2)
            sequence2 = aux.correctBW(bw2.get(chrName,p1,p2),p1,p2)

            # Inverting sequence
            if(invNeg and coord[4] == "-"):
                sequence1 = sequence1[::-1]
                sequence2 = sequence2[::-1]

            # Normalize
            sequence1 = [e*normFactor1 for e in sequence1]
            sequence2 = [e*normFactor2 for e in sequence2]
 
            # Log
            if(useLog):
                sequence1 = [math.log(e+1.0,2) for e in sequence1]
                sequence2 = [math.log(e+1.0,2) for e in sequence2]

            # Updating counters
            currMean = 0.0
            for i in range(0,len(sequence1)):
                v = sequence2[i] - sequence1[i]
                currMean += v
                sumVec[b][i] += v
                sqSumVec[b][i] += (v**2)
            totVec[b] += 1.0
            boxplotVec[b].append(currMean/len(sequence1))

# Evaluating mean and std
meanVec = [[0.0 for e in range(0,windowSize)] for k in range(0,nbBed)]
stdVec = [[0.0 for e in range(0,windowSize)] for k in range(0,nbBed)]
for b in range(0,nbBed):
    for i in range(0,windowSize):
        meanVec[b][i] = sumVec[b][i]/totVec[b]
        stdVec[b][i] = math.sqrt( ((sqSumVec[b][i])-((sumVec[b][i]**2)/totVec[b]))/(totVec[b]-1) )

# Closing wig file
wigFile1.close()
wigFile2.close()

###############################################################################################################
### WRITING RESULTS
###############################################################################################################

# Creating output file name
outputFileName = outputLocation+wigLabel1+"_"+wigLabel2+"_"+str(windowSize-1)
if(normFactor1 != 1.0 or normFactor2 != 1.0): outputFileName+="_norm"
if(useLog): outputFileName+="_log"

# Writing line graph
outputFile = open(outputFileName+"_line.txt","w")
outputFile.write("\t".join(["X"]+bedLabelList)+"\n")
indexList = range(int(-math.floor(windowSize/2.0)),int(math.ceil(windowSize/2.0))+1)
for j in range(0,len(meanVec[0])):
    toWrite = [str(indexList[j])]
    for i in range(0,len(meanVec)): toWrite.append(str(meanVec[i][j]))
    outputFile.write("\t".join(toWrite)+"\n")
outputFile.close()

# writing boxplot graph
outputFile = open(outputFileName+"_box.txt","w")
outputFile.write("\t".join(bedLabelList)+"\n")
lenVec = [len(e) for e in boxplotVec]
maxInd = lenVec.index(max(lenVec))
for j in range(0,len(boxplotVec[maxInd])):
    toWrite = []
    for i in range(0,len(boxplotVec)):
        if(j >= len(boxplotVec[i])): toWrite.append("NA")
        else: toWrite.append(str(boxplotVec[i][j]))
    outputFile.write("\t".join(toWrite)+"\n")
outputFile.close()

###############################################################################################################
### LINE GRAPH
###############################################################################################################

# Creating figure
fig = pyplot.figure(figsize=(4,3), facecolor='w', edgecolor='k')
mpl.rcParams.update({'font.size': 8})
ax = fig.add_subplot(111)

# Plot
for b in range(0,nbBed): ax.plot(range(0,len(meanVec[b])), meanVec[b], color=colorList[b], linestyle="-", label=bedLabelList[b])

# Titles and Axis Labels
ax.set_title(wigLabel1+" "+wigLabel2)
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

# Saving figure
fig.savefig(outputFileName+"_line."+outExt, format=outExt, dpi=300, bbox_inches='tight', bbox_extra_artists=[leg]) 

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
ax.set_title(wigLabel1+" "+wigLabel2)
ax.set_ylabel("Average signal intensity")

# Ticks
ax.set_xticks(range(1,len(boxplotVec)+1))
ax.set_xticklabels(bedLabelList)
ax.grid(True, which='both')
for tick in ax.xaxis.get_major_ticks(): tick.label.set_fontsize(8)
for tick in ax.yaxis.get_major_ticks(): tick.label.set_fontsize(8)

# Rotate labels
labels = ax.get_xticklabels()
for label in labels: label.set_rotation(90)

# Saving figure
fig.savefig(outputFileName+"_box."+outExt, format=outExt, dpi=300, bbox_inches='tight') 


