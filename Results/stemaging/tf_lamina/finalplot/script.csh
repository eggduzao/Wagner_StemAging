grep -w -f motifs_de.txt motifs_dmrs.txt  | sort | uniq > motifs_union.txt
wc motif*
wc ../de_gene_promoter/rand_corr.txt

cut -f 1 -d "," pvalues_nofilter_de.txt | cut -d "_" -f 2 > tfs_de.txt
cut -f 1 -d "," pvalues_nofilter_dmrs.txt | cut -d "_" -f 2 > tfs_dmrs.txt

cut -f 1 -d "," pvalues_nofilter_de.txt | cut -d "_" -f 1 > motif_de.txt
cut -f 1 -d "," pvalues_nofilter_dmrs.txt | cut -d "_" -f 1 > motif_dmrs.txt

paste -d "  " tfs_de.txt motif_de.txt > ids_de.txt
paste -d "  " tfs_dmrs.txt motif_dmrs.txt > ids_dmrs.txt

paste -d "," ids_de.txt motif_de.txt pvalues_nofilter_de.txt > pvalues_de_final.txt
paste -d "," ids_dmrs.txt motif_dmrs.txt pvalues_nofilter_dmrs.txt > pvalues_dmrs_final.txt

