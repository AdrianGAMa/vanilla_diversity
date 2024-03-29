#!/bin/bash

##For call variants on VCFtools. Prerequisites VCFtools ver. 0.1.16
#For the VCFtools installation on console
sudo apt install vcftools

##Do a directory for the analysis output
mkdir ../Process/data/filtered
##Do a second directory for this module analysis
mkdir ../Process/data/filtered/filtered_second

##Do a new archive with filters applied
vcftools --vcf ../Process/data/popf/second_an/"populations.snps.vcf" --out ../Process/data/filtered/filtered_second/secondstr --maf 0.1 --min-meanDP 10 --max-meanDP 1000 --max-missing (0.8 o 0.9) --remove-filtered-all --recode

##For the analysis with VCFtools
vcftools --vcf ../Process/data/popf/second_an/"populations.snps.vcf" --out ../Process/data/filtered/filtered_second/secondstr --maf 0.1 --min-meanDP 10 --max-meanDP 1000 --max-missing 0.8 --remove-filtered-all [-some_analysis*]
#*This module consists in five parts, because VCFtools do just one analysis for each command line, so its
#necessary replace the last flag with the requeried analysis
##Analyzes executed

*.... --hardy
*.... --het
*.... --TajimaD 10000
*.... --site-pi
*.... --SNPdensity 1000000


