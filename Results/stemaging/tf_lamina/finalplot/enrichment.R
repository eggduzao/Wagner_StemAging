
library(reshape)

library(ggplot2) 



pvalues_dmrs = read.table("pvalues_dmrs_final.txt", sep= ",", header = T, row.names=NULL)


pvalues_dmrs=pvalues_dmrs[,c(1,2,3,9,6,7,8,5,4)]

melt_dat = melt(as.data.frame(pvalues_dmrs))
melt_dat$value[melt_dat$value >= 0.05] = NA
melt_dat$value = -log10(melt_dat$value)



pdf("tf_dmrs.pdf",width=4)

data.m = melt_dat
data.m$motif = factor( data.m$row.names , levels = (unique(data.m$row.names)))


p <- ggplot(data.m, aes(variable, motif)) + geom_tile(aes(fill = value),colour =   "white")

p +
scale_fill_gradient(low = "darkblue", high = "red", na.value = "white") +
theme(axis.text.x = element_text( angle = 330, hjust = 0, colour =
"black"), axis.text.y = element_text(colour = "black", size = 6),
axis.ticks = element_blank()) +
scale_x_discrete(expand = c(0, 0)) +
scale_y_discrete(expand = c(0, 0)) +
labs(x = "", y = "")

dev.off()


pvalues_dmrs = read.table("pvalues_de_final.txt", sep= ",", header = T, row.names=NULL)



melt_dat = melt(as.data.frame(pvalues_dmrs))
melt_dat$value[melt_dat$value >= 0.05] = NA
melt_dat$value = -log10(melt_dat$value)



pdf("tf_de.pdf",width=4)

data.m = melt_dat
data.m$motif = factor( data.m$row.names , levels = (unique(data.m$row.names)))


p <- ggplot(data.m, aes(variable, motif)) + geom_tile(aes(fill = value),colour =   "white")

p +
scale_fill_gradient(low = "darkblue", high = "red", na.value = "white") +
theme(axis.text.x = element_text( angle = 330, hjust = 0, colour =
"black"), axis.text.y = element_text(colour = "black", size = 6),
axis.ticks = element_blank()) +
scale_x_discrete(expand = c(0, 0)) +
scale_y_discrete(expand = c(0, 0)) +
labs(x = "", y = "")

dev.off()


