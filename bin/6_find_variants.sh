## This script to find and annotate genomic variants 
## Prerequisites: NGSEP 3.3.0 & 4.0.2
## This scripts is ./bin and data are ../vanilla/data/map

## The fai index 

samtools faidx  ../vanilla/data/reference/chloroplast_vp.fasta

## Find variants
for R in `ls ../vanilla/data/map | grep -oE "\w*.fq.gz" | uniq`;
do java -jar -Xms60000M -Xmx60000M ../NGSEPcore_3.3.0.jar FindVariants -maxAlnsPerStartPos 100 -csb -ploidy 1 -psp ../vanilla/data/reference/chloroplast_vp.fasta ../vanilla/data/map/${R}sortedRG.bam ../vanilla/data/map/${R} >& ../vanilla/data/map/${R}.log;
done
mv *.vcf ../../bin
## Merge vcfs

java -jar -Xms3500M -Xmx3500M ../NGSEPcore_3.3.2/NGSEPcore_3.3.1.jar MergeVCF ../vanilla/data/reference/chloroplast_vp.fasta.fai ./A01.vcf ./A02.vcf ./A05.vcf ./A07.vcf ./A08.vcf ./A09.vcf ./B01.vcf ./B02.vcf ./C02.vcf ./C04.vcf ./D04.vcf ./D05.vcf ./D06.vcf ./D07.vcf ./D08.vcf ./D09.vcf ./D10.vcf ./D11.vcf 1> ./wild_vp.vcf 2> ./wild_vp.log

java -jar -Xms3500M -Xmx3500M ../NGSEPcore_3.3.2/NGSEPcore_3.3.0.jar MergeVCF ../vanilla/data/reference/chloroplast_vp.fasta.fai ./A03.vcf ./B06.vcf ./B08.vcf ./B10.vcf ./B11.vcf ./B12.vcf ./C05.vcf ./C09.vcf ./C10.vcf ./C11.vcf ./C12.vcf ./D01.vcf ./D02.vcf ./D03.vcf ./D12.vcf ./E01.vcf ./E02.vcf ./E03.vcf ./E04.vcf ./E06.vcf ./E08.vcf ./E09.vcf ./E10.vcf ./E11.vcf ./E12.vcf ./F01.vcf ./F02.vcf ./F03.vcf ./F04.vcf ./F05.vcf ./H04.vcf ./H05.vcf ./H06.vcf ./H07.vcf ./H08.vcf ./H09.vcf ./H11.vcf 1> ./dome_vp.vcf 2> ./dome_vp.log

java -jar -Xms3500M -Xmx3500M ../NGSEPcore_3.3.2/NGSEPcore_3.3.1.jar MergeVCF ../vanilla/data/reference/chloroplast_vp.fasta.fai ./A01.vcf ./A02.vcf ./A05.vcf ./A07.vcf ./A08.vcf ./A09.vcf ./B01.vcf ./B02.vcf ./C02.vcf ./C04.vcf ./D04.vcf ./D05.vcf ./D06.vcf ./D07.vcf ./D08.vcf ./D09.vcf ./D10.vcf ./D11.vcf ./A03.vcf ./B06.vcf ./B08.vcf ./B10.vcf ./B11.vcf ./B12.vcf ./C05.vcf ./C09.vcf ./C10.vcf ./C11.vcf ./C12.vcf ./D01.vcf ./D02.vcf ./D03.vcf ./D12.vcf ./E01.vcf ./E02.vcf ./E03.vcf ./E04.vcf ./E06.vcf ./E08.vcf ./E09.vcf ./E10.vcf ./E11.vcf ./E12.vcf ./F01.vcf ./F02.vcf ./F03.vcf ./F04.vcf ./F05.vcf ./H04.vcf ./H05.vcf ./H06.vcf ./H07.vcf ./H08.vcf ./H09.vcf ./H11.vcf 1> all_vp.vcf 2> all_vp.log


java -jar -Xms3500M -Xmx3500M ../NGSEPcore_3.3.2/NGSEPcore_3.3.0.jar FilterVCF -q 40 -d 10 -s -fi -minMAF 0.05 -fs ./wild_vp.vcf 1> ./wild_vp2.vcf


java -jar -Xms3500M -Xmx3500M ../NGSEPcore_3.3.2/NGSEPcore_3.3.0.jar FilterVCF -q 40 -d 10 -s -fi -minMAF 0.05 -fs ./dome_vp.vcf 1> ./dome_vp2.vcf

java -jar -Xms3500M -Xmx3500M ../NGSEPcore_3.3.2/NGSEPcore_3.3.0.jar FilterVCF -q 40 -d 10 -s -fi -minMAF 0.05 -fs ./all_vp.vcf 1> ./all_vp2.vcf

#### Annotate variants
java -jar -Xms3500M -Xmx3500M ../NGSEPcore_4.0.3.jar VCFAnnotate -i ./all_vp2.vcf -t ../vanilla/data/reference/sequence.gff3 -r ../vanilla/data/reference/chloroplast_vp.fasta -o ./allannotated.vcf

java -jar -Xms3500M -Xmx3500M ../NGSEPcore_4.0.3.jar VCFAnnotate -i ./wild_vp2.vcf -t ../vanilla/data/reference/sequence.gff3 -r ../vanilla/data/reference/chloroplast_vp.fasta -o ./wildannotated.vcf

java -jar -Xms3500M -Xmx3500M ../NGSEPcore_4.0.3.jar VCFAnnotate -i ./dome_vp2.vcf -t ../vanilla/data/reference/sequence.gff3 -r ../vanilla/data/reference/chloroplast_vp.fasta -o ./domeannotated.vcf
