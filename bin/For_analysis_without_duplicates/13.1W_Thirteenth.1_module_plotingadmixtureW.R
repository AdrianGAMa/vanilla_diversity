##For this module, we will do plots for the Admixture analysis, and check the
##population structure for V. planifolia wild and cultivated.

setwd("../Process/data/popstr/popscn/wild")

#Install and open the next libraries -> vcfR, adegenet, hierfstat, ggplot2, reshape2, gridExtra
install.packages("vcfR")
install.packages("adegenet")
install.packages("hierfstat")
install.packages("ggplot2")
install.packages("reshape2")
install.packages("gridExtra")
install.packages("patchwork")
install.packages("ggthemes")
install.packages("tidyverse")
library(vcfR)
library(adegenet)
library(hierfstat)
library(ggplot2)
library(tidyverse)
library(reshape2)
library(gridExtra)
library(patchwork)
library(ggthemes)

##We need do a new data frame with the code samples and population to each belongs to
##On the previous module, we copied the files "pmap_nodW.txt", "code_nodupW.txt" and "pest_ndW.txt"
##From the "filtered" directory, we will use the "pop" column from the "pmap_nod.txt", "pest_ndW.txt"
##And the "code" column from the "code_nodupW.txt". Remember, the popmap contains only samples described as wild

datpopw <- read.table("pmap_nodW.txt", header = T)
datindw <- read.table("code_nodupW.txt", header = T)
datregw <- read.table("pest_ndW.txt", header = T)
popindw <- data.frame(datindw$code, datpopw$pop, datregw$pop)

##Building the new data frame for the poblational structure (From Admixture haha)
K10W <- read.table("wildan2.10.Q")
K10W$ind <- popindw$datindw.code
K10W$pop <- popindw$datpopw.pop
K10W$reg <- popindw$datregw.pop
K10fW <- melt(K10W)

regwplot <- ggplot(K10fW, aes(factor(ind), value, fill = factor(variable)))+geom_bar(stat="identity")+facet_grid(~fct_inorder(reg), scales = "free", switch = "x", space = "free")+theme_minimal()+theme(axis.text.x=element_text(size=8,angle=45,hjust=1),axis.text.y=element_text(size=10),legend.position="none",axis.title.x=element_blank(),axis.title.y=element_text(size=11),strip.text.x=element_text(size=11))

popwplot <- ggplot(K10fW, aes(factor(ind), value, fill = factor(variable)))+geom_bar(stat="identity")+facet_grid(~fct_inorder(pop), scales = "free", switch = "x", space = "free")+theme_minimal()+theme(axis.text.x=element_text(size=8,angle=45,hjust=1),axis.text.y=element_text(size=10),legend.position="none",axis.title.x=element_blank(),axis.title.y=element_text(size=11),strip.text.x=element_text(size=11))

png(filename="struc4vp.png", width=1080, height=720)

regwplot + popwplot + plot_layout(ncol=1)


##Same analysis but strict

library(vcfR)
library(adegenet)
library(hierfstat)
library(ggplot2)
library(tidyverse)
library(reshape2)
library(gridExtra)
library(patchwork)
library(ggthemes)

##We need do a new data frame with the code samples and population to each belongs to
##On the previous module, we copied the files "pmap_nodW.txt", "code_nodupW.txt" and "pest_ndW.txt"
##From the "filtered" directory, we will use the "pop" column from the "pmap_nod.txt", "pest_ndW.txt"
##And the "code" column from the "code_nodupW.txt". Remember, the popmap contains only samples described as wild

datpopws <- read.table("pmap_nodW.txt", header = T)
datindws <- read.table("code_nodupW.txt", header = T)
datregws <- read.table("pest_ndW.txt", header = T)
popindws <- data.frame(datindws$code, datpopws$pop, datregws$pop)

##Building the new data frame for the poblational structure (From Admixture haha)
K10Ws <- read.table("wildans2.10.Q")
K10Ws$ind <- popindws$datindws.code
K10Ws$pop <- popindws$datpopws.pop
K10Ws$reg <- popindws$datregws.pop
K10fWs <- melt(K10Ws)

regwsplot <- ggplot(K10fWs, aes(factor(ind), value, fill = factor(variable)))+geom_bar(stat="identity")+facet_grid(~fct_inorder(reg), scales = "free", switch = "x", space = "free")+theme_minimal()+theme(axis.text.x=element_text(size=8,angle=45,hjust=1),axis.text.y=element_text(size=10),legend.position="none",axis.title.x=element_blank(),axis.title.y=element_text(size=11),strip.text.x=element_text(size=11))

popwsplot <- ggplot(K10fWs, aes(factor(ind), value, fill = factor(variable)))+geom_bar(stat="identity")+facet_grid(~fct_inorder(pop), scales = "free", switch = "x", space = "free")+theme_minimal()+theme(axis.text.x=element_text(size=8,angle=45,hjust=1),axis.text.y=element_text(size=10),legend.position="none",axis.title.x=element_blank(),axis.title.y=element_text(size=11),strip.text.x=element_text(size=11))

png(filename="struc6vp.png", width=1080, height=720)

regwsplot + popwsplot + plot_layout(ncol=1)



