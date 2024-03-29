#!/bin/bash

##Prerequisites, stacks ver.2.55 or superior.
##To generate loci and identify SNP's

##Make a directory for output archives
mkdir ../Process/data/gwens
mkdir ../Process/data/gwens/first_an

##Identify the samples to generate a directory with the samples of contain just V. planifolia. The file with the information is in "1_Calidad_secuencias.xlsx"
##Move or copy the archives to the new directory (pop_origin), this process need to do sample by sample (total = 77 archives)
mkdir ../Process/data/pop_origin

##Create a population map, identifying each sample if are wild or cultivated. To do this map, write in a text file (on editor text) <name_sample><tab><population>
##save as a -.tsv file. More information on https://catchenlab.life.illinois.edu/stacks/manual/#popmap

##To generate loci and identify SNP's
stacks gstacks -I ../Process/data/pop_origin -O ../Process/data/gwens/first_an -M ../Process/data/"popmap_orig.tsv"
