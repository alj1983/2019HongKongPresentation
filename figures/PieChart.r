

## slices <- c(1210529,37000,344148,22500,12000,406544)
## slices <- slices[order(c(1210529,37000,344148,22500,12000,406544))]
## lbls <- c("Personnel","Travel","Consumables","Publication","Training","Indirect costs")
## lbls <- lbls[order(c(1210529,37000,344148,22500,12000,406544))]
## pct <- round(slices/sum(slices)*100)

## pie(pct,labels = lbls, col=rainbow(length(lbls)),clockwise=TRUE,radius = 0.5, cex = 1.5)
## df <- data.frame(lbls,slices)

## library(RColorBrewer)
## colors <- brewer.pal(7, name="BuGn")
## colors[2:7]

## library(ggplot2)
## bar <- ggplot(df, aes(x = "", y = pct, fill = lbls)) +
##     geom_bar(width = 1, stat = "identity", color = "white")
## pie <- bar+coord_polar("y",start=0)+scale_fill_manual(values = colors[2:7])+
##     theme_void()+
##     theme(legend.text=element_text(size=30),legend.title=element_blank())+
##     guides(fill=guide_legend(
##                  keywidth=0.7,
##                  keyheight=0.7,
##                  default.unit="inch")
##            )

##  png(filename = "Pie.png",
##          width = 700, height = 700, units = "px", pointsize = 12,
##      bg = "white")
## print(pie)
## dev.off()

## Using plotrix based on these examples:

## https://www.r-bloggers.com/how-to-draw-venn-pie-agram-multi-layer-pie-chart-in-r/
##https://stackoverflow.com/questions/26748069/ggplot2-pie-and-donut-chart-on-same-plot

library(plotrix)

total <- 213764
CG <- 118532
CHG <- total-CG
Genes.without.TEs <- 32307
Genes.without.TEs.CG <- 19106
Genes.without.TEs.CHG <- Genes.without.TEs - Genes.without.TEs.CG
InterGenes.without.TEs <- 93290
InterGenes.without.TEs.CG <- 50637
InterGenes.without.TEs.CHG <- InterGenes.without.TEs - InterGenes.without.TEs.CG
TEs.In.Genes <- 22031
TEs.In.Genes.CG <- 12994
TEs.In.Genes.CHG <- TEs.In.Genes - TEs.In.Genes.CG
TEs.In.InterGenes <- 66136
TEs.In.InterGenes.CG <- 35795
TEs.In.InterGenes.CHG <- TEs.In.InterGenes - TEs.In.InterGenes.CG
Genes <- Genes.without.TEs + TEs.In.Genes
InterGenes <- InterGenes.without.TEs + TEs.In.InterGenes

# parameter for pie chart
iniR=0.2 # initial radius
#colors=list(NO='white',total='black',mtRNA='#e5f5e0',rRNA='#a1d99b',genic=,intergenic='#fec44f',introns=',exons=,upstream='#ffeda0',downstream='#fee0d2',not_near_genes=)

png(filename = "Pie.png",
         width = 700, height = 700, units = "px", pointsize = 12,
      bg = "white")
#0 circle: blank
pie(1, radius=iniR, init.angle=90, col=c('white'), border = NA, labels='')

                                        #TEs
floating.pie(0,0, c(Genes.without.TEs,TEs.In.Genes,TEs.In.InterGenes,InterGenes.without.TEs), radius=4*iniR, startpos=pi/2, col=c("white",'#9ecae1','#fc9272',"white"),border = "white")



#1 circle: for genes and intergenes
floating.pie(0,0, c(Genes,InterGenes), radius=3*iniR, col=c('#3182bd','#d95f0e'),startpos=pi/2, border = "white")

floating.pie(0,0, c(Genes.without.TEs.CG,
                    Genes.without.TEs.CHG,
                    TEs.In.Genes.CHG,
                    TEs.In.Genes.CG,
                    TEs.In.InterGenes.CG,
                    TEs.In.InterGenes.CHG,
                    InterGenes.without.TEs.CHG,
                    InterGenes.without.TEs.CG
                    ), radius=2*iniR, col=c("lightgray","darkgray","darkgray","lightgray","lightgray","darkgray","darkgray","lightgray"),startpos=pi/2, border = "white")




legend(-3, 5*iniR, c("genic","intergenic","genic TEs","intergenic TEs","CG","CHG"), col=c('#3182bd','#d95f0e','#9ecae1','#fc9272',"lightgray","darkgray"), pch=19,bty='n', ncol=2,cex=2)

dev.off()