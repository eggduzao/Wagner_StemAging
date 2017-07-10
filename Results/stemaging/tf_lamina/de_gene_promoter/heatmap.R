library(gplots)
library(RColorBrewer)
hmcol <- colorRampPalette(brewer.pal(10, "RdBu"))(256)
#hmcol <- hmcol[length(hmcol):1]
d=read.table("rand_corr.txt",header=TRUE)



size=dim(d)[2]
#pdf("senescence_corr_up.pdf")
d[d>0.05]=0.06

pdf("tf_enrichment_de.pdf")
h=heatmap.2(as.matrix(d[(rowSums(d>0.01)<size),]),margins = c(3,12),cexCol = 0.8,cexRow=0.7,trace="none",labCol=c("UP","DOWN"))
dev.off()

aux=h$carpet

aux[aux==0]=1/(10^100)

write.table(file="pvalues_nofilter.txt",t(aux),sep=",")

d=read.table("rand_corr_diff_up.txt",header=TRUE)




d[d>0.05]=0.06

pdf("tf_enrichment_de_sel.pdf")
heatmap.2(as.matrix(d[(rowSums(d>0.01)<size),]),margins = c(3,12),cexCol = 0.8,cexRow=0.7,trace="none",labCol=c("UP","DOWN"))
dev.off()

