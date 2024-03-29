#!/bin/bash

##This module is necessary to concatenate the reads to eliminate duplicates in each sample
##Consult the data to know duplicated samples

#New directory just for concatenated data
mkdir ../Process/data/ensambled_pair

##To concatenate samples and move to the new directory (samples are in the directory called data_trimmed)
#Note: The name of the archieve concatenated
#is the first three characters of the first sample.
cat ***_trimmed.fq.gz ***_trimmed.fq.gz > *** | mv *** ../Process/data/ensambled_pair


##For this analysis (without duplicates just for V. planifolia in each state), copy the samples concatenated and move to a new directory
##Consult the quality sequences file to place the samples that are not duplicated in the same directory for later analysis.
##The sequences that are not duplicated are in "data_trimmed" directory, move to "anest" directory

mkdir ../Process/data/anest
mv ../Process/data/ensambled_pair/*.fq.gz ../Process/data/anest

##Homogeneize the names in all the files. As a suggestion, use just the first three characters corresponding to the samples
##wells, like ("A01, A02... C02", etc.).
