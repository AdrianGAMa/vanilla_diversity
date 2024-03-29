#!/bin/bash

##Prerequisites on this module, software BWA Burrows-Wheeler Aligner ver.0.7.17 (available on https://sourceforge.net/projects/bio-bwa/files/)  or use the next command on console (on Linux)

# sudo apt update
# sudo apt install bwa

##To create a directory for the sequences of the genome reference of Vanilla (Whole genome) and index
mkdir ../Process/data/wgen

##Download the whole genome of vanilla in next link -> https://www.ncbi.nlm.nih.gov/assembly/GCA_016413895.1
##Whole genome is divide on chromosomes, download in fasta format all the visible range.

##Use the cat command to concatenate the sequences of the whole genome
##Before this step, rename the archives to better use and move the files to "wgen" directory
###Important note. Erase colon in all fasta files of reference genome!! This is important because the populations module on Stacks don't recognize the format with colon on header
cat ../Process/data/wgen/"c1.fa" "c2.fa" "c3.fa" "c4.fa" "c5.fa" "c6.fa" "c7.fa" "c8.fa" "c9.fa" "c10.fa" "c11.fa" "c12.fa" "c13.fa" "c14.fa" > wrefgen.fa

##Create the index with the genome reference (in format fasta)
##Opcional use flag -a is/bwtsw to inditcate the length in sequences (short or long respectively)
bwa index ../Process/data/wgen/wrefgen.fa ../Process/data/wgen/wrefgen


##Create a directory for the alignment sequences
mkdir ../Process/data/wgen_aln


#####To use the package bwa-mem in just one sample
bwa mem -t 4 -p ../Process/data/wrefgen/wrefgen.fa ../Process/data/anest/***.fq.gz > ../Process/data/wgen_aln/name_archive.sam

##Built a loop for data trimmed to alignment in one comand

for alignment in `ls ../Process/data/anest/ | grep -oE "\w*" | uniq`;
do bwa mem -t 4 -p ../Process/data/wgen/wrefgen.fa ../Process/data/anest/${alignment}.fq.gz > ../Process/data/wgen_aln/${alignment}.sam;
done


##Erase incorrect output files if exist. Total of output archives -> 61
