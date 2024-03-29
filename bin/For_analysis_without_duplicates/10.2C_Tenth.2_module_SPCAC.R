##Prerequisite libraries: SNPRelate (available on the package Bioconductor)
##and Tidyverse (available on the default CRAN of R)
##The archive is in directory (../Process/data/filtered/filtered_second/culti")

##Open the libraries
library(SNPRelate)
library(tidyverse)

##Transform the file .vcf into gds and prepare the popmap (used in the previous
##analyzes). We need a popmap with just samples described as cultivated
sfnc<- "cultian.recode.vcf"
snpgdsVCF2GDS(sfnc, "sfnc.gds", method="biallelic.only")
popflc<- c("pmap_nodC.txt")
infpopc<-read_tsv(popflc)
labelflc<-c("code_nodupC.txt")
infolabc<-read_tsv(labelflc)

##To prun the transformed data and extract the SNP
scgenef<-snpgdsOpen('sfnc.gds')
cprunsetsnps<-snpgdsLDpruning(scgenef, autosome.only = F, remove.monosnp = F, )
scetsnip.ids<- unlist(cprunsetsnps)

##Execute Principal Component Analysis
scAnPCA<-snpgdsPCA(scgenef, num.thread = 2, eigen.cnt = 16, snp.id = scetsnip.ids,
                 missing.rate = (0.1), maf = 0.10, autosome.only = F)

##Calculate the explained variation
scvar.exp<-scAnPCA$varprop*100
head(round(scvar.exp, 2))

#Do the data frame
scdatfra<-data.frame(name = scAnPCA$sample.id,
                   pop = infpopc$pop,
                   labname = infolabc$code,
                   Ei1 = scAnPCA$eigenvect[,1],  
                   Ei2 = scAnPCA$eigenvect[,2],    
                   stringsAsFactors = FALSE)

##Command line for a PCA with ggplot package
png(filename="pca5vp.png", width=1080, height=720)
ggplot(data=scdatfra,aes(Ei1,Ei2)) + geom_jitter(aes(color=pop), width=0.01,height=0.01, size = 5) + ylab("PC 2") + xlab("PC 1") + geom_text(aes(label=labname, hjust=0, vjust=0, color=pop, size = 18))


##Same analysis but strict

library(SNPRelate)
library(tidyverse)

##Transform the file .vcf into gds and prepare the popmap (used in the previous
##analyzes). We need a popmap just with samples described as cultivated
sfncs<- "cultians.recode.vcf"
snpgdsVCF2GDS(sfncs, "sfncs.gds", method="biallelic.only")
popflcs<- c("pmap_nodC.txt")
infpopcs<-read_tsv(popflcs)
labelflcs<-c("code_nodupC.txt")
infolabcs<-read_tsv(labelflcs)

##To prun the transformed data and extract the SNP
scsgenef<-snpgdsOpen('sfncs.gds')
csprunsetsnps<-snpgdsLDpruning(scsgenef, autosome.only = F, remove.monosnp = F, )
scsetsnip.ids<- unlist(csprunsetsnps)

##Execute Principal Component Analysis
scsAnPCA<-snpgdsPCA(scsgenef, num.thread = 2, eigen.cnt = 16, snp.id = scsetsnip.ids,
                 missing.rate = (0.8), maf = 0.10, autosome.only = F)

##Calculate the explained variation
scsvar.exp<-scsAnPCA$varprop*100
head(round(scsvar.exp, 2))

#Do the data frame
scsdatfra<-data.frame(name = scsAnPCA$sample.id,
                   pop = infpopcs$pop,
                   labname = infolabcs$code,
                   Ei1 = scsAnPCA$eigenvect[,1],  
                   Ei2 = scsAnPCA$eigenvect[,2],    
                   stringsAsFactors = FALSE)

##Command line for a PCA with ggplot package
png(filename="pca7vp.png", width=1080, height=720)
ggplot(data=scsdatfra,aes(Ei1,Ei2)) + geom_jitter(aes(color=pop), width=0.01,height=0.01, size = 5) + ylab("PC 2") + xlab("PC 1") + geom_text(aes(label=labname, hjust=0, vjust=0, color=pop, size = 18))
