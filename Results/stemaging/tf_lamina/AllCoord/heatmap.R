library(gplots)
library(RColorBrewer)
hmcol <- colorRampPalette(brewer.pal(10, "RdBu"))(256)
#hmcol <- hmcol[length(hmcol):1]
d=read.table("rand_corr_diff_up.txt",header=TRUE)


sel=c(5,6,7,8,9,11)

write.table("pvalues.txt",d[rowSums(d[,sel]>0.05)<size,sel],sep="\t")

size=length(sel)
pdf("senescence_corr_up.pdf")
d[d>0.05]=0.06

heatmap.2(as.matrix(d[rowSums(d[,sel]>0.05)<size,sel]),margins = c(10,6),cexCol = 0.8,cexRow=0.5,trace="none",labCol =c("Donor 1 Hyper","Donor 1 Hypo","Donor 2 Hyper","Donor 2 Hypo","Koch Hyper","Koch Hypo"))
dev.off()

d=read.table("rand_corr.txt",header=TRUE)
sel=c(5,6,7,8,9,11)


size=length(sel)
pdf("senescence_corr.pdf")
d[d>0.05]=0.06

h=heatmap.2(as.matrix(d[rowSums(d[,sel]>0.05)<size,sel]),margins = c(10,6),cexCol = 0.8,cexRow=0.5,trace="none",labCol =c("Donor 1 Hyper","Donor 1 Hypo","Donor 2 Hyper","Donor 2 Hypo","Koch Hyper","Koch Hypo"))
dev.off()

aux=h$carpet

aux[aux==0]=1/(10^100)

write.table(file="pvalues_nofilter.txt",t(aux),sep=",")





#d_sel=d[rowSums(d[,sel]>0.01)<size,sel]
#names=rownames(d_sel)
#d_sel=d_sel[grep("E2F|AP2|HOX|ARNT|MYB|ETS|CREB|GABP|GATA|MTF|Egr",names,ignore.case = TRUE),]


#pdf("senescence_corr_up_sel.pdf")
#heatmap.2(as.matrix(d_sel),margins = c(10,6),cexCol = 0.8,cexRow=0.6,trace="none")
#dev.off()
#names=rownames(d_sel)
#d_sel_sel=d_sel[grep("Arnt|ETS1|AP2A|Egr1|HOXA5|Mtf|CREB1",names),]

#pdf("senescence_corr_up_sel_sel.pdf")
#heatmap.2(as.matrix(d_sel_sel),margins = c(10,6),cexCol = 0.8,cexRow=0.6,trace="none")
#dev.off()


#d=read.table("rand_pvalue_diff_up.txt",header=TRUE)

#sel=c(5,6,7,8,9,11)
#size=length(sel)
#pdf("senescence_up.pdf")
#d[d>0.05]=0.06
#heatmap.2(as.matrix(d[rowSums(d[,sel]>0.01)<size,sel]),margins = c(10,6),cexCol = 0.8,cexRow=0.6,trace="none")
#dev.off()
