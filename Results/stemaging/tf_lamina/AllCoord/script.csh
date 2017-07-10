awk -F '\ ' 'BEGIN {OFS="\ "} { if( $2 >= 0.7 || $2 <=-0.7 ){print $1,$2,$3,$4,$5,$6} }' all_genes_unfiltered_results.csv | cut -d ' ' -f 6 > de_genes.txt
grep -v NA de_genes.txt > de_genes_final.txt
grep -w -i -f de_genes_final.txt tfmapping.txt | cut -f 1 > de_tfs.txt

head -n 1 rand_pvalue.txt > header.txt
grep -f de_tfs.txt rand_pvalue.txt > rand_pvalue_diff_upa.txt
cat header.txt rand_pvalue_diff_upa.txt > rand_pvalue_diff_up.txt
grep -f de_tfs.txt rand_corr.txt > rand_corr_diff_upa.txt
cat header.txt rand_corr_diff_upa.txt > rand_corr_diff_up.txt

