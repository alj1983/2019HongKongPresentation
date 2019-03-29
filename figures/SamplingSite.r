
# Script to create a figure with the sampling locations


library("raster")
library("rgdal")

########### Landmask
continents <- readOGR("shapefiles/10m_land/","10m_land")
coastlines <- readOGR("shapefiles/10m_coastline/","10m_coastline")
Europe <- readOGR("shapefiles/MyEurope","MyEurope")
CAN <- readOGR("shapefiles/CAN_adm","CAN_adm0")
SJM <- readOGR("shapefiles/SJM_adm/","SJM_adm0")
NOR <- readOGR("shapefiles/NOR_adm/","NOR_adm0")
FIN <- readOGR("shapefiles/FIN_adm/","FIN_adm0")
GRL <- readOGR("shapefiles/GRL_adm/","GRL_adm0")
world <- readOGR("shapefiles/gadm28","gadm28")

Samples <- as.data.frame(
    rbind(
        c(1,"Finland","Hinderbengtsviken",60.167468, 19.521474)
    )
    )
Samples[,4] <- as.numeric(as.vector(Samples[,4]))
Samples[,5] <- as.numeric(as.vector(Samples[,5]))

SamplesSPDF <- SpatialPointsDataFrame(Samples[,5:4],Samples[,1:5])


png(filename="SamplingSites.png",width=200,height=300,units='mm',res=700,pointsize=10)
par(xpd=NA,mar=c(0,0,0,0),oma=c(0,0,0,0),font=3,ps=10,bg="white")
#par(bg=NA,lwd=5,lty=2,oma=c(20,20,20,20))
plot(continents,col="NA",border="NA", bg="NA",xlim=c(15,20),ylim=c(50,73),main="")
plot(Europe,col="#CCCCFF",border="#CCCCFF",add=TRUE)
plot(NOR,add=TRUE,col="#CCCCFF",border="#CCCCFF")
plot(FIN,add=TRUE,col="#CCCCFF",border="#CCCCFF")
points(SamplesSPDF,cex=7,col="midnightblue",bg="midnightblue",pch=21)
#text(cbind(Samples[5]+2.5, Samples[4]+2.2),col="black",cex=6,"H")
dev.off()



png(filename="SamplingSitesworld.png",width=200,height=300,units='mm',res=700,pointsize=10)
par(xpd=NA,mar=c(0,0,0,0),oma=c(0,0,0,0),font=3,ps=10,bg="white")
#par(bg=NA,lwd=5,lty=2,oma=c(20,20,20,20))
plot(continents,col="NA",border="NA", bg="NA",xlim=c(15,20),ylim=c(50,73),main="")
plot(world,col="#CCCCFF",border="#CCCCFF",add=TRUE)
points(SamplesSPDF,cex=7,col="midnightblue",bg="midnightblue",pch=21)
#text(cbind(Samples[5]+2.5, Samples[4]+2.2),col="black",cex=6,"H")
dev.off()
