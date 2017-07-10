#################################################################################################
# Creates a boxplot representing the mean of multiple signals based on coordinates of a bed file 
# and random coordinates outside this bed file.
#################################################################################################
params = []
params.append("###")
params.append("Input: ")
params.append("    1. useAllNegative = 'y' to use all non-bed regions as evidence.")
params.append("    2. normFactor = Normalization factor for this signal. Eg. 1.0.")
params.append("    3. useLog = 'y' to log the values after normalizing.")
params.append("    4. outExt = The extension of the image. Eg. png or eps.")
params.append("    5. bedLabel = Label of bed file.")
params.append("    6. bedFileName = Input bed file.")
params.append("    7. wigLabel = Label for the wig file.")
params.append("    8. wigFileName = Signal file name.")
params.append("    9. chromSizesFileName = File with chromosome sizes.")
params.append("   10. outputLocation = Location of the output and temporary files.")
params.append("###")
params.append("Output: ")
params.append("    1. <bedLabel>_<wigLabel>.<outExt> = The resulting boxplot.")
params.append("    2. <bedLabel>_<wigLabel>.txt = Textual representation of the boxplot.")
params.append("###")
#################################################################################################

# Import
import os
import sys
import glob
import math
import random
import numpy as np
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
useAllNegative = sys.argv[1]
if(useAllNegative == "y"): useAllNegative = True
else: useAllNegative = False
normFactor = float(sys.argv[2])
useLog = sys.argv[3]
if(useLog == "y"): useLog = True
else: useLog = False
outExt = sys.argv[4]
bedLabel = sys.argv[5]
bedFileName = sys.argv[6]
wigLabel = sys.argv[7]
wigFileName = sys.argv[8]
chromSizesFileName = sys.argv[9]
outputLocation = sys.argv[10]
if(outputLocation[-1] != "/"): outputLocation+="/"

###############################################################################################################
### INPUT
###############################################################################################################

# Additional input
colorList = ["black", "green", "red", "blue", "orange", "purple", "pink", "cyan", "magenta", "gray", "violet", "Brown", "Coral", "CadetBlue", "DarkGray", "DarkSalmon", "LightSalmon", "LightPink", "LightSlateGray", "NavajoWhite", "Olive"]

# Fetching chromosome sizes
chromSizesFile = open(chromSizesFileName,"r")
chromSizesDict = dict()
for line in chromSizesFile:
    ll = line.strip().split("\t")
    chromSizesDict[ll[0]] = int(ll[1])
chromSizesFile.close()

# Open signal file
wigFile = open(wigFileName,"r")
bw = BigWigFile(wigFile)

# Get evidence bed coordinates
evDict = aux.createBedDictFromSingleFile(bedFileName, separator="\t")
evDict = gsort.sortBedDictionaries([evDict])[0]

# Get spacing regions
spacingDict = dict()
for chrName in constants.getChromList(reference=[evDict]):
    spacingDict[chrName] = [[0,evDict[chrName][0][0]]]
    for i in range(1,len(evDict[chrName])): 
        spacingDict[chrName].append([evDict[chrName][i-1][1],evDict[chrName][i][0]])
    spacingDict[chrName].append([ evDict[chrName][-1][1] , chromSizesDict[chrName] ])

# Get random bed coordinates
if(not useAllNegative):
    randDict = dict()
    for chrName in constants.getChromList(reference=[evDict]):
        randDict[chrName] = []
        for coord in evDict[chrName]:
            coordLen = coord[1] - coord[0]
            rIndex = random.randint(0,len(spacingDict[chrName])-1)
            spCoord = spacingDict[chrName].pop(rIndex)
            r = random.randint(spCoord[0],max(spCoord[0]+1,spCoord[1]-coordLen-1))
            newCoord = [r,min(r+coordLen,spCoord[1])]
            randDict[chrName].append(newCoord)
else:
    randDict = spacingDict

# Iterating on bed files
boxplotVec = []
for bedDict in [evDict,randDict]:

    # Iterating on chromosomes
    boxplotVec.append([])
    for chrName in constants.getChromList(reference=[bedDict]):

        # Iterating on coordinates
        for coord in bedDict[chrName]:
            sequence = aux.correctBW(bw.get(chrName,coord[0],coord[1]),coord[0],coord[1])
            sequence = [e*normFactor for e in sequence] # Normalization
            if(useLog): sequence = [math.log(e+1.0,2) for e in sequence] # Log
            boxplotVec[-1].append(np.array(sequence).mean())

# Closing wig file
wigFile.close()

###############################################################################################################
### WRITING RESULTS
###############################################################################################################

# Creating output file name
outputFileName = outputLocation+bedLabel+"_"+wigLabel
if(normFactor != 1.0): outputFileName+="_norm"
if(useLog): outputFileName+="_log"

# writing boxplot graph
outputFile = open(outputFileName+".txt","w")
outputFile.write(bedLabel+"\tRandom\n")
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
ax.set_title(wigLabel)
ax.set_ylabel("Average signal intensity")

# Ticks
ax.set_xticks(range(1,len(boxplotVec)+1))
ax.set_xticklabels([bedLabel,"Random"])
ax.grid(True, which='both')
for tick in ax.xaxis.get_major_ticks(): tick.label.set_fontsize(8)
for tick in ax.yaxis.get_major_ticks(): tick.label.set_fontsize(8)

# Rotate labels
labels = ax.get_xticklabels()
for label in labels: label.set_rotation(90)

# Saving figure
fig.savefig(outputFileName+"."+outExt, format=outExt, dpi=300, bbox_inches='tight') 


