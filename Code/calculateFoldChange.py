#################################################################################################
# Calculates the fold change between 2 wig files based on bed file.
# It is identical to lineAndBoxByWigDiff but it just outputs the box values in a bed file
# and the values are fold changes instead of the regular average.
#################################################################################################
params = []
params.append("###")
params.append("Input: ")
params.append("    1. windowSize = The length of the window. Eg. 1000.")
params.append("    2. normFactor1,normFactor2 = Normalization factors for the signals. Eg. 1.0,1.0.")
params.append("    3. useLog = If 'y' then log the values after normalization.")
params.append("    4. bedFileName = Input bed file.")
params.append("    5. wigFileName1,wigFileName2 = Signal file names.")
params.append("    6. outputLocation = Location of the output and temporary files.")
params.append("###")
params.append("Output: ")
params.append("    1. <bedFileName>_<windowSize>.bed = The resulting bed file with fold change.")
params.append("###")
#################################################################################################

# Import
import os
import sys
import math
import numpy as np
from bx.bbi.bigwig_file import BigWigFile
lib_path = os.path.abspath("/".join(os.path.realpath(__file__).split("/")[:-2]))
sys.path.append(lib_path)
from util import *
if(len(sys.argv) <= 1): 
    for e in params: print e
    sys.exit(0)

# Reading input
windowSize = int(sys.argv[1])
normFactors = sys.argv[2].split(",")
normFactor1 = float(normFactors[0])
normFactor2 = float(normFactors[1])
useLog = sys.argv[3]
if(useLog == "y"): useLog = True
else: useLog = False
bedFileName = sys.argv[4]
wigFileNames = sys.argv[5].split(",")
wigFileName1 = wigFileNames[0]
wigFileName2 = wigFileNames[1]
outputLocation = sys.argv[6]
if(outputLocation[-1] != "/"): outputLocation+="/"

###############################################################################################################
### INPUT
###############################################################################################################

# Fetching signal
wigFile1 = open(wigFileName1,"r")
bw1 = BigWigFile(wigFile1)
wigFile2 = open(wigFileName2,"r")
bw2 = BigWigFile(wigFile2)

# Iterating on bed file
bedName = bedFileName.split("/")[-1].split(".")[0]
bedFile = open(bedFileName,"r")
if(windowSize == 0): outputFileName = outputLocation+bedName
else: outputFileName = outputLocation+bedName+"_"+str(windowSize)
if(normFactor1 != 1.0 or normFactor2 != 1.0): outputFileName+="_norm"
if(useLog): outputFileName+="_log"
outputFileName+=".bed"
outputFile = open(outputFileName,"w")
counter = 1
for line in bedFile:

    # Positions
    ll = line.strip().split("\t")
    mid = (int(ll[1]) + int(ll[2]))/2
    if(windowSize == 0):
        p1 = int(ll[1])
        p2 = int(ll[2])
    else:
        p1 = max(0,mid-int(math.floor(windowSize/2.0)))
        p2 = mid+int(math.ceil(windowSize/2.0))

    # Fetching sequence
    sequence1 = aux.correctBW(bw1.get(ll[0],p1,p2),p1,p2)
    sequence2 = aux.correctBW(bw2.get(ll[0],p1,p2),p1,p2)

    # Normalize
    sequence1 = [e*normFactor1 for e in sequence1]
    sequence2 = [e*normFactor2 for e in sequence2]
 
    # Log
    if(useLog):
        sequence1 = [math.log(e+1.0,2) for e in sequence1]
        sequence2 = [math.log(e+1.0,2) for e in sequence2]
    
    # Calculate fold change
    foldSequence = [sequence2[i]-sequence1[i] for i in range(0,len(sequence1))]
    v = np.array(foldSequence).mean()

    # Writing
    if(windowSize == 0): outputFile.write("\t".join([ll[0],ll[1],ll[2],"c"+str(counter),str(v),"."])+"\n")
    else: outputFile.write("\t".join([ll[0],ll[1],ll[2],str(p1)+":"+str(p2),str(v),"."])+"\n")

    counter += 1

# Termination
wigFile1.close()
wigFile2.close()
bedFile.close()
outputFile.close()


