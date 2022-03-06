#!/bin/bash

pgdJAR=~/Downloads/PGDSpider_2.1.1.5/PGDSpider2-cli.jar
inFILE=~/Projects/PuntioplitesFalcifer/fltrVCF_4revision/Pfalcifer.3.7.Fltr20.2.randSNPperLoc.neutral.recode.vcf
inFORMAT=VCF
outFileEXT=arp
outFORMAT=ARLEQUIN
spidFILE=~/Projects/PuntioplitesFalcifer/pgdspider/vcf2arlequin.spid

outFILE=$(basename $inFILE | sed "s/\.vcf/\.$outFileEXT/")

source ~/anaconda3/etc/profile.d/conda.sh
conda activate pgdspider
java -Xmx1024m -Xms512m -jar $pgdJAR \
	-inputfile $inFILE \
	-inputformat $inFORMAT \
	-outputfile $outFILE \
	-outputformat $outFORMAT \
	-spid $spidFILE
