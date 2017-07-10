
# Import
import os

# Parameters
organism="--organism hg19"
promoter_length="--promoter-length 1000"
maximum_association_length="--maximum-association-length 50000"
multiple_test_alpha="--multiple-test-alpha 0.05"
processes="--processes 1"
print_thresh="--print-thresh 1.0"
bigbed="--bigbed"

###################################################################################################
# All Methylation Background
###################################################################################################

# Parameters
inputMatrix="/home/egg/Projects/StemAging/Results/stemaging/tf_motifs_263/matrix/matrix.txt"
matchLoc="/home/egg/Projects/StemAging/Results/stemaging/tf_motifs_263/result/all_methylation_background/"
output_location="--output-location /home/egg/Projects/StemAging/Results/stemaging/tf_motifs_263/result/all_methylation_background/"

# Execution
clusterCommand = "rgt-motifanalysis --enrichment "
clusterCommand += organism+" "+promoter_length+" "+maximum_association_length+" "+multiple_test_alpha+" "
clusterCommand += processes+" "+output_location+" "+print_thresh+" "+bigbed+" "+inputMatrix+" "+matchLoc
os.system(clusterCommand)


###################################################################################################
# Random Background
###################################################################################################

# Parameters
inputMatrix="/home/egg/Projects/StemAging/Results/stemaging/tf_motifs_263/matrix/matrix.txt"
matchLoc="/home/egg/Projects/StemAging/Results/stemaging/tf_motifs_263/result/random_background/"
output_location="--output-location /home/egg/Projects/StemAging/Results/stemaging/tf_motifs_263/result/random_background/"

# Execution
clusterCommand = "rgt-motifanalysis --enrichment "
clusterCommand += organism+" "+promoter_length+" "+maximum_association_length+" "+multiple_test_alpha+" "
clusterCommand += processes+" "+output_location+" "+print_thresh+" "+bigbed+" "+inputMatrix+" "+matchLoc
os.system(clusterCommand)

