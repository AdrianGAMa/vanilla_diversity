#!/bin/bash

#####Prerequisites, install Picard-tools, available on https://broadinstitute.github.io/picard/
##Or use the next command line in console
#sudo apt update
#sudo apt install picard-tools

###To sort sequences on Picard-tools

#Make a new directory for bam files
mkdir ../Process/data/wgenbam

###Convert sam files from directory vanilla_aln into bam files, with Picard tools

#To convert sample by sample
PicardCommandLine SamFormatConverter I=../Process/data/wgen_aln/"name_archive.sam" O=../Process/data/wgenbam/"name_archive.bam"

#To convert all the samples .sam in one command. In the final test, verify the weight of the archives, to check the proportionality of the weight in each file
for wgbam in `ls ../Process/data/wgen_aln | grep -oE "\w*" | uniq`; do
PicardCommandLine SamFormatConverter I=../Process/data/wgen_aln/${wgbam}.sam O=../Process/data/wgenbam/${wgbam}.bam
done

##For sort sequences with SortSam in Picard-Tools
##Make a new directory for data sorted
mkdir ../Process/data/wgsort

#To sort sample by sample
PicardCommandLine SortSam INPUT=../Process/data/wgenbam/"name_archieve.bam" OUTPUT=../Process/data/wgsort/name_archieve.bam SORT_ORDER=coordinate


#A loop to convert sort all files in one comand. In the final test, verify the weight of the archives, to check the proportionality of the weight in each file
for wgensort in `ls ../Process/data/wgenbam | grep -oE "\w*" | uniq`; do
PicardCommandLine SortSam INPUT=../Process/data/wgenbam/${wgensort}.bam OUTPUT=../Process/data/wgsort/${wgensort}st.bam SORT_ORDER=coordinate;
done


##For add a readgroup to archieves bam

##New directory for readgroups
mkdir ../Process/data/wgroups

#To add readgroup sample by sample
PicardCommandLine AddOrReplaceReadGroups INPUT=../Process/data/wgsort/"name_archive.bam" OUTPUT=../Process/data/wgroups/name_archive.bam RGID=sample RGLB=single-end RGPL=Illumina RGPU=unknown RGSM=sample

#A loop to add readgroups in one command
for wadd in `ls ../Process/data/wgsort | grep -oE "\w*" | uniq`; do
PicardCommandLine AddOrReplaceReadGroups INPUT=../Process/data/wgsort/${wadd}.bam OUTPUT=../Process/data/wgroups/${wadd}g.bam RGID=sample RGLB=single-end RGPL=Illumina RGPU=unknown RGSM=sample;
done
