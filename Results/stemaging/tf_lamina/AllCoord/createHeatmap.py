# Creates heatmap entry based on motif statistics output

# Import
import os
import sys

# Input
outputLocation = sys.argv[1]
if(outputLocation[-1] != "/"): outputLocation+="/"
folderList = sys.argv[2:]
for e in folderList:
    if(e[-1] != "/"): e+="/"

# Reading files
dicNevP = dict()
dicRandP = dict()
dicNevC = dict()
dicRandC = dict()
labelList = []
for folder in folderList:
    labelList.append(folder.split("/")[-2])
    inNev = open(folder+"nev_1_statistics.txt","r"); inNev.readline()
    for line in inNev:
        ll = line.strip().split("\t")
        if(ll[0] in dicNevP.keys()): dicNevP[ll[0]].append(ll[1])
        else: dicNevP[ll[0]] = [ll[1]]
        if(ll[0] in dicNevC.keys()): dicNevC[ll[0]].append(ll[2])
        else: dicNevC[ll[0]] = [ll[2]]
    inNev.close()
    inRand = open(folder+"rand_1_statistics.txt","r"); inRand.readline()
    for line in inRand:
        ll = line.strip().split("\t")
        if(ll[0] in dicRandP.keys()): dicRandP[ll[0]].append(ll[1])
        else: dicRandP[ll[0]] = [ll[1]]
        if(ll[0] in dicRandC.keys()): dicRandC[ll[0]].append(ll[2])
        else: dicRandC[ll[0]] = [ll[2]]    
    inRand.close()

# Writing files
outNevP = open(outputLocation+"nev_pvalue.txt","w"); outNevP.write("\t".join([""]+labelList)+"\n")
outRandP = open(outputLocation+"rand_pvalue.txt","w"); outRandP.write("\t".join([""]+labelList)+"\n")
outNevC = open(outputLocation+"nev_corr.txt","w"); outNevC.write("\t".join([""]+labelList)+"\n")
outRandC = open(outputLocation+"rand_corr.txt","w"); outRandC.write("\t".join([""]+labelList)+"\n")
for k in dicNevP.keys():
    outNevP.write("\t".join([k]+dicNevP[k])+"\n")
    outRandP.write("\t".join([k]+dicRandP[k])+"\n")
    outNevC.write("\t".join([k]+dicNevC[k])+"\n")
    outRandC.write("\t".join([k]+dicRandC[k])+"\n")
outNevP.close()
outRandP.close()
outNevC.close()
outRandC.close()


