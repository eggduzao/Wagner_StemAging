
head -n 1 rand_pvalue.txt > header.txt
grep -f ../AllCoord/de_tfs.txt rand_corr.txt > rand_corr_diff_upa.txt
cat header.txt rand_corr_diff_upa.txt > rand_corr_diff_up.txt

