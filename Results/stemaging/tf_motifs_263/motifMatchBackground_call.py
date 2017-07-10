
# Import
import os

# Parameters
organism="--organism hg19"
fpr="--fpr 0.0001"
precision="--precision 10000"
pseudocounts="--pseudocounts 0.1"
#bigbed="--bigbed"

###################################################################################################
# RANDOM BACKGROUND
###################################################################################################

# Parameters
rand_proportion="--rand-proportion 0.00001"
output_location="--output-location /home/egg/Projects/Wagner/m/"
inputMatrix="/home/egg/Projects/Wagner/m/matrix.txt"

# Execution
clusterCommand = "rgt-motifanalysis --matching "
clusterCommand += organism+" "+fpr+" "+precision+" "+pseudocounts+" "+rand_proportion+" "
clusterCommand += output_location+" "+inputMatrix
os.system(clusterCommand)


