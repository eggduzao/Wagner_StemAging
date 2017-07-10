#################################################################################################
# Creates a tiled circos bed file with the average signal from two wig files.
#################################################################################################
params = []
params.append("###")
params.append("Input: ")
params.append("    1. windowLen = Length of the tiles.")
params.append("    2. posSignalFileName = Wig file to be positive summarized.")
params.append("    3. negSignalFileName = Wig file to be negative summarized.")
params.append("    4. outputLocation = Location of the output and temporary files.")
params.append("###")
params.append("Output: ")
params.append("    1. <posSignalFileName>_<negSignalFileName>_<windowLen>.bed = Tiled bed.")
params.append("###")
#################################################################################################

# Import
import os
import sys
import numpy as np
from bx.bbi.bigwig_file import BigWigFile
lib_path = os.path.abspath("/".join(os.path.realpath(__file__).split("/")[:-2]))
sys.path.append(lib_path)
from util import *
if(len(sys.argv) <= 1): 
    for e in params: print e
    sys.exit(0)

# Reading input
windowLen = int(sys.argv[1])
posSignalFileName = sys.argv[2]
negSignalFileName = sys.argv[3]
outputLocation = sys.argv[4]
if(outputLocation[-1] != "/"): outputLocation+="/"

# Signal name
posSigName = posSignalFileName.split("/")[-1].split(".")[0]
negSigName = negSignalFileName.split("/")[-1].split(".")[0]

# Signal files
posSigFile = open(posSignalFileName,"r")
posBw = BigWigFile(posSigFile)
negSigFile = open(negSignalFileName,"r")
negBw = BigWigFile(negSigFile)

# Chrom sizes dictionary
chromSizesFileName = constants.getChromSizesLocation()
chromSizesFile = open(chromSizesFileName,"r")
chromSizesDict = dict()
for line in chromSizesFile:
    ll = line.strip().split("\t")
    chromSizesDict[ll[0]] = int(ll[1])
chrList = constants.getChromList(x=False, y=False)

# Sumarizing
outputFile = open(outputLocation+posSigName+"_"+negSigName+"_"+str(windowLen)+".bed","w")
for chrName in chrList:
    for k in range(0,chromSizesDict[chrName],windowLen):
        p1 = k; p2 = min(k+windowLen,chromSizesDict[chrName])
        posMean = np.array(aux.correctBW(posBw.get(chrName,p1,p2),p1,p2)).mean()
        negMean = np.array([-e for e in aux.correctBW(negBw.get(chrName,p1,p2),p1,p2)]).mean()
        outputFile.write("\t".join(["hs"+chrName[3:],str(p1),str(p2),str(posMean)])+"\n"+"\t".join(["hs"+chrName[3:],str(p1),str(p2),str(negMean)])+"\n")

# Termination
posSigFile.close()
negSigFile.close()
outputFile.close()


